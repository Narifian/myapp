import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'db/database_helper.dart';
import 'models/laporan.dart';
import 'dart:io';
import 'laporan_dalam_proses.dart'; // Import halaman laporan dalam proses

class LaporanKerusakanScreen extends StatefulWidget {
  @override
  _LaporanKerusakanScreenState createState() => _LaporanKerusakanScreenState();
}

class _LaporanKerusakanScreenState extends State<LaporanKerusakanScreen> {
  final TextEditingController _deskripsiController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitLaporan() async {
    if (_deskripsiController.text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Isi deskripsi dan pilih gambar')),
      );
      return;
    }

    Laporan laporan = Laporan(
      deskripsi: _deskripsiController.text,
      fotoPath: _selectedImage!.path,
      status: 'Dalam Proses',
    );

    await _dbHelper.insertLaporan(laporan);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Laporan berhasil dikirim')),
    );

    _deskripsiController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Kerusakan'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaporanDalamProsesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Kerusakan',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(_selectedImage!, width: 200, height: 200, fit: BoxFit.cover)
                : Text('Tidak ada gambar terpilih'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _pickImageFromCamera, child: Text('Ambil Gambar')),
                ElevatedButton(onPressed: _pickImageFromGallery, child: Text('Pilih Gambar')),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitLaporan,
              child: Text('Kirim Laporan'),
            ),
          ],
        ),
      ),
    );
  }
}
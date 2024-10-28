import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/laporan.dart';

class LaporanDalamProsesScreen extends StatefulWidget {
  @override
  _LaporanDalamProsesScreenState createState() =>
      _LaporanDalamProsesScreenState();
}

class _LaporanDalamProsesScreenState extends State<LaporanDalamProsesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Laporan> _laporanList = [];

  @override
  void initState() {
    super.initState();
    _loadLaporanProses(); // Load laporan saat inisialisasi widget
  }

  // Fungsi untuk memuat laporan dengan status "Dalam Proses"
  Future<void> _loadLaporanProses() async {
    final laporanList = await _dbHelper.getLaporanProses();
    setState(() {
      _laporanList = laporanList;
    });
  }

  // Fungsi untuk mengubah status laporan menjadi "Selesai"
  Future<void> _ubahStatusLaporan(int id) async {
    bool? konfirmasi = await _tampilkanDialogKonfirmasi(); // Dialog konfirmasi

    if (konfirmasi == true) {
      await _dbHelper.updateStatusLaporan(id, 'Selesai'); // Ubah status di database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status berhasil diubah menjadi Selesai')),
      );
      _loadLaporanProses(); // Refresh data laporan
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  Future<bool?> _tampilkanDialogKonfirmasi() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ubah Status'),
        content: Text('Apakah Anda yakin ingin mengubah status menjadi Selesai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laporan dalam Proses')),
      body: _laporanList.isEmpty
          ? Center(child: Text('Tidak ada laporan dalam proses'))
          : ListView.builder(
              itemCount: _laporanList.length,
              itemBuilder: (context, index) {
                final laporan = _laporanList[index];
                return ListTile(
                  leading: Icon(Icons.build, color: Colors.orange),
                  title: Text(laporan.deskripsi),
                  subtitle: Text('Status: ${laporan.status}'),
                  trailing: IconButton(
                    icon: Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => _ubahStatusLaporan(laporan.id!), // Panggil fungsi ubah status
                  ),
                  onTap: () {
                    // Bisa ditambahkan logika untuk membuka detail laporan jika dibutuhkan
                  },
                );
              },
            ),
    );
  }
}

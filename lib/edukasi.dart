import 'package:flutter/material.dart';

class EdukasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edukasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Tips Merawat Fasilitas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Lakukan pengecekan rutin.\n'
              '2. Bersihkan fasilitas setelah digunakan.\n'
              '3. Laporkan kerusakan secepat mungkin.\n'
              '4. Gunakan fasilitas sesuai fungsinya.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laporan_kerusakan_fasilitas/laporan_kerusakan.dart';
import 'package:laporan_kerusakan_fasilitas/laporan_dalam_proses.dart';
import 'package:laporan_kerusakan_fasilitas/edukasi.dart';
import 'package:laporan_kerusakan_fasilitas/tentang_aplikasi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laporan Kerusakan Fasilitas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Kerusakan Fasilitas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Membuat 2 kolom
          crossAxisSpacing: 10, // Jarak antar kolom
          mainAxisSpacing: 10, // Jarak antar baris
          children: [
            _buildMenuCard(
              context,
              icon: Icons.report_problem,
              label: 'Buat Laporan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaporanKerusakanScreen(),
                  ),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.history,
              label: 'Laporan Proses',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaporanDalamProsesScreen(),
                  ),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.school,
              label: 'Edukasi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EdukasiScreen(),
                  ),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.info,
              label: 'Tentang Aplikasi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TentangAplikasiScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat kotak menu
  Widget _buildMenuCard(
      BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

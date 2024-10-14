import 'package:flutter/material.dart';

class LaporanDalamProsesScreen extends StatelessWidget {
  final List<String> laporanProses = [
    'Kerusakan Lampu di Taman - Dalam Proses',
    'Kursi Rusak di Ruang Tunggu - Dalam Perbaikan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laporan dalam Proses')),
      body: ListView.builder(
        itemCount: laporanProses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.build, color: Colors.orange),
            title: Text(laporanProses[index]),
          );
        },
      ),
    );
  }
}

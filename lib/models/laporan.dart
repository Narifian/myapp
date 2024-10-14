class Laporan {
  int? id;
  String deskripsi;
  String fotoPath;
  String status;

  Laporan({this.id, required this.deskripsi, required this.fotoPath, required this.status});

  // Konversi dari Map (database) ke Laporan
  factory Laporan.fromMap(Map<String, dynamic> map) {
    return Laporan(
      id: map['id'],
      deskripsi: map['deskripsi'],
      fotoPath: map['fotoPath'],
      status: map['status'],
    );
  }

  // Konversi dari Laporan ke Map (untuk database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deskripsi': deskripsi,
      'fotoPath': fotoPath,
      'status': status,
    };
  }
}

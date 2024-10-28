class Laporan {
  final int? id;
  final String deskripsi;
  final String fotoPath;
  final String status;

  Laporan({
    this.id,
    required this.deskripsi,
    required this.fotoPath,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deskripsi': deskripsi,
      'fotoPath': fotoPath,
      'status': status,
    };
  }

  factory Laporan.fromMap(Map<String, dynamic> map) {
    return Laporan(
      id: map['id'],
      deskripsi: map['deskripsi'],
      fotoPath: map['fotoPath'],
      status: map['status'],
    );
  }
}

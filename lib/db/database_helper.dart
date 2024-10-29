import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:laporan_kerusakan_fasilitas/models/laporan.dart';

class DatabaseHelper {
  // Singleton Pattern: Membatasi agar hanya ada satu instance DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Getter untuk mendapatkan database, akan menginisialisasi jika belum ada
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database dan membuat tabel jika belum ada
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'laporan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE laporan(id INTEGER PRIMARY KEY, deskripsi TEXT, fotoPath TEXT, status TEXT)',
        );
      },
    );
  }

  // Fungsi untuk memasukkan laporan baru ke dalam database
  Future<void> insertLaporan(Laporan laporan) async {
    final db = await database;
    await db.insert('laporan', laporan.toMap());
  }

  // Fungsi untuk mengambil laporan yang sedang dalam proses
  Future<List<Laporan>> getLaporanProses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'laporan',
      where: 'status = ?',
      whereArgs: ['Dalam Proses'],
    );

    return List.generate(maps.length, (i) {
      return Laporan.fromMap(maps[i]);
    });
  }

  // Fungsi untuk memperbarui status laporan berdasarkan ID
  Future<void> updateStatusLaporan(int id, String status) async {
    final db = await database;
    await db.update(
      'laporan',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

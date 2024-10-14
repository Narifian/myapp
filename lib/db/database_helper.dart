import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/models/laporan.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'laporan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE laporan(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            deskripsi TEXT,
            fotoPath TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertLaporan(Laporan laporan) async {
    final db = await database;
    print('Inserting report: ${laporan.toMap()}'); // Debug
    return await db.insert('laporan', laporan.toMap());
  }

  Future<List<Laporan>> getLaporanList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('laporan');
    print('Retrieved reports: $maps'); // Debug
    return List.generate(maps.length, (i) => Laporan.fromMap(maps[i]));
  }
}

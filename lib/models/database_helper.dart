import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  String eventsTable = 'events';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colImageUrl = 'imageUrl';
  String colEventDescription = 'eventDescription';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'events.db');
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $eventsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDescription TEXT,
        $colImageUrl TEXT,
        $colEventDescription TEXT
      )
    ''');
  }

  Future<int> insertEvent(EventModel event) async {
    final db = await database;
    int rowId = await db.insert(
      eventsTable,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Data stored with row ID: $rowId');
    return rowId;
  }

  Future<List<EventModel>> getEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(eventsTable);
    return List.generate(maps.length, (i) {
      return EventModel(
        title: maps[i][colTitle],
        description: maps[i][colDescription],
        imageUrl: maps[i][colImageUrl],
        eventDescription: maps[i][colEventDescription],
      );
    });
  }

  Future<void> clearEvents() async {
    final db = await database;
    await db.delete(eventsTable);
  }
}
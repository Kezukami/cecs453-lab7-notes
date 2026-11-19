import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'note_model.dart';

class DBHelper {
  DBHelper._internal();
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = join(await getDatabasesPath(), 'cecs453_notes.db');
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
    return _database!;
  }

  Future<int> insertNote(Note note) async =>
      (await database).insert('notes', note.toMap());

  Future<List<Note>> getNotes() async {
    final rows = await (await database).query('notes', orderBy: 'id DESC');
    return rows.map(Note.fromMap).toList();
  }

  Future<int> updateNote(Note note) async => (await database).update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );

  Future<int> deleteNote(int id) async => (await database).delete(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'precobom');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(
        'CREATE TABLE tb_logged_user (id INTEGER PRIMARY KEY, email TEXT, role TEXT, token TEXT)');
  }, version: 1);
}

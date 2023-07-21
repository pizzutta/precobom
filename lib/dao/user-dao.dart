import 'package:precobom/dao/open-database.dart';
import 'package:precobom/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  save(User user) async {
    final Database database = await getDatabase();
    database.insert("tb_logged_user", user.toMap());
  }

  delete(User user) async {
    final Database database = await getDatabase();
    database.delete("tb_logged_user", where: "id = ?", whereArgs: [user.id]);
  }

  Future<User?> getLoggedUser() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result =
        await database.query("tb_logged_user");

    if (result.isNotEmpty) {
      return List.generate(
          result.length,
          (i) => User(result[i]['id'], result[i]['email'], result[i]['role'],
              result[i]['token']))[result.length - 1];
    } else {
      return null;
    }
  }
}

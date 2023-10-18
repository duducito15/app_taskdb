import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Database? myDatabase;

  //Singleton
  static final DbAdmin db = DbAdmin._();
  DbAdmin._();

  Future<Database?> checkDataBase() async {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDataBase(); // crear la base de datos
    return myDatabase;
  }

  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        //Crear la tabla
        await dbx.execute(
            "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");
      },
    );
  }
}

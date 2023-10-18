import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Database? myDatabase;

  //Singleton
  static final DbAdmin db = DbAdmin._();
  DbAdmin._();

  checkDataBase() {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = initDataBase(); // crear la base de datos
    return myDatabase;
  }

  initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) {
        //Crear la tabla
        dbx.execute(
            "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");
      },
    );
  }
}

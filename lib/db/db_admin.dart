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

  insertRawTask() async {
    Database? db = await checkDataBase();
    int res = await db!.rawInsert(
      "INSERT INTO TASK(title, description, status) VALUES('Comprar','Ir al super a comprar','verdad')",
    );
    print(res);
  }

  insertTask() async {
    Database? db = await checkDataBase();
    int res = await db!.insert(
      "TASK",
      {
        "title": "Vender",
        "description": "Lo comprado en el super",
        "status": "verdad",
      },
    );
    print(res);
  }

  getRawTask() async {
    Database? db = await checkDataBase();
    List tasks = await db!.rawQuery("SELECT * FROM TASK");
    print(tasks);
  }

  getTask() async {
    Database? db = await checkDataBase();
    List tasks = await db!.query("TASK");
    print(tasks);
  }

  updateRawTask() async {
    Database? db = await checkDataBase();
    int res = await db!.rawUpdate(
      "UPDATE TASK SET title='Visitar', description='las ruinas de saylla',status ='falso' WHERE id = 6",
    );
    print(res);
  }

  updateTask() async {
    Database? db = await checkDataBase();
    int res = await db!.update(
      "TASK",
      {
        "title": "Ir al cine",
        "description": "para ver spiderman 2",
        "status": "falso",
      },
      where: "id = 2",
    );
    print(res);
  }

  deleteRawTask() async {
    Database? db = await checkDataBase();
    int res = await db!.rawDelete("DELETE FROM TASK WHERE id = 6");
    print(res);
  }

  deleteTask() async {
    Database? db = await checkDataBase();
    int res = await db!.delete("TASK", where: "id = 5");
    print(res);
  }
}

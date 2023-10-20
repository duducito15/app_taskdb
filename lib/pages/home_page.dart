import 'package:app_taskdb/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.checkDataBase();
              },
              child: Text("Inicializar Base de Datos"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.insertTask();
              },
              child: Text("Insertar Data"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.getTask();
              },
              child: Text("Mostrar Data"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.updateTask();
              },
              child: Text("Actualizar Data"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.deleteTask();
              },
              child: Text("Borrar Data"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; //для работы с скл
import 'package:path/path.dart'; //помогает корректно собирать пути к файлам

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Demo',
      home: NotesPage(),
      debugShowCheckedModeBanner: false, //убирает баннер
    );
  }
}

class NotesPage extends StatefulWidget { //экран с состоянием
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Database db; //для объекта базы данных
  final TextEditingController controller = TextEditingController(); //получить введённую заметку и очистить поле
  List<Map<String, dynamic>> notes = []; //список заметок

  @override
  void initState() { //чтобы открыть/создать базу
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase( //оздаёт файл базы
      join(await getDatabasesPath(), 'notes.db'), //возвращает путь
      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY, text TEXT)');
      },
      version: 1, //версия схемы
    );
    loadNotes(); //загрузить существующие записи
  }

  Future<void> loadNotes() async {
    final data = await db.query('notes'); //делает SELECT * FROM notes и возвращает
    setState(() { //обновляет состояние
      notes = data;
    });
  }

  Future<void> addNote() async { //добавляет новую запись в таблицу
    if (controller.text.isNotEmpty) { //проверка на пустоту
      await db.insert('notes', {'text': controller.text}); //вставить в таблицу notes в колонку text
      controller.clear(); //чищем поле ввода
      loadNotes();
    }
  }

  Future<void> deleteNote(int id) async { //удаляет заметку
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes (SQLite)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter note...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: addNote, child: Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note['text']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteNote(note['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //выполнение http  запросов
import 'dart:convert'; // для обработки JSON

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Demo',
      home: CatImageScreen(), //экран с котом
      debugShowCheckedModeBanner: false, //убирает банер
    );
  }
}

class CatImageScreen extends StatefulWidget { //измен данные
  @override
  _CatImageScreenState createState() => _CatImageScreenState(); //хранение переменных
}

class _CatImageScreenState extends State<CatImageScreen> {
  String? imageUrl; // ссылка на картинку кота
  bool isLoading = false; //идёт ли загрузка

  Future<void> fetchCatImage() async { //выполнение запроса
    setState(() {
      isLoading = true;
    });

    // запрос к API
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

    if (response.statusCode == 200) { //успешный ответ
      final data = json.decode(response.body); //превращает JSON-строку в структуру Dart
      setState(() {
        imageUrl = data[0]['url']; //выдача картинок
        isLoading = false;
      });
    } else {
      setState(() { //обнова картин
        imageUrl = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat API Demo')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : imageUrl == null
            ? Text('Press button to load a cat ')
            : Image.network(imageUrl!), // загрузка картинки из интернета
      ),
      floatingActionButton: FloatingActionButton( //виджет кнопки
        onPressed: fetchCatImage, //обработка нажатия
        child: Icon(Icons.refresh), //иконка
      ),
    );
  }
}

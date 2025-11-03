import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> fruits = [ //создание списка, лист, не изменяется
    '🍎 Apple',
    '🍌 Banana',
    '🍇 Grapes',
    '🍉 Watermelon',
    '🍍 Pineapple',
    '🥭 Mango',
    '🍓 Strawberry',
    '🍑 Peach',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits List',
      theme: ThemeData( //задаёт цветовую тему и шрифт
        primarySwatch: Colors.teal, // Цвет темы
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fruits List'),
          centerTitle: true,
        ),
        body: ListView.builder( //список с прокруткой
          itemCount: fruits.length,
          itemBuilder: (context, index) { //функция, которая создаёт один элемент списка по индексу
            return Card( //создание карточки фрукты
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6), // отступы
              child: ListTile(
                leading: CircleAvatar( //элемент слева
                  backgroundColor: Colors.teal.shade100, //цвет фона
                  child: Text(fruits[index][0]),
                ),
                title: Text(fruits[index]), //текст
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}

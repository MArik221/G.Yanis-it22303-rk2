import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Корневой виджет приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & State Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterScreen(), // стартовый экран
    );
  }
}

// Экран №1 — счётчик
class CounterScreen extends StatefulWidget { //измен данные
  @override
  _CounterScreenState createState() => _CounterScreenState();//хранение состояния
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0; // кол во нажатий

  void increment() {
    setState(() { //после этого будут менятся значения
      counter++; // обновляем состояние
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //базовый экран
      appBar: AppBar(title: Text('Counter Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('натыканно: $counter', style: TextStyle(fontSize: 24)), //вставка переменной прямо в текст
            SizedBox(height: 16),
            ElevatedButton( //кнопка
              onPressed: increment, //что произайдёт
              child: Text('тыкать'),
            ),
            ElevatedButton(
              onPressed: () {
                // Навигация на второй экран
                Navigator.push( //открывает 2 экран
                  context,
                  MaterialPageRoute( //переход с анимацией
                    builder: (context) => DetailsScreen(value: counter), //передаёт значение
                  ),
                );
              },
              child: Text('инфо'),
            ),
          ],
        ),
      ),
    );
  }
}

//  Экран №2 — показывает переданное значение
class DetailsScreen extends StatelessWidget {
  final int value; //переменная для хранения
  DetailsScreen({required this.value}); //передача данных

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Screen')),
      body: Center(
        child: Text(
          'вы натыкали: $value',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

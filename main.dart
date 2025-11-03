import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //обёртка
      title: 'Simple Counter',
      home: CounterScreen(), //вывод экрана
    );
  }
}

class CounterScreen extends StatefulWidget { //счётчик, изменения интерфейса
  @override
  State<CounterScreen> createState() => _CounterScreenState();//тут хранится логика
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0; // переменная состояния

  void increase() { //вызываеься при нажатии
    setState(() { //для обновления экрана
      count++; // изменяем состояние
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('unit 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //выравнивание по центру
          children: [
            Text(
              'You pressed the button:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$count times',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton( //кнопка
              onPressed: increase, // вызов при нажатии счётчика
              child: Text('ТЫКАЙ!'),
            ),
          ],
        ),
      ),
    );
  }
}

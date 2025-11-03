import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

// Ключ задачи
const myTask = "simpleTask";

// Это функция, которая будет выполняться в фоне
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Фоновая задача выполнена: $task");
    return Future.value(true);
  });
}

void main() {
  // Инициализация WorkManager
  Workmanager().initialize(
    callbackDispatcher, // функция выше
    isInDebugMode: true, // показывает логи в консоли
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkManager Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('WorkManager Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Регистрация фоновой задачи
              Workmanager().registerPeriodicTask(
                "1",
                myTask,
                frequency: const Duration(minutes: 15), // повтор каждые 15 мин
              );
            },
            child: const Text("Запустить фоновую задачу"),
          ),
        ),
      ),
    );
  }
}

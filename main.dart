import 'package:flutter/material.dart'; //подключение визуала

void main() { //точка вхрда
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //стабильные данные
  @override
  Widget build(BuildContext context) { //работаем и возвращаем виджеты
    return MaterialApp( //стиль приложения
      home: Scaffold( //главный экран и скелет экрана
        appBar: AppBar(title: Text('заходят как то в бар немец русский и....')),
        body: Center( //основная часть, центрирование контента
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //выравнивание
            children: [ //список виджетов
              Text(
                'это моя кукуха)!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),// стиль текста
              ),
              SizedBox(height: 20), // отступ от текста и картинки
              Image.network( //вывод изображения по url
                'https://i1.sndcdn.com/avatars-dy0BOVCe3Suy2RJh-X1ui2A-t1080x1080.jpg',
                width: 150, //размер изображения
              ),
            ],
          ),
        ),
      ),
    );
  }
}

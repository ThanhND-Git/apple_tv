import 'package:flutter/material.dart';
import 'package:apple_tv/shared_preferences/shared_preferences.dart';

import 'screens/home_page/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.initSharedPreferences();
  runApp(const MyApp());
}
// void main(){
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple TV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey.shade800,
        iconTheme: const IconThemeData(color: Color(0xffee0342)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(0xffee0342),
          ),
          titleMedium: TextStyle(color: Color(0xffee0342)),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

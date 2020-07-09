import 'package:flutter/material.dart';

import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doarti Trainee',
      theme: ThemeData(primarySwatch: Colors.pink, accentColor: Colors.amber),
      routes: {
        '/': (context) => LoginScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}

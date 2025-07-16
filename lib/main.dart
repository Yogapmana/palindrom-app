import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/first_screen.dart'; // Ganti dengan path yang sesuai
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen(), // Ganti dengan screen pertama Anda
        debugShowCheckedModeBanner: false,
        // Tambahkan routes configuration
        routes: {
          '/second': (context) => const SecondScreen(),
          '/third': (context) => ThirdScreen(),
        },
        // Atau gunakan onGenerateRoute untuk handling route dengan arguments
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/second':
              return MaterialPageRoute(
                builder: (context) => const SecondScreen(),
                settings: settings,
              );
            case '/third':
              return MaterialPageRoute(
                builder: (context) => ThirdScreen(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
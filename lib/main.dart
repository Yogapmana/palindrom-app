import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen(),
        debugShowCheckedModeBanner: false,
        //
        routes: {
          '/second': (context) => const SecondScreen(),
          '/third': (context) => ThirdScreen(),
        },
        //
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
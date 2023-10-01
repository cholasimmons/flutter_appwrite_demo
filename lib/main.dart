import 'package:appwrite_demo/_appwrite/auth_api.dart';
import 'package:appwrite_demo/_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => AuthAPI(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    print('Status changed: $value');

    return MaterialApp(
      title: 'Programmers App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(color: Colors.amber),
        useMaterial3: true,
      ),
      home: const MainHomePage(title: 'Programmers'),
      debugShowCheckedModeBanner: false,
    );
  }
}

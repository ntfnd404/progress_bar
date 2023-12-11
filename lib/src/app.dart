import 'package:flutter/material.dart';
import 'package:progress_bar/src/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'KegelFit',
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      );
}

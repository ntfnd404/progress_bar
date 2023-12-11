import 'package:flutter/material.dart';
import 'package:progress_bar/src/features/home_screen/widget/progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: ProgressBar(
            dotColor: Colors.blue,
            filedDotColor: Colors.red,
            thumbColor: Colors.black,
            thumbHeight: 20,
            initialThumbValue: 0.5,
          ),
        ),
      ),
    );
  }
}

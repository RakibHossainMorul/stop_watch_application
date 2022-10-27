import 'package:flutter/material.dart';
import 'package:stop_watch_application/stop_watch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StopWatchApp(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sunmiiiiiiiiiiiiiiiiiiii/test/ticket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunmi Printer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicketCounterApp(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:draggable_float/draggable_float.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FloatingWidgetExample());
  }
}

class FloatingWidgetExample extends StatelessWidget {
  const FloatingWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draggable Float Example')),
      body: FloatingWidget(
        floatingWidget: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
        initialAlignment: FloatingAlignment.bottomRight,
        padding: const EdgeInsets.all(16),
        snapToEdge: true,
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
          ),
        ),
      ),
    );
  }
}

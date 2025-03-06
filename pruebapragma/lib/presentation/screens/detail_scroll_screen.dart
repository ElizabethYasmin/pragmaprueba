import 'package:flutter/material.dart';

class DetailScrollScreen extends StatelessWidget {
  const DetailScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Scroll')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    );
  }
}
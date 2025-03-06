import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landing Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/detail'),
          child: const Text('Ir a Detalles'),
        ),
      ),
    );
  }
}
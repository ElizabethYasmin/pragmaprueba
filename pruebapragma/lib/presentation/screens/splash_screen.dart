import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebapragma/core/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/landing');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Catbreeds',
              style: AppTheme.titleStyle,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/cat_logo.png',
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

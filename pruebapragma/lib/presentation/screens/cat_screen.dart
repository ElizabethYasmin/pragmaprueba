import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cat_provider.dart';

class CatScreen extends ConsumerWidget {
  const CatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cats = ref.watch(catsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cats')),
      body: cats.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final cat = data[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: Image.network(cat.url),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

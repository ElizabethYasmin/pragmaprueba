import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebapragma/data/models/cat_model.dart';
import 'package:pruebapragma/data/repositories/cat_repository.dart';
import 'package:pruebapragma/core/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
final catRepositoryProvider = Provider<CatRepository>(
      (ref) => CatRepository(ref.read(apiClientProvider)),
);

final catsProvider = FutureProvider<List<CatModel>>((ref) async {
  final repository = ref.read(catRepositoryProvider);
  return await repository.getCats();
});

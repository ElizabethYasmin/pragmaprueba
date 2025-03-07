import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebapragma/data/models/cat_model.dart';
import 'package:pruebapragma/data/repositories/cat_repository.dart';
import 'package:pruebapragma/core/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
final catRepositoryProvider = Provider<CatRepository>(
      (ref) => CatRepository(ref.read(apiClientProvider)),
);

class CatNotifier extends StateNotifier<List<CatModel>> {
  final CatRepository repository;
  int _page = 0;
  bool _isLoading = false;

  CatNotifier(this.repository) : super([]);

  Future<void> fetchCats() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final cats = await repository.getCats(page: _page);
      state = [...state, ...cats];
      _page++;
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
    }
  }
}

final catPaginationProvider = StateNotifierProvider<CatNotifier, List<CatModel>>((ref) {
  final repository = ref.read(catRepositoryProvider);
  return CatNotifier(repository)..fetchCats();
});


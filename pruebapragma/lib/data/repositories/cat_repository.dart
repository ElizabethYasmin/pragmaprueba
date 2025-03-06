import 'package:pruebapragma/core/network/api_client.dart';
import 'package:pruebapragma/data/models/cat_model.dart';

class CatRepository {
  final ApiClient apiClient;

  CatRepository(this.apiClient);

  Future<List<CatModel>> getCats({int limit = 10}) async {
    final response = await apiClient.get('/images/search', queryParams: {
      'limit': limit,
    });

    return (response.data as List).map((e) => CatModel.fromJson(e)).toList();
  }
}

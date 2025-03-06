import 'package:pruebapragma/core/network/api_client.dart';
import 'package:pruebapragma/data/models/cat_model.dart';

class CatRepository {
  final ApiClient apiClient;

  CatRepository(this.apiClient);

  Future<List<CatModel>> getCats({int limit = 10, int page = 0}) async {
    // Llamamos al endpoint correcto con los nuevos parámetros
    final response = await apiClient.get('/breeds', queryParams: {
      'limit': limit.toString(),
      'page': page.toString(),
    });

    // Mapeamos la respuesta para convertirla en una lista de CatModel
    return (response.data as List)
        .map((e) => CatModel.fromJson(e))
        .toList();
  }
}

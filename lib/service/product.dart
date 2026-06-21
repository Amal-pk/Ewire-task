import 'package:dio/dio.dart';
import 'package:ewire_task/models/product.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/products",
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get("https://dummyjson.com/products");

      if (response.statusCode == 200) {
        final productResponse = ProductResponse.fromJson(response.data);
        return productResponse.products;
      }

      throw Exception(
        "Failed to load products. Status code: ${response.statusCode}",
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? "Network Error");
    }
  }
}

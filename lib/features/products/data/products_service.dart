import 'package:dio/dio.dart';
import 'package:mentorship/core/network/api_constants.dart';
import 'package:mentorship/core/network/dio_client.dart';
import 'package:mentorship/features/products/data/models/product_models.dart';

class ProductsService {
  final Dio _dio = DioClient.instance;

  Future<List<ProductModel>> getProducts({int page = 1, int pageSize = 20}) async {
    try {
      final response = await _dio.get(
        ApiConstants.products,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['items'] is List) {
        return (data['items'] as List)
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (data is List) {
        return data
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<ProductModel> getProductDetails(String id) async {
    try {
      final response = await _dio.get(ApiConstants.productDetails(id));
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _dio.delete(ApiConstants.deleteProduct(id));
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      final data = response.data;
      if (data is Map<String, dynamic> && data['items'] is List) {
        return (data['items'] as List)
            .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (data is List) {
        return data
            .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }
}

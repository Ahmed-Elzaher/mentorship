import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship/features/products/data/models/product_models.dart';
import 'package:mentorship/features/products/data/products_service.dart';
import 'package:mentorship/features/products/presentation/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsService _service;

  List<ProductModel> _allProducts = [];
  List<CategoryModel> _categories = [];
  String? _selectedCategory;

  ProductsCubit({ProductsService? service})
      : _service = service ?? ProductsService(),
        super(const ProductsInitial());

  Future<void> loadHomeData() async {
    emit(const ProductsLoading());
    try {
      final results = await Future.wait([
        _service.getProducts(),
        _service.getCategories(),
      ]);

      _allProducts = results[0] as List<ProductModel>;
      _categories = results[1] as List<CategoryModel>;
      _selectedCategory = null;

      emit(
        ProductsSuccess(
          products: _allProducts,
          categories: _categories,
        ),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void filterByCategory(String? categoryId) {
    _selectedCategory = categoryId;
    if (state is ProductsSuccess) {
      emit(
        ProductsSuccess(
          products: _allProducts,
          categories: _categories,
          selectedCategoryId: _selectedCategory,
        ),
      );
    }
  }

  Future<ProductModel?> getProductDetails(String id) async {
    try {
      return await _service.getProductDetails(id);
    } catch (e) {
      emit(ProductsError(e.toString()));
      return null;
    }
  }

  Future<void> deleteProduct(String id) async {
    emit(const ProductDeleteLoading());
    try {
      await _service.deleteProduct(id);
      _allProducts.removeWhere((p) => p.id == id);
      emit(ProductDeleteSuccess(id));
      emit(
        ProductsSuccess(
          products: List.from(_allProducts),
          categories: _categories,
          selectedCategoryId: _selectedCategory,
        ),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}

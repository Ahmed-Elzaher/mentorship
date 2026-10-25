import 'package:mentorship/features/products/data/models/product_models.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;

  const ProductsSuccess({
    required this.products,
    required this.categories,
    this.selectedCategoryId,
  });

  ProductsSuccess copyWith({
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    String? selectedCategoryId,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}

class ProductDetailsLoading extends ProductsState {
  const ProductDetailsLoading();
}

class ProductDetailsSuccess extends ProductsState {
  final ProductModel product;
  const ProductDetailsSuccess(this.product);
}

class ProductDeleteLoading extends ProductsState {
  const ProductDeleteLoading();
}

class ProductDeleteSuccess extends ProductsState {
  final String productId;
  const ProductDeleteSuccess(this.productId);
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError(this.message);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorship/core/localization/l10n_extension.dart';
import 'package:mentorship/core/theme/app_colors.dart';
import 'package:mentorship/core/theme/app_text_styles.dart';
import 'package:mentorship/core/utils/app_snackbar.dart';
import 'package:mentorship/core/widgets/custom_button.dart';
import 'package:mentorship/features/products/data/models/product_models.dart';
import 'package:mentorship/features/products/presentation/cubit/products_cubit.dart';
import 'package:mentorship/features/products/presentation/cubit/products_state.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsView({super.key, required this.product});

  void _showDeleteDialog(BuildContext context) {
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.confirmDeleteTitle, style: AppTextStyles.headingSmall()),
        content: Text(
          l10n.confirmDeleteMessage(product.name),
          style: AppTextStyles.bodyMedium(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(l10n.cancel, style: AppTextStyles.bodyMedium()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<ProductsCubit>().deleteProduct(product.id);
            },
            child: Text(l10n.delete, style: AppTextStyles.button(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductDeleteSuccess && state.productId == product.id) {
          AppSnackBar.showSuccess(context, l10n.deleteSuccess);
          Navigator.pop(context);
        } else if (state is ProductsError) {
          AppSnackBar.showError(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            l10n.productDetails,
            style: AppTextStyles.headingSmall(),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              tooltip: l10n.deleteProduct,
              onPressed: () => _showDeleteDialog(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image container
              Container(
                height: 280.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: product.coverPictureUrl != null &&
                          product.coverPictureUrl!.isNotEmpty
                      ? Image.network(
                          product.coverPictureUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/images/sneaker.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 60,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/sneaker.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 60,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20.h),

              // Title and Price row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.headingMedium(),
                        ),
                        if (product.arabicName != null &&
                            product.arabicName!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            product.arabicName!,
                            style: AppTextStyles.bodyMedium(color: AppColors.textMuted),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.headingSmall(color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Rating and Stock badges
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          '${product.rating} (${l10n.reviewsCount(product.reviewsCount)})',
                          style: AppTextStyles.bodySmall(color: AppColors.textDark).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: product.stock > 0
                          ? AppColors.success.withValues(alpha: 0.15)
                          : AppColors.error.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      product.stock > 0
                          ? l10n.inStock(product.stock)
                          : l10n.outOfStock,
                      style: AppTextStyles.bodySmall(
                        color: product.stock > 0 ? AppColors.success : AppColors.error,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Description section
              Text(
                l10n.description,
                style: AppTextStyles.titleMedium(),
              ),
              SizedBox(height: 8.h),
              Text(
                (product.description != null && product.description!.isNotEmpty)
                    ? product.description!
                    : (product.arabicDescription ?? l10n.noDescription),
                style: AppTextStyles.bodyMedium(),
              ),
              SizedBox(height: 36.h),

              // Action buttons
              CustomButton(
                text: l10n.addToCart,
                icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textDark, size: 20),
                onPressed: () {
                  AppSnackBar.showSuccess(context, l10n.addedToCart(product.name));
                },
              ),
              SizedBox(height: 12.h),
              OutlinedButton(
                onPressed: () => _showDeleteDialog(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.deleteProduct,
                      style: AppTextStyles.button(color: AppColors.error),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorship/core/localization/l10n_extension.dart';
import 'package:mentorship/core/routes/app_routes.dart';
import 'package:mentorship/core/storage/token_storage.dart';
import 'package:mentorship/core/theme/app_colors.dart';
import 'package:mentorship/core/theme/app_text_styles.dart';
import 'package:mentorship/core/utils/app_snackbar.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_state.dart';
import 'package:mentorship/features/products/data/models/product_models.dart';
import 'package:mentorship/features/products/presentation/cubit/products_cubit.dart';
import 'package:mentorship/features/products/presentation/cubit/products_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().loadHomeData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onLogout(BuildContext context) async {
    await TokenStorage.clearTokens();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  void _onRefreshToken(BuildContext context) {
    context.read<AuthCubit>().refreshToken();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RefreshTokenSuccess) {
          AppSnackBar.showSuccess(context, l10n.sessionRefreshed);
        } else if (state is AuthError) {
          AppSnackBar.showError(context, l10n.sessionRefreshFailed(state.message));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'assets/icons/app_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.flash_on_rounded,
                      color: AppColors.textDark,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                l10n.appTitle,
                style: AppTextStyles.headingSmall(),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync_rounded, color: AppColors.textDark),
              tooltip: 'Refresh Token',
              onPressed: () => _onRefreshToken(context),
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.textDark),
              tooltip: l10n.logout,
              onPressed: () => _onLogout(context),
            ),
          ],
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryDark),
              );
            }

            if (state is ProductsError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 64, color: AppColors.error),
                      SizedBox(height: 16.h),
                      Text(
                        l10n.errorLoadingData,
                        style: AppTextStyles.headingSmall(),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textDark,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        onPressed: () => context.read<ProductsCubit>().loadHomeData(),
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(l10n.retry, style: AppTextStyles.button()),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProductsSuccess) {
              final filteredProducts = state.products.where((p) {
                final matchesSearch = _searchQuery.isEmpty ||
                    p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    (p.arabicName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
                return matchesSearch;
              }).toList();

              return RefreshIndicator(
                color: AppColors.primaryDark,
                onRefresh: () => context.read<ProductsCubit>().loadHomeData(),
                child: CustomScrollView(
                  slivers: [
                    // Search bar
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val.trim();
                            });
                          },
                          style: AppTextStyles.bodyLarge(),
                          decoration: InputDecoration(
                            hintText: l10n.searchHint,
                            hintStyle: AppTextStyles.bodyMedium(color: AppColors.textMuted),
                            prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, color: AppColors.textMuted),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        _searchQuery = '';
                                      });
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Categories section
                    if (state.categories.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Text(
                            l10n.categories,
                            style: AppTextStyles.titleMedium(),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 44.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: state.categories.length + 1,
                            separatorBuilder: (context, index) => SizedBox(width: 8.w),
                            itemBuilder: (ctx, index) {
                              if (index == 0) {
                                final isSelected = state.selectedCategoryId == null;
                                return ChoiceChip(
                                  label: Text(l10n.all),
                                  selected: isSelected,
                                  selectedColor: AppColors.primary,
                                  backgroundColor: Colors.white,
                                  labelStyle: AppTextStyles.bodyMedium(
                                    color: isSelected ? AppColors.textDark : AppColors.textMuted,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                  onSelected: (_) => context.read<ProductsCubit>().filterByCategory(null),
                                );
                              }
                              final cat = state.categories[index - 1];
                              final isSelected = state.selectedCategoryId == cat.id;
                              return ChoiceChip(
                                label: Text(cat.arabicName ?? cat.name),
                                selected: isSelected,
                                selectedColor: AppColors.primary,
                                backgroundColor: Colors.white,
                                labelStyle: AppTextStyles.bodyMedium(
                                  color: isSelected ? AppColors.textDark : AppColors.textMuted,
                                ).copyWith(fontWeight: FontWeight.bold),
                                onSelected: (_) => context.read<ProductsCubit>().filterByCategory(cat.id),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    // Section title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.products,
                              style: AppTextStyles.titleMedium(),
                            ),
                            Text(
                              l10n.itemsCount(filteredProducts.length),
                              style: AppTextStyles.bodySmall(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Products Grid or Empty
                    if (filteredProducts.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.inbox_outlined, size: 64, color: AppColors.grey),
                              SizedBox(height: 12.h),
                              Text(
                                l10n.noProductsFound,
                                style: AppTextStyles.bodyLarge(color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.all(16.r),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.h,
                            crossAxisSpacing: 14.w,
                            childAspectRatio: 0.68,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = filteredProducts[index];
                              return _buildProductCard(context, item);
                            },
                            childCount: filteredProducts.length,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetails,
          arguments: item,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded corners
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Container(
                  width: double.infinity,
                  color: AppColors.lightGrey,
                  child: item.coverPictureUrl != null && item.coverPictureUrl!.isNotEmpty
                      ? Image.network(
                          item.coverPictureUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/images/backpack.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Icon(Icons.image_not_supported_outlined, color: AppColors.grey),
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/backpack.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(Icons.shopping_bag_outlined, color: AppColors.grey, size: 36),
                          ),
                        ),
                ),
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium(color: AppColors.textDark).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: AppTextStyles.titleMedium(color: AppColors.textDark).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

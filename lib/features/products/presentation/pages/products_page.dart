import 'package:flutter/material.dart';
import 'package:flutter_automation/core/utils/toast_helper.dart';
import 'package:flutter_automation/features/products/presentation/widgets/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../instance/locator.dart';
import '../../data/cubit/product_cubit.dart';
import '../../data/cubit/product_state.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    // Trigger fetch on load
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences sharedPreference = getIt<SharedPreferences>();
    try {
      await context.read<ProductCubit>().fetchProducts();
      sharedPreference.setString("initial", "initial Value");
    } catch (err) {
      showErrorToast(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fake Store')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(
              child: Text(state.message, textAlign: TextAlign.center),
            );
          } else if (state is ProductLoaded) {
            final items = state.products;
            if (items.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return RefreshIndicator(
              onRefresh: fetchData,
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => ProductCard(product: items[i]),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:store_usingapi/features/home/cubit/products_states.dart';
import 'package:store_usingapi/features/home/data/models/product_model.dart';

class ProductsCubit extends Cubit<ProductsStates>{
  ProductsCubit(this.dio):super(ProductInitialState());
  final Dio dio;
  List<ProductModel>products=[];
  Future<void> getallProducts() async {
  emit(ProductLoadingState());

  try {
    final response = await dio.get('https://fakestoreapi.com/products');

    if (response.statusCode == 200 && response.data != null && response.data is List) {
      products = [];
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }

      emit(ProductSuccessState(allproducts: products));
    } else {
      emit(ProductErorrState(errorMessage: 'Failed to load products'));
    }
  } catch (e, stack) {
    print("Stack trace: $stack");
    print("❌ error: $e");
    emit(ProductErorrState(errorMessage: e.toString()));
  }
}


}
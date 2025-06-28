import 'package:store_usingapi/features/home/data/models/product_model.dart';

abstract class ProductsStates{
}
class ProductInitialState extends ProductsStates{}
class ProductLoadingState extends ProductsStates{}
class ProductSuccessState extends ProductsStates{
  final List<ProductModel> allproducts;
  ProductSuccessState({required this.allproducts});
}
class ProductErorrState extends ProductsStates{
  final String errorMessage;
  ProductErorrState({required this.errorMessage});
}
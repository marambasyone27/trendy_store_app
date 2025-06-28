import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> item) {
    _cartItems.add(item);
    emit(CartUpdatedState(List.from(_cartItems)));
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    emit(CartUpdatedState(List.from(_cartItems)));
  }

  void clearCart() {
    _cartItems.clear();
    emit(CartUpdatedState([]));
  }
}

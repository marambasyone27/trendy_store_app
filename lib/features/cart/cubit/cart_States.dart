abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final List<Map<String, dynamic>> cartItems;

  CartUpdatedState(this.cartItems);
}

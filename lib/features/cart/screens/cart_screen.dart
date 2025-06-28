import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_usingapi/features/cart/cubit/cart_cubit.dart';

double calculateCartTotal(List<Map<String, dynamic>> cartItems) {
  double total = 0.0;
  for (var item in cartItems) {
    total += item['price'] as double;
  }
  return total;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartCubit>().cartItems;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 175, 128, 111),
                Color.fromARGB(255, 215, 47, 103),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shadowColor: Colors.pink,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Caveat',
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(
                color: Colors.pink,
                offset: Offset(4, 4),
                blurRadius: 3,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://i.pinimg.com/736x/92/a5/2e/92a52e2ea19d33416175efd65534df32.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Cart is empty 🛒",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(2, 2),
                              blurRadius: 3,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: Image.network(
                                item['picture'],
                                width: 60,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item['name']),
                              subtitle: Text("${item['price']} \$"),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete an item"),
                                        content: const Text("Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Delete"),
                                            onPressed: () {
                                              context.read<CartCubit>().removeItem(index);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total order Price:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${calculateCartTotal(cartItems).toStringAsFixed(2)} \$",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

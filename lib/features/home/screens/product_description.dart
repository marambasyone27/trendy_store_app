import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_usingapi/features/cart/cubit/cart_cubit.dart';

class ProductDescription extends StatelessWidget {
  final String imageUrl;
  final String description;
  final double price;
  final double rate;
  final String name;
  final String category;

  const ProductDescription({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rate,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          name,
          style: const TextStyle(
            shadows: [
              Shadow(
                color: Color.fromARGB(255, 151, 30, 70),
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
              ),
            ],
            color: Colors.white,
            fontFamily: 'Pacifico',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              child: Image.network(
                imageUrl,
                width: 300,
                height: 340,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: $category',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.brown,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              'Price: ${price.toStringAsFixed(2)} \$',
              style: const TextStyle(
                fontFamily: 'Lobster',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 215, 47, 103),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Rate of this product: ${rate.toStringAsFixed(1)}⭐',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: MediaQuery.of(context).size.width * 0.40,
              height: 50,
              color: Colors.green,
              onPressed: () {
                context.read<CartCubit>().addItem({
                  'picture': imageUrl,
                  'name': name,
                  'price': price,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 221, 168, 148),
                    content: Text(
                        "This product has been added to cart successfully ✅"),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Future.delayed(const Duration(seconds: 2), () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => CartScreen(), // بدون تمرير بيانات
                //     ),
                //   );
                // });
              },
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

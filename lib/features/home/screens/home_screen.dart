import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:store_usingapi/features/cart/screens/cart_screen.dart';
import 'package:store_usingapi/features/home/cubit/products_cubit.dart';
import 'package:store_usingapi/features/home/cubit/products_states.dart';
import 'package:store_usingapi/features/home/screens/product_description.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(Dio())..getallProducts(),
      child: BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('Current state: $state'); // Debug print
          return Scaffold(
            appBar: AppBar(
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
              centerTitle: true,
              title: const Text(
                "✨Trendy Picks✨",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 151, 30, 70),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ],
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: Container(
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
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 8.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, 
          
          iconSize: 28.0,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 237, 144, 175),
          selectedIconTheme: const IconThemeData(size: 30, color: Colors.white),
          unselectedIconTheme: const IconThemeData(size: 24, color: const Color.fromARGB(255, 237, 144, 175),),
          selectedFontSize: 20.0,
          unselectedFontSize: 12.0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono',
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'RobotoMono',
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          mouseCursor: SystemMouseCursors.click,
          enableFeedback: true,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          useLegacyColorScheme: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });

                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                }
              },
            ),
            ),
            body: SafeArea(
              child: state is ProductLoadingState
                  ? const Center(
                      child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 215, 47, 103),
                        size: 50.0,
                      ),
                    )
                  : state is ProductErorrState
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.errorMessage.isNotEmpty
                                    ? state.errorMessage
                                    : "OOPS, something went wrong, try again",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProductsCubit>()
                                      .getallProducts();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 215, 47, 103),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Retry',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : state is ProductSuccessState
                          ? state.allproducts.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Products Available",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : AnimationLimiter(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(5),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.85,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemCount: state.allproducts.length,
                                    itemBuilder: (context, index) {
                                      final product = state.allproducts[index];
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDescription(
                                                      category:
                                                          product.category,
                                                      imageUrl:
                                                          product.imageUrl,
                                                      description:
                                                          product.description,
                                                      name: product.title,
                                                      rate: product.rate,
                                                      price: product.price,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                shadowColor: Colors.pink
                                                    .withOpacity(0.5),
                                                surfaceTintColor:  const Color.fromARGB(    255, 215, 47, 103),
                                                color: Colors.white,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: product
                                                                .imageUrl ??
                                                            'https://via.placeholder.com/150',
                                                        width: double.infinity,
                                                        height: 135,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            const SpinKitFadingCircle(
                                                          color:   Color.fromARGB(    255, 215, 47, 103),
                                                          size: 10.0,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          'assets/images/placeholder.jpg',
                                                          width:
                                                              double.infinity,
                                                          height: 120,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      product.title ??
                                                          'No Title',
                                                      style: const TextStyle(
                                                        fontFamily: 'Pacifico',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      product.category ??
                                                          'No Category',
                                                      style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${product.price?.toStringAsFixed(2) ?? '0.00'} \$',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Lobster',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    47,
                                                                    103),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Text(
                                                          '${product.rate?.toStringAsFixed(1) ?? '0.0'} ⭐',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                          : const Center(
                              child: Text(
                                "Waiting for products...",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
            ),
          );
        },
      ),
    );
  }
}

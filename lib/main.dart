import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_usingapi/core/routing/app_routes.dart';
import 'package:store_usingapi/core/routing/routes.dart';
import 'package:store_usingapi/features/cart/cubit/cart_cubit.dart';
import 'package:store_usingapi/features/home/cubit/products_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsCubit(Dio())..getallProducts()),
        BlocProvider(create: (_) => CartCubit()), 
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trendy Picks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    initialRoute: Routes.splashScreen,
    onGenerateRoute: (settings) => AppRoutes().generateRoute(settings),
    );
  }
}


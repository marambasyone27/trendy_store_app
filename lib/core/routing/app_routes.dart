import 'package:flutter/material.dart';
import 'package:store_usingapi/core/routing/routes.dart';
import 'package:store_usingapi/features/cart/screens/cart_screen.dart';
import 'package:store_usingapi/features/home/screens/home_screen.dart';
import 'package:store_usingapi/features/home/screens/product_description.dart';
import 'package:store_usingapi/features/startScreens/onboarding.dart';
import 'package:store_usingapi/features/startScreens/splash_screen.dart';


class AppRoutes {
  Route generateRoute(RouteSettings settings){
    switch(settings.name){// name... هو اسم الروت اللي هروح
      case Routes.homeScreen:
      return MaterialPageRoute(builder: (_)=>HomeScreen());
      case Routes.onboarding:
      return MaterialPageRoute(builder: (_)=>Onboarding());
      case Routes.splashScreen:
      return MaterialPageRoute(builder: (_)=>SplashScreen());
       case Routes.cart:
      return MaterialPageRoute(builder: (_)=>CartScreen());
       case Routes.productDescription:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => ProductDescription(
          imageUrl: args['imageUrl'],
          description: args['description'],
          price: args['price'],
          rate: args['rate'],
          name: args['name'],
          category: args['category'],
        ),
      );
    default:
    return MaterialPageRoute(builder: 
    (_)=> Scaffold(
      body: Center(
        child: Text('No route defined for ${settings.name}'),
      ),
    )
    );
  }
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:store_usingapi/features/startScreens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;

  late Animation<double> _textFadeAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();
    // Text animation
    _textController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _textFadeAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _textController.forward();

    // Image animation
    _imageController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _imageFadeAnimation =
        CurvedAnimation(parent: _imageController, curve: Curves.easeIn);
    _imageScaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );
    _imageController.forward();
    Timer(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Onboarding()),
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: _imageFadeAnimation,
              child: ScaleTransition(
                scale: _imageScaleAnimation,
                child: Image.network(
                  'https://i.pinimg.com/736x/5e/f9/ea/5ef9ea4474073a2e66bad7262ee7affd.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "✨ Welcome to Maram's Store ✨",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Color(0xFFFFF0F5), // light pink
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          offset: Offset(2, 2),
                          color: Color.fromARGB(255, 197, 58, 124),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

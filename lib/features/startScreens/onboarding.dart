import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_usingapi/features/home/screens/home_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  bool isLast = false;

  List<String> images = [
    'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg',
  ];

  List<String> description = [
    "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
    'great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.',
    "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
    "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
  ];

  void goToGetStarted() {
    print("✅ going to GetStarted");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          TextButton(
            onPressed: goToGetStarted,
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLast = index == images.length - 1;
                    });
                  },
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          description[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: images.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.pink,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              const SizedBox(height: 135),
            ],
          ),
          if (isLast)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: ElevatedButton(
                    onPressed: goToGetStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      "Get Start",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
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

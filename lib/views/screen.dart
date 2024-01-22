import 'package:donative/app/utils/bottommenu.dart';
import 'package:donative/views/home_screen.dart';
import 'package:donative/views/profile_page.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onBottomNavBarTapped(int index) {
    setState(() {
      currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          extendBody: true,
          body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: const [
                HomeScreen(),
                ProfilePage(),
              ]),
          bottomNavigationBar: Menu(
              screenWidth: screenWidth,
              currentIndex: currentIndex,
              onIconPressed: _onBottomNavBarTapped)),
    );
  }
}

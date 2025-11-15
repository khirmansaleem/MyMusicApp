import 'package:client/core/theme/app_pallete.dart';
import 'package:client/home/view/pages/library_page.dart';
import 'package:client/home/view/pages/songs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // toggling between navbar items based on the selected index.
  int selectedIndex = 0;

  // list of widgets that can be toggled between in the body.
  final pages = const [
    SongsPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            // we will do later
            BottomNavigationBarItem(
              icon: Image.asset(
                // ZEROTH index bottom navigation bar item
                selectedIndex == 0
                    ? 'assets/images/home_filled.png'
                    : 'assets/images/home_unfilled.png',
                color: selectedIndex == 0
                    ? Pallete.whiteColor
                    : Pallete.inactiveBottomBarItemColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                // 1st index bottom navigation bar item
                'assets/images/library.png',
                color: selectedIndex == 1
                    ? Pallete.whiteColor
                    : Pallete.inactiveBottomBarItemColor,
              ),
              label: 'Library',
            ),
          ]),
    );
  }
}

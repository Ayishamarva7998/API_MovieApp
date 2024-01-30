// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/controller/bottom_provider.dart';
import 'package:movie_app/views/home_screen/home.dart';
import 'package:movie_app/views/movie_screen/movie.dart';
import 'package:movie_app/views/search_screen/search.dart';
import 'package:movie_app/views/tvshow_screen/tv_show.dart';

import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BottomNavigation extends StatelessWidget {
  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    MovieScreen(),
    TvShowScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomBarProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: _pages[bottomProvider.currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: NavigationBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            selectedIndex: bottomProvider.currentIndex,
            onDestinationSelected: (index) {
              bottomProvider.navigatePage(index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home,
                    color: bottomProvider.currentIndex == 0
                        ? Colors.white
                        : Color.fromARGB(255, 106, 105, 105)),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search,
                    size: 30,
                    color: bottomProvider.currentIndex == 1
                        ? Colors.white
                        : Color.fromARGB(255, 106, 105, 105)),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.videocam_outlined,
                    size: 30,
                    color: bottomProvider.currentIndex == 2
                        ? Colors.white
                        : const Color.fromARGB(255, 106, 105, 105)),
                label: 'Movies',
              ),
              NavigationDestination(
                icon: Icon(Icons.tv,
                    color: bottomProvider.currentIndex == 3
                        ? Colors.white
                        : const Color.fromARGB(255, 106, 105, 105)),
                label: 'TV',
              ),
            ],
            indicatorColor: Color.fromARGB(255, 33, 143, 149),
            surfaceTintColor: Color.fromARGB(255, 4, 2, 17),
          ),
        ),
      ),
    );
  }
}

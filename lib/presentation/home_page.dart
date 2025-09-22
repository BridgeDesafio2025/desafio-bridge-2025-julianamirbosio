import 'package:flutter/material.dart';
import 'package:movies__series_app/presentation/content_browse_screen/content_browse_screen.dart';
import 'package:movies__series_app/presentation/favorite_movies_screen/favorite_movies_screen.dart';
import 'package:movies__series_app/widgets/custom_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ContentBrowseScreen(),
          FavoriteMoviesScreen(),
        ],
      ),
      bottomNavigationBar: Semantics(
        label: 'Abas: ',
        child: CustomBottomBar(
          currentIndex: _selectedIndex,
          items: [
            BottomBarItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Navegar',
            ),
            BottomBarItem(
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite,
              label: 'Favoritos',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

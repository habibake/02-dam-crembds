import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'about_screen.dart';
import '../widgets/custom_floating_button.dart';

class BaseNavigationScreen extends StatefulWidget {
  const BaseNavigationScreen({super.key});

  @override
  State<BaseNavigationScreen> createState() => _BaseNavigationScreenState();
}

class _BaseNavigationScreenState extends State<BaseNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [const HomeScreen(), const FavoritesScreen(), const AboutScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Acerca de'),
        ],
      ),
      floatingActionButton: const CustomFloatingButton(),
    );
  }
}
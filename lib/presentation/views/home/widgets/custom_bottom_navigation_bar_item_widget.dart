import 'package:flutter/material.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
    required int currentIndex,
  }) : super(
         icon: Icon(icon, size: currentIndex == index ? 30 : 24),
         label: label,
       );
}

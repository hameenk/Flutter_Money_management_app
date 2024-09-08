import 'package:flutter/material.dart';
import 'package:money_mangment_flutter/screen/home/screen_home.dart';

class MoneyMangerBottomNavigation extends StatelessWidget {
  const MoneyMangerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Screenhome.selectedinterNotifier,
      builder: (BuildContext context, int updateindex, Widget? _) {
        return BottomNavigationBar(
          currentIndex: updateindex,
          onTap: (newIntex) {
            Screenhome.selectedinterNotifier.value = newIntex;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "category")
          ],
        );
      },
    );
  }
}

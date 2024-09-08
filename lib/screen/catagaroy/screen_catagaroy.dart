import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/screen/catagaroy/expanse%20catgaroylist.dart';
import 'package:money_mangment_flutter/screen/catagaroy/income_catagaroylist.dart';

class Screencatagaroy extends StatefulWidget {
  const Screencatagaroy({super.key});

  @override
  State<Screencatagaroy> createState() => _ScreencatagaroyState();
}

class _ScreencatagaroyState extends State<Screencatagaroy>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refresdUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: const [
          Tab(text: 'Income'),
          Tab(text: 'EXPANSE'),
        ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            Incomecatagaroylist(),
            Expancecatagaroylist(),
          ]),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:money_mangment_flutter/screen/add_transation/add_transation.dart';
//import 'package:money_mangment_flutter/db/category/category_db.dart';
//import 'package:money_mangment_flutter/models/category/category_model.dart';
import 'package:money_mangment_flutter/screen/catagaroy/catgaroy_add_popup.dart';
import 'package:money_mangment_flutter/screen/catagaroy/screen_catagaroy.dart';
import 'package:money_mangment_flutter/screen/home/widgets/bottomnavigation.dart';
import 'package:money_mangment_flutter/screen/transation/screen_transation.dart';

class Screenhome extends StatelessWidget {
  const Screenhome({super.key});

  static ValueNotifier<int> selectedinterNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransation(),
    Screencatagaroy(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 135, 129),
        title: const Text(
          'Money Manager',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyMangerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedinterNotifier,
            builder: (BuildContext context, int updatedIndex, Widget? _) {
              return _pages[updatedIndex];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 4, 48, 83),
        onPressed: () {
          if (selectedinterNotifier.value == 0) {
            print('add transation');
            Navigator.of(context).pushNamed(ScreenaddTransation.routeName);
          } else {
            print('add catagaroy');
            showCategoryAddpopup(context);
            //final _sample = CategoryModel(
            // id: DateTime.now().millisecondsSinceEpoch.toString(),
            //  name: 'travel',
            //  type: CategoryType.expense,
            //);
            //CategoryDb().insertCategory(_sample);
          }
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

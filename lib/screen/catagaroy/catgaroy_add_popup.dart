// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
//import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddpopup(BuildContext context) async {
  final nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          //Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Category name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //radiobutton
          const Padding(
            padding: EdgeInsets.all(1.0),
            child: Row(
              children: [
                RadioButton(title: 'income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          //Elevatedbutton
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedCategoryNotifier.value;
                final _category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type);
                CategoryDb.instance.insertCategory(_category);
                Navigator.of(ctx).pop();
              },
              child: const Text('add'),
            ),
          )
        ],
      );
    },
  );
}

//radio button.backend.
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                groupValue: selectedCategoryNotifier.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  // ignore: invalid_use_of_visible_for_testing_member
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}

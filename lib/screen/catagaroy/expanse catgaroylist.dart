// ignore_for_file: file_names

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';

class Expancecatagaroylist extends StatelessWidget {
  const Expancecatagaroylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCatogorylist,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final Category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(Category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(Category.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}

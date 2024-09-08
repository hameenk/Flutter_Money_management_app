import 'package:flutter/material.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';

class Incomecatagaroylist extends StatelessWidget {
  const Incomecatagaroylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomecatagaroylist,
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

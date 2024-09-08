import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/db/transation/transation_db.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';
import 'package:money_mangment_flutter/models/transation/transation_model.dart';

class ScreenTransation extends StatelessWidget {
  const ScreenTransation({super.key});

  @override
  Widget build(BuildContext context) {
    TransationDB.instance.refresh();
    CategoryDb.instance.refresdUI();
    return ValueListenableBuilder(
      valueListenable: TransationDB.instance.transationListNotifier,
      builder: (BuildContext ctx, List<TransationModel> newlist, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          //Values
          itemBuilder: (ctx, intex) {
            final _value = newlist[intex];

            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (Ctx) {
                      TransationDB.instance.deleteTransation(_value.id!);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: const Color.fromARGB(255, 171, 32, 22),
                    foregroundColor: Colors.white,
                  )
                ],
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      parseDate(_value.date),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: _value.type == CategoryType.income
                        ? const Color.fromARGB(255, 29, 129, 32)
                        : const Color.fromARGB(255, 160, 50, 42),
                  ),
                  title: Text('RS ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 4);
          },
          itemCount: newlist.length,
        );
      },
    );
  }

  String parseDate(DateTime dateTime) {
    return DateFormat.MMMd().format(dateTime);
    //final splitdate = date.split('');
    //return '${splitdate.last}\n${splitdate.first}';
    // return '${dateTime.day}\n ${dateTime.month}';
  }
}

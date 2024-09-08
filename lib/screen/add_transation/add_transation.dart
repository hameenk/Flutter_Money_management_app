//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_mangment_flutter/db/category/category_db.dart';
import 'package:money_mangment_flutter/db/transation/transation_db.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';
import 'package:money_mangment_flutter/models/transation/transation_model.dart';

class ScreenaddTransation extends StatefulWidget {
  static const routeName = 'add-transation';
  const ScreenaddTransation({super.key});

  @override
  State<ScreenaddTransation> createState() => _ScreenaddTransationState();
}

class _ScreenaddTransationState extends State<ScreenaddTransation> {
  final purposeTextEditingController = TextEditingController();
  final amountTextEditingController = TextEditingController();

  DateTime? _selectedDataToPrint;
  CategoryType? _selectedCataegoryType;
  CategoryModel? _selectedCataegoryModel;

  String? _categoryID;

  @override
  void initState() {
    _selectedCataegoryType = CategoryType.income;
    super.initState();
  }

/*
purpuse
date
Amount
income/Expanse
CategoryType
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //purpse
              TextField(
                controller: purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'purpuse', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              //amount.
              TextField(
                controller: amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'amount', border: OutlineInputBorder()),
              ),
              //datetime
              TextButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate == null) {
                    return;
                  } else {
                    print(selectedDate.toString());
                    setState(() {
                      _selectedDataToPrint = selectedDate;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedDataToPrint == null
                      ? "Select Date"
                      : _selectedDataToPrint.toString(),
                ),
              ),
              //radio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCataegoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCataegoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCataegoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCataegoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('expanse'),
                    ],
                  ),
                ],
              ),
              //catgory type.
              DropdownButton(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCataegoryType == CategoryType.income
                        ? CategoryDb().incomecatagaroylist
                        : CategoryDb().expenseCatogorylist)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCataegoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  print("ameen");
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
                onTap: () {},
              ),
              //submit.
              ElevatedButton(
                onPressed: () {
                  addTransation();
                },
                child: const Text('submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransation() async {
    final purpostText = purposeTextEditingController.text;
    final amountText = amountTextEditingController.text;
    if (purpostText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (_selectedCataegoryModel == null) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDataToPrint == null) {
      return;
    }
    final pasedAmount = double.tryParse(amountText);
    if (pasedAmount == null) {
      return;
    }
    //_selectedDate
    //_selectedCategorytype
    final _model = TransationModel(
      prupose: purpostText,
      amount: pasedAmount,
      date: _selectedDataToPrint!,
      type: _selectedCataegoryType!,
      category: _selectedCataegoryModel!,
    );
    await TransationDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransationDB.instance.refresh();
  }
}

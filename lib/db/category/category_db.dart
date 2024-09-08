//import 'dart:js_util';

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_mangment_flutter/models/category/category_model.dart';
//import 'package:money_mangment_flutter/screen/catagaroy/income_catagaroylist.dart';

const Category_db_name = 'category-database';

abstract class CategoryDBfuntions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDb implements CategoryDBfuntions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomecatagaroylist = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCatogorylist = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_db_name);
    await _categoryDB.put(value.id, value);
    refresdUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_db_name);
    return _categoryDB.values.toList();
  }

//refresdUI.
  Future<void> refresdUI() async {
    final _allCategories = await getCategories();
    incomecatagaroylist.value.clear();
    expenseCatogorylist.value.clear();
    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomecatagaroylist.value.add(category);
        } else {
          expenseCatogorylist.value.add(category);
        }
      },
    );

    // ignore: duplicate_ignore
    // ignore: invalid_use_of_visible_for_testing_member
    incomecatagaroylist.notifyListeners();
    expenseCatogorylist.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String CategoryID) async {
    final CategoryDb = await Hive.openBox<CategoryModel>(Category_db_name);
    await CategoryDb.delete(CategoryID);
    refresdUI();
  }
}

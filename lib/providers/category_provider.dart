import 'package:flutter/material.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:market/model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  getCategory(
    context,
  ) async {
    categoryList = await CustomHttpRequest().fetchCategoryData(context);
    notifyListeners();
  }

  deleteCategory(int index) {
    categoryList.removeAt(index);
    notifyListeners();
  }
}

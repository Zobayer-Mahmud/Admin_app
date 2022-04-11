import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:market/model/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  getProducts() async {
    productList = await CustomHttpRequest().fetchProductData();
    notifyListeners();
  }
}

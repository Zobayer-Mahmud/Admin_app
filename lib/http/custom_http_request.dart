import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:market/model/category_model.dart';
import 'package:market/model/orders_model.dart';
import 'package:market/model/product_model.dart';
import 'package:market/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpRequest {
  static String url = "https://apihomechef.antapp.space/api/";
  static SharedPreferences? sharedPreferences;

  static Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences!.getString("token")}"
    };
    return header;
  }

  Future login(String email, password) async {
    var responce = await http.post(Uri.parse("${url}admin/sign-in"),
        body: {"email": email, "password": password});
    if (responce.statusCode == 200) {
      return responce.body;
    } else {
      showToast("Email or password doesn't match");
    }
  }

  Future<dynamic> fetchProductData() async {
    List<ProductModel> myList = [];
    ProductModel productModel;
    String link = "https://apihomechef.antapp.space/api/admin/products";
    var responce =
        await http.get(Uri.parse(link), headers: await getHeaderWithToken());

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("all product data are $data");
      for (var singleData in data) {
        productModel = ProductModel.fromJson(singleData);
        myList.add(productModel);
      }
    } else {
      print("something wronggggggg");
    }
    return myList;
  }

  Future<dynamic> fetchCategoryData(context) async {
    List<CategoryModel> myList = [];
    CategoryModel categoryModel;
    String link = "https://apihomechef.antapp.space/api/admin/category";
    var responce =
        await http.get(Uri.parse(link), headers: await getHeaderWithToken());

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("all Category data are $data");
      for (var singleData in data) {
        categoryModel = CategoryModel.fromJson(singleData);
        myList.add(categoryModel);
      }
    } else {
      print("something wronggggggg");
    }
    return myList;
  }

  Future<dynamic> getOrder(context) async {
    List<Order> myList = [];
    Order orderModel;
    String link = "https://apihomechef.antapp.space/api/admin/all/orders";
    var responce =
        await http.get(Uri.parse(link), headers: await getHeaderWithToken());

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("all Order data are =  $data");
      for (var singleData in data) {
        orderModel = Order.fromJson(singleData);
        myList.add(orderModel);
        print('=====>${orderModel.toJson()}');
      }
    } else {
      print("something wronggggggg");
    }
    return myList;
  }

  Future<Order?> getOrderWithId(context, int id) async {
    Order? order;
    try {
      String ju = "https://apihomechef.antapp.space";
      String url = "$ju/api/admin/order/$id/invoice";
      Uri myUri = Uri.parse(url);
      var response = await http.get(myUri,
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        print('data found');
        order = Order.fromJson(item);
        print(order);
      } else {
        print('Data not found');
      }
    } catch (e) {
      print(e);
    }
    return order;
  }

  Future<bool> deleteOrder(int id) async {
    try {
      String link = "$url/api/admin/order/${id}/delete";
      Uri myUri = Uri.parse(link);
      var response = await http.delete(myUri,
          headers: await CustomHttpRequest.getHeaderWithToken());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:market/model/orders_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> orderList = [];

  getRecentOrders(context) async {
    orderList = await CustomHttpRequest().getOrder(context);
    notifyListeners();
  }

  deleteOrder(int id, context) async {
    bool status = await CustomHttpRequest().deleteOrder(id);
    if (status) {
      getRecentOrders(context);
    }
  }
}

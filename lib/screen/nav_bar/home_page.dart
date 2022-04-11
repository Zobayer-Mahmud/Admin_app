import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:http/http.dart' as http;
import 'package:market/model/orders_model.dart';
import 'package:market/providers/products_provider.dart';
import 'package:market/screen/add_category.dart';
import 'package:market/widget/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? scrollController;
  bool showNav = true;
  addButton() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddCategory()));
                  },
                  color: Colors.red,
                  height: 60,
                  minWidth: 80,
                  child: Text("Add Category"),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.pink,
                  height: 60,
                  minWidth: 80,
                  child: Text("Add Products"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      progressIndicator: spinkit,
      child: Scaffold(
          floatingActionButton: showNav
              ? FloatingActionButton(
                  onPressed: () {
                    addButton();
                  },
                  child: Icon(Icons.add),
                )
              : null,
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              setState(() {
                if (notification.direction == ScrollDirection.forward) {
                  showNav = true;
                } else if (notification.direction == ScrollDirection.reverse) {
                  showNav = false;
                }
              });
              return true;
            },
            child: Container(
              padding: EdgeInsets.all(22),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("All orders are :${orderList.length}"),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${orderList[index].user!.name}"),
                            subtitle: Text("${orderList[index].id}"),
                            leading: orderList[index]
                                        .orderStatus!
                                        .orderStatusCategory
                                        .id ==
                                    1
                                ? Icon(Icons.outlined_flag)
                                : orderList[index]
                                            .orderStatus!
                                            .orderStatusCategory
                                            .id ==
                                        2
                                    ? Icon(
                                        Icons.delivery_dining,
                                        color: Colors.orange,
                                      )
                                    : Icon(
                                        Icons.compass_calibration_rounded,
                                        color: Colors.green,
                                      ),
                            trailing: Text(
                                "${orderList[index].orderStatus!.orderStatusCategory.name}"),
                          );
                        })
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchOrder();

    scrollController = ScrollController();
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
    super.initState();
  }

  Order? orderModel;
  List<Order> orderList = [];
  bool isLoading = false;

  Future fetchOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      String url = "https://apihomechef.antapp.space/api/admin/all/orders";
      var responce = await http.get(Uri.parse(url),
          headers: await CustomHttpRequest.getHeaderWithToken());
      print("all orders are ${responce.body}");
      if (responce.statusCode == 200) {
        final item = jsonDecode(responce.body);
        for (var i in item) {
          var orders = Order.fromJson(i);
          setState(() {
            orderList.add(orders);
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
}

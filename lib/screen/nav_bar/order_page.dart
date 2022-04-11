import 'package:flutter/material.dart';
import 'package:market/model/orders_model.dart';
import 'package:market/provider/order_provider.dart';

import 'package:market/screen/order_edit_page.dart';
import 'package:market/widget/brand_colors.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getRecentOrders(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orderList = Provider.of<OrderProvider>(context).orderList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: orderList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: orderList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  "${orderList[index].id}",
                                ),
                                Image.network(
                                  "https://img.freepik.com/free-psd/food-menu-restaurant-facebook-cover-template_120329-1680.jpg?size=626&ext=jpg",
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 110,
                                ),
                                Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return OrderEditPage(
                                              orderModel: orderList[index],
                                            );
                                          }),
                                        );
                                      },
                                      child: Text("Details"),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Are you sure ?'),
                                                titleTextStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: aTextColor),
                                                titlePadding: EdgeInsets.only(
                                                    left: 35, top: 25),
                                                content: Text(
                                                    'Once you delete, the item will gone permanently.'),
                                                contentTextStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: aTextColor),
                                                contentPadding: EdgeInsets.only(
                                                    left: 35,
                                                    top: 10,
                                                    right: 40),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                              color: aTextColor,
                                                              width: 0.2)),
                                                      child: Text(
                                                        'CANCEL',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: aTextColor),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.redAccent
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      child: Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                aPriceTextColor),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      await Provider.of<
                                                              OrderProvider>(
                                                          context,
                                                          listen: false);
                                                      //     .deleteOrder(
                                                      //         orderList[index]
                                                      //                 .id ??index
                                                      //             0,
                                                      // );
                                                      setState(() {
                                                        orderList.removeWhere(
                                                            (element) =>
                                                                element.id ==
                                                                orderList[index]
                                                                    .id);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}

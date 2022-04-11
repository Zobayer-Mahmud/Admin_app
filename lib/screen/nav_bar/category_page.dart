import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market/http/custom_http_request.dart' as http;
import 'package:http/http.dart' as http;
import 'package:market/http/custom_http_request.dart';
import 'package:market/provider/category_provider.dart';
import 'package:market/screen/category_edit_page.dart';
import 'package:market/widget/brand_colors.dart';
import 'package:market/widget/widget.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool onProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CategoryProvider>(context, listen: false).getCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<CategoryProvider>(context).categoryList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: categories.isEmpty
          ? CircularProgressIndicator()
          : Container(
              width: double.infinity,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Image.network(
                                  "https://homechef.antapp.space/category/${categories[index].image}",
                                  fit: BoxFit.cover,
                                  height: 120,
                                ),
                                Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return CategoryEditpage(
                                            categoryModel: categories[index],
                                            /*  id: categories.categoryList[index].id,
                      index: index,
                      name: categories.categoryList[index].name,*/
                                          );
                                        })).then((value) => Provider.of<
                                                CategoryProvider>(context)
                                            .getCategory(
                                                context)); //.then((value) => categories.getCategories(context,onProgress));
                                      },
                                      child: Text("Edit"),
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
                                                      deleteCategory(
                                                              categories[index]
                                                                  .id)
                                                          .then((value) =>
                                                              setState(() {
                                                                categories
                                                                    .removeAt(
                                                                        index);
                                                              }));
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

  deleteCategory(var id) async {
    String url =
        "https://apihomechef.antapp.space/api/admin/category/$id/delete";
    var responce = await http.delete(Uri.parse(url),
        headers: await CustomHttpRequest.getHeaderWithToken());

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("$data");
      print("delete successfully");
      showToast("${data["message"]}");
    } else {
      print("something wrong");
      showToast("Something wrong");
    }
  }
}

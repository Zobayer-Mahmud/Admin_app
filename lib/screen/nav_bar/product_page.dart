import 'package:flutter/material.dart';
import 'package:market/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: product.productList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(
                      "${product.productList[index].name}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

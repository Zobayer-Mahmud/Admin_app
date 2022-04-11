import 'package:flutter/material.dart';
import 'package:market/screen/login_page.dart';
import 'package:provider/provider.dart';

import 'provider/order_provider.dart';
import 'providers/category_provider.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider()),
      ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider()),
      ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}

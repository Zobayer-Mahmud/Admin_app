import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:market/screen/main_page.dart';
import 'package:market/widget/brand_colors.dart';
import 'package:market/widget/text_field.dart';
import 'package:market/widget/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      progressIndicator: spinkit,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Login Page",
                  style: myStyles20(),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Enter your email",
                  style: myStyles14(),
                ),
                CustomeTextField(
                  controller: emailController,
                  icon: Icons.email,
                  hintText: "Enter your email",
                ),
                Text(
                  "Enter your password",
                  style: myStyles14(),
                ),
                CustomeTextField(
                  controller: passwordController,
                  icon: Icons.password,
                  hintText: "Enter your password",
                ),
                MaterialButton(
                  onPressed: () {
                    print("start");
                    getLogin();
                  },
                  height: 50,
                  minWidth: 80,
                  color: Colors.pink,
                  child: Text(
                    "Login",
                    style: myStyle(18, Colors.white, FontWeight.w800),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  SharedPreferences? sharedPreferences;
  static String url = "https://apihomechef.antapp.space/api/";

  /* Future getLogin(String email, password) async {
    var responce = await http.post(Uri.parse("${url}admin/sign-in"),
        body: {"email": email, "password": password});
    if (responce.statusCode == 200) {
      var result = responce.body;
      var decodeData = jsonDecode(result);
      print("all data are $decodeData");
      showToast("Login Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      var result = responce.body;
      print("error is $result");
      showToast("Email or password doesn't match");
    }
  }*/

  Future getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      sharedPreferences = await SharedPreferences.getInstance();
      var data = await CustomHttpRequest()
          .login(emailController.text, passwordController.text);
      var decodeData = jsonDecode(data);

      if (decodeData["access_token"] != null) {
        showToast("Login Successful");
        setState(() {
          sharedPreferences!.setString("token", decodeData["access_token"]);
          print("token is ${sharedPreferences!.getString("token")}");
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        setState(() {
          isLoading = false;
        });
        showToast("Email or Password doesn't match");
      }
    } catch (e) {
      showToast("Email or Password doesn't match");
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  Future isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.get("token") != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }
}

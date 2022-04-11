import 'package:flutter/material.dart';

class VerifyAddress extends StatefulWidget {
  const VerifyAddress({Key? key}) : super(key: key);

  @override
  _VerifyAddressState createState() => _VerifyAddressState();
}

class _VerifyAddressState extends State<VerifyAddress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget pageUI() {
    return _formUI();
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(fit: FlexFit.tight, flex: 1, child: Container())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container();
  }
}

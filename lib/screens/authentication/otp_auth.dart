import 'package:flutter/material.dart';

import '../../utils/colors_util.dart';

class OTPAuth extends StatefulWidget {
  const OTPAuth({Key? key}) : super(key: key);

  @override
  _OTPAuthState createState() => _OTPAuthState();
}

class _OTPAuthState extends State<OTPAuth> {
  HexColor customGreen = HexColor('#088F81');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(customGreen.withOpacity(0.75), BlendMode.modulate),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/auth_bg.png"),
                        fit: BoxFit.cover),
                  ),
                  // Foreground widget here
                ),
              ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(customGreen.withOpacity(0.75), BlendMode.modulate),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/auth_bg.png"),
                        fit: BoxFit.cover),
                  ),
                  // Foreground widget here
                ),
              ),
            ],
          ),
          Positioned(
            top: 300,
            right: 0,
            left: 0,
            child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width ,
                child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Enter your phone number",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}
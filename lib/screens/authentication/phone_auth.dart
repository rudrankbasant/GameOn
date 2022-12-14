import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gameon/screens/authentication/otp_auth.dart';
import 'package:gameon/screens/home_screen.dart';

import '../../utils/colors_util.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  HexColor customGreen = HexColor('#088F81');

  Widget _buildDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        Text("+${country.phoneCode}"),
      ],
    ),
  );

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
              top: 100,
              right: 0,
              left: 10,
              child: Image.asset("assets/icon.png", height: 100, width: 50)),
          Positioned(
            top: 250,
            right: 0,
            left: 0,
            child: Container(
              height: 650,
              width: MediaQuery.of(context).size.width ,
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 25, 8, 0),
                      child: Text(
                        "Hi!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Let's Get Started",
                        style: TextStyle(
                          color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: Text("Enter Phone Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
                      child: Card(
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: CountryPickerDropdown(
                                  initialValue: 'in',
                                  itemBuilder: _buildDropdownItem,
                                  onValuePicked: (Country country) {
                                    print("${country.name}");
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: "Phone Number",
                                    counterText: '',
                                ),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                    const SizedBox(height: 280),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: customGreen,
                        ),
                        onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        ); },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: Text('Get OTP'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Text("Have a Pin?", style: TextStyle(color: customGreen, decoration: TextDecoration.underline,),),
                    )

                  ]
                )
              )
            ),
          ),

        ],
      ),
    );
  }
}
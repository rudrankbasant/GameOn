import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gameon/screens/authentication/phone_auth.dart';
import 'package:gameon/screens/home_screen.dart';
import 'package:gameon/utils/colors_util.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
        checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(HexColor('#E7E7E7')),
        )
      ),
      home: const PhoneAuth(),
    );
  }
}

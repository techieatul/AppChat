import 'package:flutter/material.dart';
import 'package:chatapplication/screens/login_screen.dart';
import 'package:chatapplication/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:google_fonts/google_fonts.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  void initState(){
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo1.png'),
                    height: 100.0,
                  ),
                ),

                DefaultTextStyle(
                  style: TextStyle(
                        color: Colors.blue[700],
                         fontWeight: FontWeight.w700,
                         fontSize: 50.0,
                  ),

                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 3000),
                    animatedTexts: [
                      TyperAnimatedText('AppChat'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],


            ),

            SizedBox(
              height: 5.0,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/login');

                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/register');

                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),




          ],

        ),
      ),


    );
  }
}



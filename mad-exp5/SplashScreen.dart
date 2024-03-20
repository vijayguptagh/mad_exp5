import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image(image: AssetImage('assets/images/splash.png'),

                  ),
                ),
                Container(
                  child: Text("Powered by DBIT", style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )
                  ),
                ),

              ],
            )


        )
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  Future<User?> resetPassword({
    required String email,
    required BuildContext context,
  }) async {

    User? user;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email);

      Fluttertoast.showToast(
          msg: "Password Reset Link sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);


      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));


    } on FirebaseAuthException catch (e) {

      print("Some issues.. try after sometime ");
      Fluttertoast.showToast(
          msg: e!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }


  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MAD PWA Academy",
              style: TextStyle(
                  color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 18.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "User Email Address",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  )),
            ),
            SizedBox(
              height: 58.0,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.blue[900],
                onPressed: () async{
                  print ("Reset password  clicked");
                  await resetPassword(
                      email: _emailController.text,
                      context: context);
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
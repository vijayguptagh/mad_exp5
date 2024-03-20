import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_authentication/main.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  Future<User?> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {

    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {

      print("User Not created ");
      Fluttertoast.showToast(
          msg: "Unable to create user. Try afte sometime",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MAD PWA Academy",
              style: TextStyle(
                  color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "SignUp ",
              style: TextStyle(
                  color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
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
              height: 20.0,
            ),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "User Password",
                  prefixIcon: Icon(
                    Icons.lock,
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

                  print ("sign up clicked");
                  await signUp(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);



                  Fluttertoast.showToast(
                      msg: "User Created Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));

                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                // Callback function to be executed when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to MyNewPage
                );
              },
              child:Text(
                "Already have an account? Login here",
                style: TextStyle(
                    color: Colors.blue, fontSize:15.0, fontWeight: FontWeight.bold),
              ),
            )
          ]
      ),
    );
  }
}
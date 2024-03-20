import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_authentication/ForgotPass.dart';
import 'package:firebase_authentication/ProfileScreen.dart';
import 'package:firebase_authentication/SplashScreen.dart';
import 'package:firebase_authentication/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Splash(),

      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Splash(),
        splashIconSize: 200,

        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,

      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _initializeFirebase();
  }

  Future _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: _initializeFirebase(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
        } else {

          return  CircularProgressIndicator();
        }
      },
    );


  }
}




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  Future<User?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {

    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {

      print("User Not found ");
      Fluttertoast.showToast(
          msg: "Invalid User credential",
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
            "Login to your app",
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
              onPressed: () async {
                User? user = await signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context) as User?;

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                }
              },
              child: Text(
                "Login",
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
                  MaterialPageRoute(builder: (context) => ForgotPassword()), // Navigate to MyNewPage
                );
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    color: Colors.blue, fontSize:15.0, fontWeight: FontWeight.bold),
              )
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              // Callback function to be executed when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => signup()), // Navigate to MyNewPage
              );
            },
            child: Text(
              "Don't Have account? SignUp",
              style: TextStyle(
                  color: Colors.blue, fontSize:15.0, fontWeight: FontWeight.bold),

            ),
          )
        ],
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override

  int dataAccessLevel=2;

  Widget build(BuildContext context) {



    return Scaffold(
      appBar:  AppBar(
        title:  Text("Profile Page"),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile/male_profile.png"),
                  radius: 50.0,
                )
            ),
            Divider(
              thickness: 5.0,
              color: Colors.blue[200],
            ),
            Row(
              children: [
                Icon(
                  Icons.account_circle_sharp,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text("Name",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Text("Nilesh Ghavate",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600]
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text("Phone",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Text("9594813901",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600]
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              children: [
                Icon(
                  Icons.email,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text("Email",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Text("nilesh@dbit.in",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600]
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              children: [
                Icon(
                  Icons.desktop_windows,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text("Data Access Level",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Text('$dataAccessLevel',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600]
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  // Navigate to login page
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));

                },
                icon: Icon(Icons.arrow_back, size:18),
                label: Text(
                  "LogOut",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),

          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            dataAccessLevel = dataAccessLevel +1;
          });
        },
        child: Icon(Icons.upgrade),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: "Like",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_down),
            label: "DisLike",
          ),

        ],
      ),

    );
  }
}
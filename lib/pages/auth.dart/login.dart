
import 'package:easyconference/pages/adminpage.dart';
import 'package:easyconference/pages/userpage.dart';
import 'package:easyconference/pages/presenter.dart';
import 'package:flutter/material.dart';
import 'package:easyconference/constants.dart';
import 'package:easyconference/services/database_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isUser = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';
  bool _isButtonPressed = false;
  final DatabaseService _databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 805,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bg.png"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
    
          //Main Container for User and Admin
         Positioned(
            top: 250,
            child: Container(
              height:  300,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isUser = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "ADMIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isUser
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isUser)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 80,
                                  color: Color.fromARGB(255, 111, 18, 85),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isUser = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "USER",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isUser
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isUser)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 127, 30, 107),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isUser) buildUserSection(),
                    if (!isUser) buildAdminSection()
                  ],
                ),
                
                
              ),
              
            ),
            
          
        ],
      ),
    );
  }

  Container buildAdminSection() {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child : Form(
      key: _formKey,
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10.0),
          child: TextFormField(
            obscureText: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "Username",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),

            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isButtonPressed = true;
                });
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {
            _username = value!;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10.0),
          child: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "**********",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isButtonPressed = true;
                });
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
        ),

        Padding(
            padding: const EdgeInsets.only(top: 20),
        child : ElevatedButton(
           child: const Text('Login'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                  if (_username.trim() == 'admin' &&
                   _password == 'admin123') {
                    // Navigate to the admin page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AdminPage(),
                                        ),
                                      );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Invalid Credentials'),
                                              content: const Text(
                                                  'Please enter valid email and password.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
  },),)]),));
        
                                  }
                                
                             

  Container buildUserSection() {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child : Form(
      key: _formKey,
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10.0),
          child: TextFormField(
            obscureText: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "ira@example.com",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),

            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isButtonPressed = true;
                });
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (value) {
            _email = value!;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10.0),
          child: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Palette.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "**********",
              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _isButtonPressed = true;
                });
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
        ),
      
       Padding(
            padding: const EdgeInsets.only(top: 20),
        child : ElevatedButton(
           child: const Text('Login'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                 final user = await _databaseService
                                          .getUsersByEmail(_email.trim());
                                      if (user != null &&
                                          user.password == _password) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserPage(user: user),
                                          ),
                                        );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Invalid Credentials'),
                                              content: const Text(
                                                  'Please enter valid email and password.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
  },),)]),));


  }


}
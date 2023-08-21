import 'package:easyconference/pages/auth.dart/login.dart';
import 'package:flutter/material.dart';
import 'package:easyconference/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:easyconference/models/user.dart';
import 'package:easyconference/services/database_service.dart';



class Register extends StatefulWidget {
  const Register({Key? key,  this.user}) : super(key: key);
  final User? user;
  @override

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();


  String _selectedSpecialization = '';
  String _selectedRole = '';


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


   final List<String>  specializationArea = [
    'Artificial Intelligence',
    'Data Mining',
    'Computer Security',
    'Internet of Things',
    'Software Engineering'
  ];

    final List<String>  roles = [
    'Participant',
    'Presenter',
    'Reviewer',
    'Judges'
  ];

void _registerUser() async {
    if (_formkey.currentState!.validate()) {
      // Create a User object with the entered details
      final newUser = User(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        institute: instituteController.text,
        specialization : _selectedSpecialization,
        role: _selectedRole,
        password: passwordController.text,
      );

      // Insert the user into the database
      await DatabaseService().insertUser(newUser);

}
}

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

    Positioned(
  top: 100,
  child: Container(
    height: 600,
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
          spreadRadius: 5,
        ),
      ],
    ),
    child: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: buildInputDecoration(Icons.person, "Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  //name = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                keyboardType: TextInputType.text,
                decoration: buildInputDecoration(Icons.email, "Email"),
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  //email = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: buildInputDecoration(Icons.phone, "Phone No"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number ';
                  }
                  return null;
                },
                onSaved: (value) {
                  //phone = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                keyboardType: TextInputType.text,
                controller: instituteController,
                decoration: buildInputDecoration(Icons.school, "Institute"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your institute';
                  }
                  return null;
                },
                onSaved: (value) {
                  //institute = value;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                borderRadius: BorderRadius.circular(2),
                decoration: buildInputDecoration(
                  Icons.book,
                  "Specialization Area",
                ),
                items: specializationArea.map((String area) {
                  return DropdownMenuItem<String>(
                    value: area,
                    child: Text(area),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSpecialization = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your specialization area';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                decoration: buildInputDecoration(
                  Icons.person,
                  "Role",
                ),
                items: roles.map((String area) {
                  return DropdownMenuItem<String>(
                    value: area,
                    child: Text(area),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 50, 49, 51)),
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: buildInputDecoration(Icons.key, "Password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  //passw = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate()){
                  _registerUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  LoginPage(),
                    ),
                  );
                return;
                          } else {
                            print("UnSuccessfull");
                          }
                        },
                        child: const Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        
                      ),
            ],
                    )
        ),
      ),
    ),),)
                  ],
                  ),
     );
     
                
              
            
  }
}

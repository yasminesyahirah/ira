import 'package:flutter/material.dart';
import 'package:easyconference/models/user.dart';
import 'package:easyconference/services/database_service.dart';
import 'package:easyconference/pages/auth.dart/login.dart';

class UserPage extends StatefulWidget {
  final User user;

  const UserPage({Key? key,  required this.user}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  List<String> specializationAreas = [
    'Artificial Intelligence',
    'Data Mining',
    'Computer Security',
    'Internet of Things',
    'Software Engineering',
  ];

  List<String> roles = [
    'Participant',
    'Presenter',
    'Reviewer',
    'Judge',
  ];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    phoneController.text = widget.user.phone;
    instituteController.text = widget.user.institute;
    specializationController.text = widget.user.specialization;
    roleController.text = widget.user.role;
  }

  void _updateUserDetails() async {
  // Get the updated values from the controllers
  final updatedUser = User(
    
    name: nameController.text,
    email: widget.user.email, // Retain the original email
    phone: phoneController.text,
    institute: instituteController.text,
    specialization: specializationController.text,
    role: roleController.text,
    password: widget.user.password, // Retain the original password
  );

  // Update the user details in the database
  final databaseService = DatabaseService(); // Replace with your database service implementation
  await databaseService.updateUser(updatedUser);

  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Update Successful'),
      content: const Text('User details updated successfully.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )
        ],
        centerTitle: true,
        title: Text( 
          'Profile Page',
          style: const TextStyle(
            color: Color.fromARGB(213, 247, 248, 251),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 41, 20, 35),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome, ${widget.user.name}!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
            ),
            TextField(
              controller: instituteController,
              decoration: const InputDecoration(
                labelText: 'Institute',
              ),
            ),
            DropdownButtonFormField<String>(
              value: specializationController.text,
              decoration: const InputDecoration(labelText: 'Specialization Area'),
              items: specializationAreas
                  .map((area) => DropdownMenuItem(
                        value: area,
                        child: Text(area),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  specializationController.text = value!;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: roleController.text,
              decoration: const InputDecoration(labelText: 'Role'),
              items: roles
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  roleController.text = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateUserDetails,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}


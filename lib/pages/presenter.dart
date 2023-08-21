import 'package:flutter/material.dart';
import 'package:easyconference/services/database_service.dart';
import 'package:easyconference/models/user.dart';
import 'auth.dart/login.dart';

class PresenterPage extends StatefulWidget {
  @override
  _PresenterPageState createState() => _PresenterPageState();
}

class _PresenterPageState extends State<PresenterPage> {
  List<User> _presenters = [];
  final List<String> _specializationAreas = [
    'Artificial Intelligence',
    'Data Mining',
    'Computer Security',
    'Internet of Things',
    'Software Engineering',
  ];
  String _selectedSpecializationArea = 'Artificial Intelligence';

  @override
  void initState() {
    super.initState();
    _loadPresenters();
  }

  Future<void> _loadPresenters() async {
    final databaseService = DatabaseService();
    final presenters = await databaseService.getPresenters();
    setState(() {
      _presenters = presenters;
    });
  }

  List<User> _getFilteredPresenters() {
    return _presenters
        .where((presenter) =>
            presenter.specialization == _selectedSpecializationArea)
        .toList();
  }

  void _sortPresentersBySpecializationArea(String? specializationArea) {
    if (specializationArea != null) {
      setState(() {
        _selectedSpecializationArea = specializationArea;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 180.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 117, 54, 117),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSpecializationArea,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        labelText: 'Specialization Area',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 55, 59, 60),
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 50, 49, 51),
                      ),
                      items: _specializationAreas
                          .map((area) => DropdownMenuItem(
                                value: area,
                                child: Text(area),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        _sortPresentersBySpecializationArea(value);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _getFilteredPresenters().length,
                  itemBuilder: (context, index) {
                    final presenter = _getFilteredPresenters()[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                      ),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(presenter.name),
                       
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

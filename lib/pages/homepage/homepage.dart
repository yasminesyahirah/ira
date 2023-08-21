import 'package:easyconference/pages/auth.dart/login.dart';
import 'package:easyconference/pages/auth.dart/register.dart';
import 'package:easyconference/pages/presenter.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  //controller to keep track of which page were on
  final  _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
        children: [
          Container(
             decoration:  BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage("assets/home.png"),
                  fit: BoxFit.cover,
              ),
             )
          ),
          Container(
            decoration:  BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage("assets/speakers.png"),
                  fit: BoxFit.cover,
          ),
            ),
            child: Column(
    children: <Widget>[
      SizedBox(height: 350),
      Expanded(
        child: FractionallySizedBox(
          
          alignment: Alignment.center,
          widthFactor: 0.5,
          heightFactor: 0.10,
          child: ElevatedButton(

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PresenterPage()),
              );
            },
            child: const Text('View Presenter'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 55, 66, 104),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),),],),),
      
          Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/bgg.png"),
      fit: BoxFit.cover,
    ),
  ),
  child: Row(
    children: <Widget>[
      SizedBox(height: 100),
      Expanded(
        
        child: FractionallySizedBox(
          alignment: AlignmentDirectional(0.2, 0.5),
          widthFactor: 0.7,
          heightFactor: 0.05,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: const Text('Register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 55, 66, 104),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: FractionallySizedBox(
          alignment: AlignmentDirectional(-0.2, 0.5),
          widthFactor: 0.7,
          heightFactor: 0.05,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Log In'),
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color.fromARGB(255, 55, 66, 104),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),
        ],
          ),
          
          //dot indicators
          Container(
            alignment: Alignment(0, 0.90),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect())
          ),

        
        ],
      )   
          );
        
  }}
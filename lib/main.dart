import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primaryColor: Colors.white, // Set the primary color to white
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // Custom Heading
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60), // Spacer

              // General Information Text
              Text(
                'General Information',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Enter your business details',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              // Text Boxes with space between them
              SizedBox(height: 18),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter your first name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16), // Add space
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16), // Add space
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16), // Add space
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Spacer
              SizedBox(height: 16), // Add space
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Add logic to update and save changes here
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF006BCE), // 006BCE color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded button
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Update and Save Changes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

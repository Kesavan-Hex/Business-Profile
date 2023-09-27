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
        primaryColor: Colors.white,
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
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController webURLController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? businessNameError;
  String? webURLError;
  String? addressError;

  @override
  void dispose() {
    businessNameController.dispose();
    webURLController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      businessNameError = businessNameController.text.isEmpty
          ? 'Business Name is required'
          : null;

      final webURL = webURLController.text;
      webURLError = webURL.isEmpty
          ? 'Web URL is required'
          : (!webURL.contains('.'))
              ? 'Invalid URL format'
              : null;

      addressError =
          addressController.text.isEmpty ? 'Address is required' : null;

      final phoneNumber = phoneNumberController.text;
      if (phoneNumber.isNotEmpty) {
        if (!isValidPhoneNumber(phoneNumber)) {
          // Phone number is not valid
          //phoneNumberController.clear(); // Clear the input
          phoneNumberController.text = ''; // Set it as an empty string
        }
      }
    });

    if (_formKey.currentState!.validate()) {
      // All fields are valid, you can proceed with saving the data.
      // Add your logic here.
      print('Data can be saved');
    }
  }

  // Function to check if a string is a valid phone number
  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[0-9]+$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 25,
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1CADFF),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 60), // Spacer

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

                SizedBox(height: 18),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: businessNameController,
                    decoration: InputDecoration(
                      labelText: 'Business Name',
                      hintText: 'Burger King',
                      border: OutlineInputBorder(),
                      errorText: businessNameError,
                    ),
                    validator: (value) {
                      return businessNameError;
                    },
                  ),
                ),
                SizedBox(height: 16), // Add space
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: webURLController,
                    decoration: InputDecoration(
                      labelText: 'Web URL',
                      hintText: 'sourcecoders.in',
                      border: OutlineInputBorder(),
                      errorText: webURLError,
                    ),
                    validator: (value) {
                      return webURLError;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Address',
                      border: OutlineInputBorder(),
                      errorText: addressError,
                    ),
                    validator: (value) {
                      return addressError;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number (optional) ',
                      hintText: 'Phone Number (optional)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !isValidPhoneNumber(value)) {
                        return 'Invalid phone number format';
                      }
                      return null; // Return null if the phone number is valid or empty
                    },
                  ),
                ),

                // Spacer
                SizedBox(height: 16), // Add space
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _validateFields,
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF006BCE),
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

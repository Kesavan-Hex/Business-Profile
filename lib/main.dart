import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  String? selectedBusinessType;
  String? chosenLocation;

  int _currentSegmentIndex = 0;

  final List<String> _segmentLabels = [
    'General Info',
    'Business Info',
    'Business Assets',
    'Business Verification',
  ];

  // Dropdown value
  String? _selectedBusinessType;

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
          phoneNumberController.text = '';
        }
      }
    });

    if (_formKey.currentState!.validate()) {
      print('Data can be saved');
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[0-9]+$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 35),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Handle back button press here
                      },
                      child: Container(
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
                    ),
                    SizedBox(width: 8),
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
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      for (int i = 0; i < _segmentLabels.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentSegmentIndex = i;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _currentSegmentIndex == i
                                      ? Color(0xFF1CADFF)
                                      : Colors.transparent,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Text(
                              _segmentLabels[i],
                              style: TextStyle(
                                color: _currentSegmentIndex == i
                                    ? Color(0xFF1CADFF)
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (_currentSegmentIndex == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'General Information',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter your business details',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
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
                          SizedBox(height: 16),
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
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    // Inside the Content for Business Information segment
                    // Inside the Content for Business Information segment
                    if (_currentSegmentIndex == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Display Business Information',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20), // Reduce space
                          Text(
                            'Select your business type and mark location.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          SizedBox(height: 20), // Reduce space
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2,
                              ), // Border
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Family Owned Business',
                                  child: Text('Family Owned Business'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Partnership',
                                  child: Text('Partnership'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Solo Business',
                                  child: Text('Solo Business'),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedBusinessType = newValue;
                                });
                              },
                              value:
                                  selectedBusinessType, // Display selected value
                              hint: Text('Select your business type'),
                              isExpanded: true,
                              underline: Container(), // Remove the underline
                            ),
                          ),
                          SizedBox(height: 25), // Reduce space
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String locationText =
                                      ''; // To store the entered text

                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Add Location',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextField(
                                            onChanged: (value) {
                                              locationText =
                                                  value; // Update the entered text
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter location',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                chosenLocation = locationText;
                                              });
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(
                                                  0xFF0085FF), // Button color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: Text('Choose'),
                                          ),
                                          SizedBox(height: 10),

                                          // Display the chosen location
                                          if (chosenLocation != null)
                                            Text(
                                              'Chosen Location: $chosenLocation',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF0085FF), // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8), // Add space
                                  Text(
                                    'Add Location',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _validateFields,
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF006BCE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
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

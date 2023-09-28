import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      home: MyHomePage(),
    );
  }
}

class BusinessProfile {
  String? businessName;
  String? webURL;
  String? address;
  String? phoneNumber;
  String? businessType;
  String? location;
  File? logoImage;
  String? description;
  List<String> socialMediaLinks = [];

  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'webURL': webURL,
      'address': address,
      'phoneNumber': phoneNumber,
      'businessType': businessType,
      'location': location,
      'description': description,
      'socialMediaLinks': socialMediaLinks,
    };
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController webURLController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instagramLinkController = TextEditingController();
  final TextEditingController linkedInLinkController = TextEditingController();
  final TextEditingController facebookLinkController = TextEditingController();
  final TextEditingController twitterLinkController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();

  File? _logoImage;

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

  BusinessProfile businessProfile = BusinessProfile();

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

  void _saveGeneralInfo() {
    businessProfile.businessName = businessNameController.text;
    businessProfile.webURL = webURLController.text;
    businessProfile.address = addressController.text;
    businessProfile.phoneNumber = phoneNumberController.text;
    _moveToNextScreen();
  }

  void _moveToNextScreen() {
    if (_currentSegmentIndex < _segmentLabels.length - 1) {
      setState(() {
        _currentSegmentIndex++;
      });
    }
  }

  void _saveBusinessInfo() {
    businessProfile.businessType = selectedBusinessType;
    businessProfile.location = chosenLocation;
    _moveToNextScreen();
  }

  void _saveBusinessAssets() {
    businessProfile.logoImage = _logoImage;
    businessProfile.description = descriptionController.text;
    _moveToNextScreen();
  }

  void _updateAndSaveChanges() {
    // Save all changes and update here
    businessProfile.socialMediaLinks = [
      instagramLinkController.text,
      linkedInLinkController.text,
      facebookLinkController.text,
      twitterLinkController.text,
      youtubeLinkController.text,
    ];

    // Log the updated businessProfile
    _logDataInJson(businessProfile);
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
                          SizedBox(height: 16),
                        ],
                      ),
                    if (_currentSegmentIndex == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Business Information',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Select your business type and mark location.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2,
                              ),
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
                              value: selectedBusinessType,
                              hint: Text('Select your business type'),
                              isExpanded: true,
                              underline: Container(),
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String locationText = '';

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
                                              locationText = value;
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
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF0085FF),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: Text('Choose'),
                                          ),
                                          SizedBox(height: 10),
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
                              primary: Color(0xFF0085FF),
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
                                  SizedBox(width: 8),
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
                          if (chosenLocation != null)
                            Text(
                              'Chosen Location: $chosenLocation',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          SizedBox(height: 20),
                        ],
                      ),
                    if (_currentSegmentIndex == 2)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Business Assets',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Add Business logo and description',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                              );

                              if (pickedFile != null) {
                                setState(() {
                                  _logoImage = File(pickedFile.path);
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF0085FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Insert Business Logo',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (_logoImage != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Business Logo',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Image.file(
                                    _logoImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 20),
                          TextFormField(
                            maxLines: 4,
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'Enter your business description...',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Handle the entered description text here
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    if (_currentSegmentIndex == 3)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Business Verification',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Add social media links for better reach',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 18),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: instagramLinkController,
                              decoration: InputDecoration(
                                labelText: 'Instagram Link (Optional)',
                                hintText: 'https://www.instagram.com/',
                                border: OutlineInputBorder(),
                              ),
                              // Handle Instagram link here
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: linkedInLinkController,
                              decoration: InputDecoration(
                                labelText: 'LinkedIn Link (Optional)',
                                hintText: 'https://www.linkedin.com/in/',
                                border: OutlineInputBorder(),
                              ),
                              // Handle LinkedIn link here
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: facebookLinkController,
                              decoration: InputDecoration(
                                labelText: 'Facebook Link (Optional)',
                                hintText: 'https://www.facebook.com/',
                                border: OutlineInputBorder(),
                              ),
                              // Handle Facebook link here
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: twitterLinkController,
                              decoration: InputDecoration(
                                labelText: 'Twitter Link (Optional)',
                                hintText: 'https://twitter.com/',
                                border: OutlineInputBorder(),
                              ),
                              // Handle Twitter link here
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: youtubeLinkController,
                              decoration: InputDecoration(
                                labelText: 'YouTube Link (Optional)',
                                hintText: 'https://www.youtube.com/',
                                border: OutlineInputBorder(),
                              ),
                              // Handle YouTube link here
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (_currentSegmentIndex == 0)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _saveGeneralInfo();
                    _logDataInJson(businessProfile);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF006BCE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Save General Info',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentSegmentIndex == 1)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _saveBusinessInfo();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF006BCE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Save Business Info',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentSegmentIndex == 2)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _saveBusinessAssets();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF006BCE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Save Business Assets',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentSegmentIndex == 3)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _updateAndSaveChanges();
                    _logDataInJson(businessProfile);
                  },
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
          ],
        ),
      ),
    );
  }

  void _logDataInJson(BusinessProfile businessProfile) {
    final jsonData = json.encode(businessProfile.toJson());
    print(jsonData);
  }
}

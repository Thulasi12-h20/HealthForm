import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medical_health_form/applicantformUI2.dart';
import 'package:medical_health_form/application_form/roundedbutton.dart';

import 'applicant.dart';
import 'numberformatt.dart';
import 'textfiled.dart';

// Define a Custom Form Widget
class ApplicantForm extends StatefulWidget {
  static const String id = "apply_screen";

  @override
  _ApplicantFormState createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  Applicant applicant = Applicant();
  Future<String> loadApplicant;

  @override
  void initState() {
    super.initState();
    getApplicant();
  }

  Future getImage() async {
    /*  var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 250.0, maxWidth: 340.0);*/

//    applicant.licenseImageFile = image;

    setState(() {
      // applicant.licenseImageFile = image;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _firstnameTextController.dispose();
    _lastnameTextController.dispose();
    _officenameTextController.dispose();
    _dptnameTextController.dispose();
    _address1nameTextController.dispose();
    _address2nameTextController.dispose();
    _cellPhoneNumberTextController.dispose();
    _faxNumberTextController.dispose();

    _emailTextController.dispose();
    _cityTextController.dispose();
    _stateTextController.dispose();
    _zipTextController.dispose();
    super.dispose();
  }

  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  TextEditingController _officenameTextController = TextEditingController();
  TextEditingController _dptnameTextController = TextEditingController();
  TextEditingController _address1nameTextController = TextEditingController();
  TextEditingController _address2nameTextController = TextEditingController();
  TextEditingController _cellPhoneNumberTextController =
      TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _faxNumberTextController = TextEditingController();
  TextEditingController _cityTextController = TextEditingController();
  TextEditingController _stateTextController = TextEditingController();
  TextEditingController _zipTextController = TextEditingController();

  getApplicant() async {
    Future<bool> loaded;
    loaded = applicant.loadApplicant();
    loaded.then(
      (value) {
        _firstnameTextController.text = applicant.name;
        _lastnameTextController.text = applicant.name;
        _officenameTextController.text = applicant.name;
        _dptnameTextController.text = applicant.name;
        _address1nameTextController.text = applicant.name;
        _address2nameTextController.text = applicant.name;
        _emailTextController.text = applicant.email;
        _cellPhoneNumberTextController.text = applicant.cellPhoneNumber;
        _faxNumberTextController.text = applicant.cellPhoneNumber;
        _cityTextController.text = applicant.city;
        _stateTextController.text = applicant.state;
        _zipTextController.text = applicant.zip;
        setState(() {});
      },
    );
  }

  void saveApplicant() {
    try {
      applicant.saveApplicant();
    } catch (e) {
      print(e);
    }
  }

  void processApplicant() async {
    try {
//      await applicant.processApplication();
      applicant.processApplication();
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final UsPhoneTextInputFormatter _phoneNumberFormatter =
      UsPhoneTextInputFormatter();
  final UsPhoneTextInputFormatter _faxNumberFormatter =
      UsPhoneTextInputFormatter();

  final ZipTextInputFormatter _zipTextInputFormatter = ZipTextInputFormatter();

//  bool _formWasEdited = false;

  String _validateName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Requestors First Name';
    if (value.length < 3) return '5 or more characters';
    return null;
  }

  String _validatLasteName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Requestors Last Name';
    if (value.length < 2) return '5 or more characters';
    return null;
  }

  String _validatOfficeName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Institution/Office Name*';
    if (value.length < 2) return '5 or more characters';
    return null;
  }

  String _validatdeptName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Department Name*';
    if (value.length < 2) return '5 or more characters';
    return null;
  }

  String _validatofficeAddressName1(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Institution Address1';
    if (value.length < 5) return '5 or more characters';
    return null;
  }

  String _validatofficeAddressName2(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Institution Address1';
    if (value.length < 5) return '5 or more characters';
    return null;
  }

  String _validatePhoneNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) return '10 digit phone #';
    return null;
  }

  String _validateFaxNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) return '10 digit or More Fax #';
    return null;
  }

  String _validateEmail(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter email address';
    if (value.length < 4) return '8 or more characters';
    if (!value.contains('@')) return 'Missing @';
    return null;
  }

  String _validateCity(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter City';
    if (value.length < 3) return '3 or more characters';
    return null;
  }


  String _validateZip(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter zipcode';
    if (value.length < 5) return '5 or more chars';
    if (value.length == 5) {
      final RegExp zip1Exp = RegExp(r'\d\d\d\d\d$');
      if (zip1Exp.hasMatch(value)) {
        return null;
      } else {
        return 'Invalid';
      }
    }
    if (value.length == 10) {
      final RegExp zip2Exp = RegExp(r'\d\d\d\d\d\-\d\d\d\d$');
      if (zip2Exp.hasMatch(value)) {
        return null;
      } else {
        return 'Invalid';
      }
    }
    return '5 or 9 digits';
  }


  Widget rowspacer = Container(
    height: 10.0,
  );
  List designation = ["MD", "DO", "NP"];

  String select;
  String _chosenValue;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: designation[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
//    sleep(const Duration(seconds: 1));
//    setState(() {});

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        body: ListView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    // color: Colors.amber[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'A.Healthcare Professinoal Contract Information:',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: ' Requestors First Name'),
                                controller: _firstnameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validateName,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: ' Requestors Last Name'),
                                controller: _lastnameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatLasteName,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Text(
                              "Designation:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        // new Row(
                        //   children: <Widget>[
                        //     rowspacer,
                        //     addRadioButton(0, 'MD'),
                        //     addRadioButton(1, 'DO'),
                        //     addRadioButton(2, 'NP'),
                        //
                        //     //addRadioButton(3, 'PA'),
                        //   ],
                        // ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.home_work_outlined),
                                    hintText: 'Institution/Office'),
                                controller: _officenameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatOfficeName,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: 'Department'),
                                controller: _dptnameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatdeptName,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.person),
                                    hintText:
                                        ' Institution/Office Adress Line1'),
                                controller: _address1nameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatofficeAddressName1,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.person),
                                    hintText:
                                        'Institution/Office Adress Line2'),
                                controller: _address2nameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatofficeAddressName2,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: DropdownButtonFormField<String>(
                                value: _chosenValue,
                                //elevation: 5,
                                style: TextStyle(color: Colors.black),

                                items: <String>[
                                  'Andhra Pradesh',
                                  'Arunachal Pradesh',
                                  'Assam',
                                  'Bihar',
                                  'Chhattisgarh',
                                  'Goa',
                                  'Gujarat',
                                  'Haryana',
                                  'Himachal Pradesh',
                                  'Jharkhand',
                                  'Karnataka',
                                  'Kerala',
                                  'Madhya Pradesh',
                                  'Maharashtra',
                                  'Manipur',
                                  'Meghalaya',
                                  'Mizoram',
                                  'Nagaland',
                                  'Odisha',
                                  'Punjab',
                                  'Rajasthan',
                                  'Sikkim',
                                  'Tamil Nadu',
                                  'Telangana',
                                  'Tripura',
                                  'Uttarakhand',
                                  'Uttar Pradesh',
                                  'West Bengal',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.location_city),
                                    hintText: 'State'),

                                onChanged: (String value) {
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.location_city_sharp),
                                    hintText: 'City'),
                                controller: _cityTextController,
                                onSaved: (String value) {
                                  applicant.city = value;
                                },
                                validator: _validateCity,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.home),
                                    hintText: 'ZiP'),
                                controller: _zipTextController,
                                onSaved: (String value) {
                                  applicant.zip = value;
                                },
                                validator: _validateZip,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(7),
                                  FilteringTextInputFormatter.digitsOnly,
                                  _zipTextInputFormatter,
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: 'Phone Number '),
                                controller: _cellPhoneNumberTextController,
                                onSaved: (String value) {
                                  applicant.cellPhoneNumber = value;
                                },
                                validator: _validatePhoneNumber,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(14),
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Fit the validating format.
                                  _phoneNumberFormatter,
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.ten_mp),
                                    hintText: 'Fax Nummber '),
                                controller: _faxNumberTextController,
                                onSaved: (String value) {
                                  applicant.cellPhoneNumber = value;
                                },
                                validator: _validateFaxNumber,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(14),
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Fit the validating format.
                                  _faxNumberFormatter,
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Email address'),
                                controller: _emailTextController,
                                onSaved: (String value) {
                                  applicant.email = value;
                                },
                                validator: _validateEmail,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(35),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9.@]")),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                        rowspacer,
                        Column(
                          children: <Widget>[
                            RoundedButton(
                              title: 'Next',
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ApplicantForm2()));
                                }
                              },
                            ),
                          ],
                        ),
                      ],
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
}

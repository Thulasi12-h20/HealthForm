import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medical_health_form/application_form/roundedbutton.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'application_form/applicant.dart';
import 'application_form/applicationUi3.dart';
import 'application_form/numberformatt.dart';
import 'application_form/textfiled.dart';

// Define a Custom Form Widget
class ApplicantForm2 extends StatefulWidget {
  static const String id = "apply_screen";

  @override
  _ApplicantForm2State createState() => _ApplicantForm2State();
}

class _ApplicantForm2State extends State<ApplicantForm2> {
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
    _descriptionameTextController.dispose();

    _birthdayTextController.dispose();
    _patientnameTextController.dispose();
    _dorTextController.dispose();
    super.dispose();
  }

  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _descriptionameTextController = TextEditingController();
  TextEditingController _patientnameTextController = TextEditingController();
  TextEditingController _birthdayTextController = TextEditingController();
  TextEditingController _dorTextController = TextEditingController();

  getApplicant() async {
    Future<bool> loaded;
    loaded = applicant.loadApplicant();
    loaded.then(
      (value) {
        _firstnameTextController.text = applicant.name;
        _descriptionameTextController.text = applicant.name;
        _patientnameTextController.text = applicant.name;
        _birthdayTextController.text = applicant.birthday;
        _dorTextController.text = applicant.birthday;
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

  final UsDateTextInputFormatter _dateTextInputFormatter =
      UsDateTextInputFormatter();

//  bool _formWasEdited = false;

  String _validateName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Requestors First Name*';
    if (value.length < 5) return '5 or more characters';
    return null;
  }

  String _validateDescription(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Please Write the Description*';
    if (value.length < 8) return '10 or more characters';
    return null;
  }

  String _validatePatientName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Patient Name*';
    if (value.length < 3) return '5 or more characters';
    return null;
  }

  String _validateDate(String value) {
//    _formWasEdited = true;
//    final RegExp dateExp = RegExp(r'\d\d\/\d\d\/\d\d\d\d$');
    final RegExp dateExp =
        RegExp(r'^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$');
    if (!dateExp.hasMatch(value)) return 'mmddyyyy';
    return null;
  }

  Widget rowspacer = Container(
    height: 10.0,
  );
  List designation = ["MD", "DO", "NP"];

  String select;
  List gender = ["Male", "Female", "Other"];

  String select1;
  bool _checkprd = false;
  bool _checkprd1 = false;
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;

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

  Row addRadioButton1(int btnValue1, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue1],
          groupValue: select1,
          onChanged: (value) {
            setState(() {
              print(value);
              select1 = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Medical Information Request Form"),
        ),
        backgroundColor: Colors.amber[50],
        body: ListView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
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
                              'B.UnSolicited Information Request:',
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
                            Text(
                              "Choose Products:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _checkprd,
                              onChanged: (value) {
                                setState(() {
                                  _checkprd = !_checkprd;
                                });
                              },
                            ),
                            Text('10MG-Roszet'),
                            Checkbox(
                              value: _checkprd1,
                              onChanged: (value) {
                                setState(() {
                                  _checkprd1 = !_checkprd1;
                                });
                              },
                            ),
                            Text('20MGRoszet'),
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
                                    hintText: 'Request Description'),
                                controller: _descriptionameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validateDescription,
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(50),
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
                              "Please Check One:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            addRadioButton(0, 'MD'),
                            addRadioButton(1, 'DO'),
                            addRadioButton(2, 'NP'),

                            //addRadioButton(3, 'PA'),
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
                                    hintText: 'Patient Name'),
                                controller: _patientnameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validatePatientName,
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
                                keyboardType: TextInputType.datetime,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.cake),
                                    hintText: 'DOB mm/dd/yyyy'),
                                controller: _birthdayTextController,
                                validator: _validateDate,
                                onSaved: (String value) {
                                  applicant.birthday = value;
                                },
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Fit the validating format.
                                  _dateTextInputFormatter,
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
                              "Gender:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            addRadioButton1(0, 'Male'),
                            addRadioButton1(1, 'Female'),
                            addRadioButton1(2, 'Other'),
                            //addRadioButton(3, 'PA'),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.request_quote),
                                    hintText: 'DOR 06/dd/2020'),
                                controller: _dorTextController,
                                validator: _validateDate,
                                onSaved: (String value) {
                                  applicant.birthday = value;
                                },
                                // TextInputFormatters are applied in sequence.
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Fit the validating format.
                                  _dateTextInputFormatter,
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
                              "Prefered Method of Response:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _checkbox,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
                                });
                              },
                            ),
                            Text('Fax'),
                            Checkbox(
                              value: _checkbox1,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox1 = !_checkbox1;
                                });
                              },
                            ),
                            Text('Mail'),
                            Checkbox(
                              value: _checkbox2,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox2 = !_checkbox2;
                                });
                              },
                            ),
                            Text('Email'),
                            Checkbox(
                              value: _checkbox3,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox3 = !_checkbox3;
                                });
                              },
                            ),
                            Text('Phone'),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            Text(
                              "Health Care professional's Signature:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                          children: <Widget>[
                            SfSignaturePad(
                              backgroundColor: Colors.grey[200],
                              onSignStart: () => {
                                print(
                                    "Signature has been initiated in SignaturePad"),
                              },
                              onSignEnd: () => {
                                print(
                                    "Signature has been completed in SignaturePad"),
                              },
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
                                              ApplicantForm3()));
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

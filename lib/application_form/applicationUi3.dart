import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medical_health_form/application_form/roundedbutton.dart';
import 'package:medical_health_form/application_form/textfiled.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'applicant.dart';
import 'numberformatt.dart';

// Define a Custom Form Widget
class ApplicantForm3 extends StatefulWidget {
  static const String id = "apply_screen";

  @override
  _ApplicantForm3State createState() => _ApplicantForm3State();
}

class _ApplicantForm3State extends State<ApplicantForm3> {
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
    _cellphoneNumberTextController.dispose();

    _territoryNumberTextController.dispose();
    _descriptionameTextController.dispose();
    _countrycodeTextController.dispose();
    super.dispose();
  }

  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _representavtivetypeTextController =
      TextEditingController();
  TextEditingController _descriptionameTextController = TextEditingController();
  TextEditingController _countrycodeTextController = TextEditingController();
  TextEditingController _territoryNumberTextController =
      TextEditingController();
  TextEditingController _cellphoneNumberTextController =
      TextEditingController();

  getApplicant() async {
    Future<bool> loaded;
    loaded = applicant.loadApplicant();
    loaded.then(
      (value) {
        _firstnameTextController.text = applicant.name;
        _descriptionameTextController.text = applicant.name;
        _cellphoneNumberTextController.text = applicant.cellPhoneNumber;
        _territoryNumberTextController.text = applicant.cellPhoneNumber;
        _representavtivetypeTextController.text = applicant.name;
        _countrycodeTextController.text = applicant.cellPhoneNumber;

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

//  bool _formWasEdited = false;

  String _validateName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Requestors First Name*';
    if (value.length < 3) return '5 or more characters';
    return null;
  }

  String _validateDescription(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Please Write the Description*';
    if (value.length < 8) return '10 or more characters';
    return null;
  }

  String _validateNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) return 'Territory number';
    return null;
  }

  String _validatePhoneNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) return '10 digit phone #';
    return null;
  }

  String _validatecountrycode(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 3)
      return 'Country Code must be of 3 digit';
    else
      return null;
  }



  Widget rowspacer = Container(
    height: 10.0,
  );

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
                              'C. Representative Contact Information: ',
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
                                "By Submitting this form,I certify that is request \nfor information was initiated by\nHealth Care Professional stated above,\nand was not solicited by me in any  manner."),
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
                                    hintText: 'Representative Name'),
                                controller: _descriptionameTextController,
                                onSaved: (String value) {
                                  applicant.name = value;
                                },
                                validator: _validateName,
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
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon: Icon(Icons.perm_identity),
                                    hintText: 'Representative Type'),
                                controller: _representavtivetypeTextController,
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
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: kTextFieldDecoration.copyWith(
                                    prefixIcon:
                                        Icon(Icons.phone_android_rounded),
                                    hintText:
                                        'Representative Territory Number'),
                                controller: _territoryNumberTextController,
                                onSaved: (String value) {
                                  applicant.cellPhoneNumber = value;
                                },
                                validator: _validateNumber,
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
                                    prefixIcon: Icon(Icons.add),
                                    hintText: 'Country Code'),
                                controller: _countrycodeTextController,
                                onSaved: (String value) {
                                  applicant.cellPhoneNumber = value;
                                },
                                validator: _validatecountrycode,
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
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: 'Primary TelePhone Number'),
                                controller: _cellphoneNumberTextController,
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
                        Column(
                          children: <Widget>[
                            RoundedButton(
                                title: 'Submit',
                                color: Colors.lightBlueAccent,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    // The save method saves the form so you can access the fields.
                                    _formKey.currentState.save();
                                    applicant.saveApplicant();
                                    processApplicant();
                                    Alert(
                                      context: context,
                                      type: AlertType.info,
                                      title: "Gridlex Careers",
                                      desc:
                                          "Form Successfully Saved Locally. \nWill Upload to the server once the internet connection is back",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Complete",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          color: Colors.amberAccent[100],
                                          radius: BorderRadius.circular(0.0),
                                        ),
                                      ],
                                    ).show();
                                  }
                                  setState(() {});
                                }),
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

import 'dart:convert';

import 'package:Krowl/Data/Degree_data.dart';
import 'package:Krowl/Data/University_data.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/DateOfBirth.dart';
import 'package:Krowl/widgets/MyDrawer.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/Settings/EditTextInput2.dart';
import 'package:Krowl/widgets/Settings/ListOfUniversities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/TabBar/CustomTabBar.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Settings()));

class Settings extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  String _firstName = "";
  String _lastName = "";
  String _username = "";
  String _emailAddress = "";
  String _bio = "";

  bool _firstNameIsChanged = false,
      _lastNameIsChanged = false,
      _usernameIsChanged = false,
      _emailAddressIsChanged = false,
      _bioIsChanged = false;

  // _date_of_birthIsChanged = false,
  // _uniIsChanged = false,
  // _majorIsChanged = false,
  // _minorIsChanged = false;

  bool _isLoading = true;

  // String _firstName = "Clara";

  final controllerCity = TextEditingController();
  final controllerCity1 = TextEditingController();
  final controllerCity2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: MediaQuery.of(context).size.width < 700
            ? AppBar(
                backgroundColor: globals.blue1,
                title: Center(
                  child: Text('Krowl'),
                ),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _back();
                    }),
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ],
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(20),
                                width: 540,
                                padding: EdgeInsets.only(
                                    left: 25, right: 25, top: 45, bottom: 45),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: globals.blue2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "First name *",
                                              style: GoogleFonts.nunito(
                                                color: Colors.black,
                                                fontSize: 17,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                width: 170,
                                                child: EditTextInput2(
                                                  initialValue: _firstName,
                                                  hintText: "First name",
                                                  fillColor: Colors.white,
                                                  spaceAllowed: false,
                                                  enterAllowed: true,
                                                  obscure: false,
                                                  suffixIcon: InkWell(
                                                      onTap: () {
                                                        print("Testing icon");
                                                      },
                                                      child: Icon(
                                                        Icons.done,
                                                        color: globals.blue1,
                                                        size: 30,
                                                      )),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 150,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Last name *",
                                              style: GoogleFonts.nunito(
                                                color: Colors.black,
                                                fontSize: 17,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                width: 170,
                                                child: EditTextInput2(
                                                  initialValue: _lastName,
                                                  hintText: "First name",
                                                  fillColor: Colors.white,
                                                  spaceAllowed: false,
                                                  enterAllowed: true,
                                                  obscure: false,
                                                  suffixIcon: InkWell(
                                                      onTap: () {
                                                        print("Testing icon");
                                                      },
                                                      child: Icon(
                                                        Icons.done,
                                                        color: globals.blue1,
                                                        size: 30,
                                                      )),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Email address *",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    EditTextInput2(
                                      initialValue: _emailAddress,
                                      hintText: "Email address",
                                      fillColor: Colors.white,
                                      spaceAllowed: false,
                                      enterAllowed: true,
                                      obscure: false,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            print("Testing icon");
                                          },
                                          child: Icon(
                                            Icons.done,
                                            color: globals.blue1,
                                            size: 30,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Username *",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    EditTextInput2(
                                      initialValue: _username,
                                      hintText: "Username",
                                      fillColor: Colors.white,
                                      spaceAllowed: false,
                                      enterAllowed: true,
                                      obscure: false,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            print("Testing icon");
                                          },
                                          child: Icon(
                                            Icons.done,
                                            color: globals.blue1,
                                            size: 30,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Bio",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    EditTextInput2(
                                      initialValue: _bio,
                                      hintText: "Bio",
                                      spaceAllowed: true,
                                      enterAllowed: true,
                                      obscure: false,
                                      fillColor: Colors.white,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            print("Testing icon");
                                          },
                                          child: Icon(
                                            Icons.done,
                                            color: globals.blue1,
                                            size: 30,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Date of birth *",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DateOfBirth(
                                      fillColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Select your university",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListOfUniversities(
                                      fillColor: Colors.white,
                                      focusedBorderColor: globals.blue1,
                                      enabledBorderColor: globals.blue1,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Select your major degrees",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    buildCity2(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Select your minor degrees (Optional)",
                                      style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    buildCity3(),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => _updateSettings(),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                    color: globals.blue1,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                14)),
                                                    border: Border.all(
                                                        color: globals.blue1,
                                                        width: 4)),
                                                child: Center(
                                                  child: Text(
                                                    'Save Profile',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 18,
                                                      color: globals.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: SizedBox.shrink()),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomTabBar(
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'Settings';
      _loadSettings();
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/intro_page', (route) => false);
    }
  }

  Future<void> _updateSettings() async {
    if (_isLoading == false) {
      _isLoading = true;
      try {
        print('load Update Settings');

        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          _firstNameIsChanged == true ? 'fname' : _firstName: null,
          _lastNameIsChanged == true ? 'lname' : _lastName: null,
          _usernameIsChanged == true ? 'username' : _username: null,
          _emailAddressIsChanged == true ? 'email' : _emailAddress: null,
          _bioIsChanged == true ? 'bio' : _bio: null,

          // _date_of_birthIsChanged == true ? 'date_of_birth' : _date_of_birth: null,
          // _uniIsChanged == true ? 'uni' : _uni: null,
          // _majorIsChanged == true ? 'major' : _major: null,
          // _minorIsChanged == true ? 'minor' : _minor: null,

          _emailAddressIsChanged == true ? 'account_Id' : account_Id: null,
          _bioIsChanged == true ? 'account_Id' : account_Id: null,
        };

        var res = await CallApi().postData(data, '(Control)updateSettings.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              //notif = body[1];
              _firstName = body[2][0];
              _lastName = body[2][1];
              _emailAddress = body[2][2];
              _username = body[2][3];
              _bio = body[2][4];
              //controllerCity.value = body[2][6];
              //date_of_birth = body[2][5];
              //uni_name = body[2][6];
              //major = body[2][7];
              //minor = body[2][8];

              // globals.univercitiesName = body[3];
              // globals.degrees = body[4];

            });
          }

          _isLoading = false;
        } else if (body[0] == "errorVersion") {
          _isLoading = false;
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          _isLoading = false;
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error1") {
          _isLoading = false;
          warningPopup(context, globals.warning1);
        } else if (body[0] == "error2_1") {
          _isLoading = false;
          warningPopup(context, globals.warning2_1);
        } else if (body[0] == "error2_2") {
          _isLoading = false;
          warningPopup(context, globals.warning2_2);
        } else if (body[0] == "error2_4") {
          _isLoading = false;
          warningPopup(context, globals.warning2_4);
        } else if (body[0] == "error2_5") {
          _isLoading = false;
          warningPopup(context, globals.warning2_5);
        } else if (body[0] == "error4") {
          _isLoading = false;
          errorPopup(context, globals.error4);
        } else if (body[0] == "error5") {
          _isLoading = false;
          warningPopup(context, globals.warning5);
        } else if (body[0] == "error6") {
          _isLoading = false;
          warningPopup(context, globals.warning6);
        } else if (body[0] == "error7") {
          _isLoading = false;
          warningPopup(context, globals.warning7);
        } else {
          _isLoading = false;
          errorPopup(context, globals.errorElse);
        }
      } catch (e) {
        _isLoading = false;
        print(e);
        errorPopup(context, globals.errorException);
      }
      print('load Update Settings end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  Future<void> _loadSettings() async {
    try {
      print('load Settings');

      var account_Id = await SessionManager().get('account_Id');

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
      };

      var res = await CallApi().postData(data, '(Control)loadSettings.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        if (mounted) {
          setState(() {
            //notif = body[1];
            _firstName = body[2][0];
            _lastName = body[2][1];
            _emailAddress = body[2][2];
            _username = body[2][3];
            _bio = body[2][4];
            //date_of_birth = body[2][5];
            //uni_name = body[2][6];
            //major = body[2][7];
            //minor = body[2][8];

            //uni list = body[3];
            //major list = body[4];
            globals.univercitiesName = body[3];
            //globals.degrees = body[4];

            // for (int i = 0; i < body[3].length; i++) {
            //   globals.univercitiesName
            //       .add(body[3][i].toString().replaceAll("[", "").replaceAll("]", ""));
            //   //print(globals.univercitiesName);
            // }
            //
            for (int i = 0; i < body[4].length; i++) {
              globals.degrees
                  .add(body[4][i].toString().replaceAll("[", "").replaceAll("]", ""));
              //print(globals.degrees);
            }
          });
        }
        _isLoading = false;
      } else if (body[0] == "errorVersion") {
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "error7") {
        warningPopup(context, globals.warning7);
      } else {
        errorPopup(context, globals.errorElse);
      }
    } catch (e) {
      print(e);
      errorPopup(context, globals.errorException);
    }
    print('load Settings end!!!');
    print(
        '=========<<======================================================<<==================================================<<=========');
  }

  _back() {
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }

  Widget buildCity() => TypeAheadFormField<dynamic>(
        // key: Key(widget.initialValue),
        // initialValue: widget.initialValue!,
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: () {},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globals.blue1),
                borderRadius: BorderRadius.circular(5)),
            filled: true,
            fillColor: Colors.white,
            hintText: "Find your university",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: globals.blue1)),
          ),
          controller: controllerCity,
        ),
        suggestionsCallback: CityData.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (dynamic suggestion) {
          controllerCity.text = suggestion!;
          globals.uniId = suggestion!;
          print(globals.uniId);
        },
      );

  Widget buildCity2() => TypeAheadFormField<dynamic>(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: () {},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globals.blue1),
                borderRadius: BorderRadius.circular(5)),
            filled: true,
            fillColor: Colors.white,
            hintText: "Find your Major",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: globals.blue1)),
          ),
          controller: controllerCity1,
        ),
        suggestionsCallback: CityData2.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (dynamic suggestion) {
          controllerCity1.text = suggestion!;
          globals.majorId = suggestion!;
          print(globals.majorId);
        },
      );

  Widget buildCity3() => TypeAheadFormField<dynamic>(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: () {},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globals.blue1),
                borderRadius: BorderRadius.circular(5)),
            filled: true,
            fillColor: Colors.white,
            hintText: "Find your Minor",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: globals.blue1)),
          ),
          controller: controllerCity2,
        ),
        suggestionsCallback: CityData2.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (dynamic suggestion) {
          controllerCity2.text = suggestion!;
          globals.minorId = suggestion!;
          print(globals.minorId);
        },
      );
}

import 'dart:convert';

import 'package:Krowl/Data/Degree_data.dart';
import 'package:Krowl/Data/University_data.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/DateOfBirth.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/Settings/EditTextInput2.dart';
import 'package:Krowl/widgets/Settings/ListOfUniversities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsContainer extends StatefulWidget {
  SettingsContainer(
      {this.FirstName,
      this.LastName,
      this.EmailAddress,
      required this.Username,
      this.Bio});

  var FirstName;
  var Username;
  var LastName;
  var EmailAddress;
  var Bio;

  @override
  State<SettingsContainer> createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  final controllerCity = TextEditingController();
  final controllerCity1 = TextEditingController();
  final controllerCity2 = TextEditingController();

  String _universityName = "Lebanese University";

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 540,
      padding: EdgeInsets.only(left: 25, right: 25, top: 45, bottom: 45),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: globals.blue2,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        initialValue: widget.FirstName,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        initialValue: widget.LastName,
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
            initialValue: widget.EmailAddress,
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
            initialValue: widget.Username,
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
            initialValue: widget.Bio,
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
          // ListOfUniversities(
          //   fillColor: Colors.white,
          //   focusedBorderColor: globals.blue1,
          //   enabledBorderColor: globals.blue1,
          // ),
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
          // buildCity2(),
          // SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   "Select your minor degrees (Optional)",
          //   style: GoogleFonts.nunito(
          //     color: Colors.black,
          //     fontSize: 17,
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // buildCity3(),
          SizedBox(height: 20),
          Row(
            children: [
              InkWell(
                onTap: () => _updateSettings(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                          color: globals.blue1,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          border: Border.all(color: globals.blue1, width: 4)),
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
    );
  }

  // Widget buildCity() => TypeAheadFormField<dynamic>(
  //       // key: Key(widget.initialValue),
  //       // initialValue: widget.initialValue!,
  //       textFieldConfiguration: TextFieldConfiguration(
  //         autofocus: true,
  //         onEditingComplete: () {},
  //         decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: globals.blue1),
  //               borderRadius: BorderRadius.circular(5)),
  //           filled: true,
  //           fillColor: Colors.white,
  //           hintText: "Find your university",
  //           hintStyle: TextStyle(
  //             fontSize: 15.0,
  //             color: Colors.grey.shade400,
  //           ),
  //           border: InputBorder.none,
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               borderSide: BorderSide(color: globals.blue1)),
  //         ),
  //         controller: controllerCity,
  //       ),
  //       suggestionsCallback: CityData.getSuggestions,
  //       itemBuilder: (context, dynamic suggestion) => ListTile(
  //         title: Text(suggestion!),
  //       ),
  //       onSuggestionSelected: (dynamic suggestion) {
  //         controllerCity.text = suggestion!;
  //         globals.uniId = suggestion!;
  //         print(globals.uniId);
  //       },
  //     );
  //
  // Widget buildCity2() => TypeAheadFormField<dynamic>(
  //       textFieldConfiguration: TextFieldConfiguration(
  //         autofocus: true,
  //         onEditingComplete: () {},
  //         decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: globals.blue1),
  //               borderRadius: BorderRadius.circular(5)),
  //           filled: true,
  //           fillColor: Colors.white,
  //           hintText: "Find your Major",
  //           hintStyle: TextStyle(
  //             fontSize: 15.0,
  //             color: Colors.grey.shade400,
  //           ),
  //           border: InputBorder.none,
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               borderSide: BorderSide(color: globals.blue1)),
  //         ),
  //         controller: controllerCity1,
  //       ),
  //       suggestionsCallback: CityData2.getSuggestions,
  //       itemBuilder: (context, dynamic suggestion) => ListTile(
  //         title: Text(suggestion!),
  //       ),
  //       onSuggestionSelected: (dynamic suggestion) {
  //         controllerCity1.text = suggestion!;
  //         globals.majorId = suggestion!;
  //         print(globals.majorId);
  //       },
  //     );
  //
  // Widget buildCity3() => TypeAheadFormField<dynamic>(
  //       textFieldConfiguration: TextFieldConfiguration(
  //         autofocus: true,
  //         onEditingComplete: () {},
  //         decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: globals.blue1),
  //               borderRadius: BorderRadius.circular(5)),
  //           filled: true,
  //           fillColor: Colors.white,
  //           hintText: "Find your Minor",
  //           hintStyle: TextStyle(
  //             fontSize: 15.0,
  //             color: Colors.grey.shade400,
  //           ),
  //           border: InputBorder.none,
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               borderSide: BorderSide(color: globals.blue1)),
  //         ),
  //         controller: controllerCity2,
  //       ),
  //       suggestionsCallback: CityData2.getSuggestions,
  //       itemBuilder: (context, dynamic suggestion) => ListTile(
  //         title: Text(suggestion!),
  //       ),
  //       onSuggestionSelected: (dynamic suggestion) {
  //         controllerCity2.text = suggestion!;
  //         globals.minorId = suggestion!;
  //         print(globals.minorId);
  //       },
  //     );

  void _updateSettings() {
    debugPrint('Update Settings');
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
        // body[1] : first_name, last_name, email, username, bio, date_of_birth, uni_name, major, minor
        // body[2] : uni list
        // body[3] : major list
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
}

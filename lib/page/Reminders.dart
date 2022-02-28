import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Reminders/EditTextInput.dart';
import 'package:flutter_app_backend/widgets/Reminders/ReminderWidget.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Reminders()));

class Reminders extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders>
    with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();
  bool Enabled = true;
  bool Disabled = true;
  bool _add1 = true;
  bool _add2 = true;
  List<ReminderWidget> _children1 = [];
  List<ReminderWidget> _children2 = [];
  final List<Widget> myTabs = [
    Tab(child: Text("Enabled reminders", style: TextStyle(fontSize: 17.0))),
    Tab(child: Text("Disabled reminders", style: TextStyle(fontSize: 17.0))),
  ];

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    globals.currentPage = 'Reminders';
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    setState(() {
      _children1.addAll([
        ReminderWidget(
            enabled: true,
            ReminderContent: "Something very important",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
            enabled: true,
            ReminderContent: "HELOOOOOOO",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
          enabled: true,
          ReminderContent: "Something very important",
          dropdownValue: 'in',
          //in/every
          hoursValue: 0,
          minutesValue: 2,
        ),
        ReminderWidget(
            enabled: true,
            ReminderContent: "HELOOOOOOO",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
            enabled: true,
            ReminderContent: "Something very important",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
            enabled: true,
            ReminderContent: "HELOOOOOOO",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
      ]);
      _children2.addAll([
        ReminderWidget(
            enabled: true,
            ReminderContent: "Something very important",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
            enabled: true,
            ReminderContent: "HELOOOOOOO",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
      ]);
    });
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  String? dropdownValue1;
  int? dropdownValue2;
  String? dropdownValue3;
  List gender = [
    'every',
    'in',
  ];
  List Time = [
    'minutes',
    'hours',
  ];
  double _value1 = 1;
  double _value2 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 130,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 42,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 355,
                          height: 550,
                          child: Stack(children: [
                            DefaultTextStyle(
                              style: GoogleFonts.nunito(
                                  fontSize: 37, fontWeight: FontWeight.bold),
                              child: AnimatedTextKit(
                                totalRepeatCount: 3,
                                animatedTexts: [
                                  TyperAnimatedText('Reminders',
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                            Positioned(
                              top: 50,
                              child: Container(
                                width: 335,
                                child: Text(
                                  "At Krowl, we understand that everybody is different - what works for you might not work for another student. Thereminders can be completely tailored by you to satisfy your own needs. Whether you use the Pomodoro technique or just go with the flow, remember to take breaks!",
                                  style: GoogleFonts.nunito(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Container(
                          width: 800,
                          height: 600,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                controller: _tabController,
                                labelColor: Colors.black,
                                unselectedLabelColor: globals.blue1,
                                tabs: myTabs,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(left: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _add1 = !_add1;
                                    });
                                    print("Testingg");
                                  },
                                  child: Icon(Icons.add, color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _add1 == false
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Content *",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                                width: 550,
                                                                child:
                                                                    EditTextInput(
                                                                  FocusedBorderColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  BorderColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  hintText:
                                                                      "ReminderContent",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  focusColor: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  cursorColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                )),
                                                            SizedBox(
                                                                height: 15),
                                                            Text(
                                                              "When do you want to receive this reminder ? *",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 17,
                                                                      right:
                                                                          17),
                                                              width: 550,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child:
                                                                  DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                  hint: Text(
                                                                    'every',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  value:
                                                                      dropdownValue1,
                                                                  onChanged:
                                                                      (String?
                                                                          genderNewValue) {
                                                                    setState(
                                                                      () {
                                                                        dropdownValue1 =
                                                                            genderNewValue;
                                                                      },
                                                                    );
                                                                  },
                                                                  items: gender.map<
                                                                      DropdownMenuItem<
                                                                          String>>(
                                                                    (value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Text(
                                                                          value,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  _value1
                                                                      .round()
                                                                      .toString(),
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "Hrs",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  _value2
                                                                      .round()
                                                                      .toString(),
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "min",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Hours:",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 550,
                                                                  child: Slider(
                                                                      min: 1,
                                                                      max: 59,
                                                                      divisions:
                                                                          58,
                                                                      activeColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                      inactiveColor:
                                                                          globals
                                                                              .blue2,
                                                                      thumbColor:
                                                                          globals
                                                                              .blue1,
                                                                      value:
                                                                          _value1,
                                                                      onChanged:
                                                                          (double
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          _value1 =
                                                                              value;
                                                                          print(
                                                                              _value1);
                                                                        });
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Minutes:",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 550,
                                                                  child: Slider(
                                                                      min: 0,
                                                                      max: 59,
                                                                      divisions:
                                                                          59,
                                                                      activeColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                      inactiveColor:
                                                                          globals
                                                                              .blue2,
                                                                      thumbColor:
                                                                          globals
                                                                              .blue1,
                                                                      value:
                                                                          _value2,
                                                                      onChanged:
                                                                          (double
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          _value2 =
                                                                              value;
                                                                          print(
                                                                              _value2);
                                                                        });
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 90,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          "Clicked Save");
                                                                      setState(
                                                                          () {
                                                                        _add1 =
                                                                            !_add1;
                                                                      });
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(globals
                                                                                .blue1),
                                                                        shadowColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .transparent),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4.0),
                                                                            side: BorderSide(color: globals.blue1)))),
                                                                    child: Text(
                                                                      "Create",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 90,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          "Clicked Cancel");
                                                                      setState(
                                                                          () {
                                                                        _add1 =
                                                                            !_add1;
                                                                      });
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(globals
                                                                                .blue2),
                                                                        shadowColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .transparent),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4.0),
                                                                            side: BorderSide(color: globals.blue2)))),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          color:
                                                                              globals.blue1),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 10,
                                                      ),
                                                if (Enabled)
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: _children1,
                                                  ),
                                                if (!Enabled)
                                                  Text(
                                                    "You don't have any enabled reminders. Create one by clicking on the add button above, or check your disabled reminders.",
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 17,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _add2 == false
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Content *",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                                width: 550,
                                                                child:
                                                                    EditTextInput(
                                                                  FocusedBorderColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  BorderColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  hintText:
                                                                      "ReminderContent",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  focusColor: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  cursorColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                )),
                                                            SizedBox(
                                                                height: 15),
                                                            Text(
                                                              "When do you want to receive this reminder ? *",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 17,
                                                                      right:
                                                                          17),
                                                              width: 550,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child:
                                                                  DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                  hint: Text(
                                                                    'every',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  value:
                                                                      dropdownValue1,
                                                                  onChanged:
                                                                      (String?
                                                                          genderNewValue) {
                                                                    setState(
                                                                      () {
                                                                        dropdownValue1 =
                                                                            genderNewValue;
                                                                      },
                                                                    );
                                                                  },
                                                                  items: gender.map<
                                                                      DropdownMenuItem<
                                                                          String>>(
                                                                    (value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Text(
                                                                          value,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  _value1
                                                                      .round()
                                                                      .toString(),
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "Hrs",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  _value2
                                                                      .round()
                                                                      .toString(),
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "min",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Hours:",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 550,
                                                                  child: Slider(
                                                                      min: 1,
                                                                      max: 59,
                                                                      divisions:
                                                                          58,
                                                                      activeColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                      inactiveColor:
                                                                          globals
                                                                              .blue2,
                                                                      thumbColor:
                                                                          globals
                                                                              .blue1,
                                                                      value:
                                                                          _value1,
                                                                      onChanged:
                                                                          (double
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          _value1 =
                                                                              value;
                                                                          print(
                                                                              _value1);
                                                                        });
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Minutes:",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 550,
                                                                  child: Slider(
                                                                      min: 0,
                                                                      max: 59,
                                                                      divisions:
                                                                          59,
                                                                      activeColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                      inactiveColor:
                                                                          globals
                                                                              .blue2,
                                                                      thumbColor:
                                                                          globals
                                                                              .blue1,
                                                                      value:
                                                                          _value2,
                                                                      onChanged:
                                                                          (double
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          _value2 =
                                                                              value;
                                                                          print(
                                                                              _value2);
                                                                        });
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 90,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          "Clicked Save");
                                                                      setState(
                                                                          () {
                                                                        _add2 =
                                                                            !_add2;
                                                                      });
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(globals
                                                                                .blue1),
                                                                        shadowColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .transparent),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4.0),
                                                                            side: BorderSide(color: globals.blue1)))),
                                                                    child: Text(
                                                                      "Create",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  width: 90,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          "Clicked Cancel");
                                                                      setState(
                                                                          () {
                                                                        _add2 =
                                                                            !_add2;
                                                                      });
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(globals
                                                                                .blue2),
                                                                        shadowColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .transparent),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4.0),
                                                                            side: BorderSide(color: globals.blue2)))),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          color:
                                                                              globals.blue1),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 10,
                                                      ),
                                                if (Disabled)
                                                  Column(
                                                    children: _children2,
                                                  ),
                                                if (!Disabled)
                                                  Text(
                                                    "You don't have any enabled reminders. Create one by clicking on the add button above, or check your disabled reminders.",
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 17,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ][_tabController.index],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          CustomTabBar(),
        ],
      ),
    );
  }
}

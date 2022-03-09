import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/MyCustomScrollBehavior.dart';
import 'package:flutter_app_backend/widgets/Reminders/AddWidget.dart';
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
  //FocusNode _focusNode = FocusNode();
  int thisTabBar = 0;
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
            enabled: false,
            ReminderContent: "Something very important",
            dropdownValue: 'in',
            //in/every
            hoursValue: 0,
            minutesValue: 2),
        ReminderWidget(
            enabled: false,
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

  // double _value1 = 1;
  // double _value2 = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
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
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 42,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 30,),
                              Container(
                                width: 355,
                                height: 550,
                                child: Stack(children: [
                                  DefaultTextStyle(
                                    style: GoogleFonts.nunito(
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold),
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
                                      onTap: (val) {
                                        thisTabBar = val;
                                        print(val);
                                        // setState(() {
                                        //   add1.addBool = false;
                                        //   for(int i = 0; i< _children1.length; i++){
                                        //     _children1[i].edit = false;
                                        //   }
                                        //   add2.addBool = false;
                                        //   for(int j = 0; j< _children2.length; j++){
                                        //     _children2[j].edit = false;
                                        //   }
                                        // });
                                      },
                                      controller: _tabController,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: globals.blue1,
                                      tabs: myTabs,
                                    ),
                                    [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(32),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AddWidget1(),
                                                  _children1 == 0
                                                      ? Text(
                                                          "You don't have any enabled reminders. Create one by clicking on the add button above, or check your disabled reminders.",
                                                          style:
                                                              GoogleFonts.nunito(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: _children1,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(32),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AddWidget2(),
                                                  _children2.length == 0
                                                      ? Text(
                                                          "You don't have any enabled reminders. Create one by clicking on the add button above, or check your disabled reminders.",
                                                          style:
                                                              GoogleFonts.nunito(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                        )
                                                      : Column(
                                                          children: _children2,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ][_tabController.index],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width > 700
                ?CustomTabBar(
              color: globals.blue1,
            ):Container(),
          ],
        ),
      ),
    );
  }

  _back() {
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }
}

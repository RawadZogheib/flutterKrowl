library flutterKrowl.globals;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Krowl/widgets/Chat/models/chat_users.dart';
import 'package:Krowl/widgets/Forum/ReplyPage/RepliesWidget.dart';
import 'package:Krowl/widgets/Students/StudentCard.dart';

const String version = "v1.0";

//Server Ip  (page[/my_api.dart])
const String myIP = "https://kwikcode.net";
//const String myIP = "http://127.0.0.1";
const String jaasUrl = "https://KwikCode.net/krowlphp/jit/?table=";

//Colors
Color white = Colors.white;
Color blue1 = Colors.blue.shade900;
Color blue2 = Colors.blue.shade50;
Color red1 = Colors.red.shade900;
Color red2 = Colors.red.shade50;
Color yellow1 = Colors.yellow.shade900;
Color yellow2 = Colors.yellow.shade50;
Color green1 = Colors.green.shade700;
Color green2 = Colors.green.shade50;

//Errors
const String warning1 = "No Spaces Allowed.";
const String warning2_1 = "Your username must contain at least 8 characters.";
const String warning2_2 =
    "Your username can only contain lowercase and uppercase characters and special characters( _ .).";
const String warning2_3 =
    "Your password must contain at least 8 characters, 1 lowercase(a-z),1 uppercase(A-Z),1 numeric character(0-9) and 1 special character(* . ! @ # \$ % ^ & : , ? _ -).";
const String warning2_4 = "Your age must be greater than 17.";
const String warning2_5 = "It's not an email format.";
const String warning2_6 = "It's not a university email.";
const String error3 = "Please make sure your passwords match.";
const String error4 = "Cannot connect to the dataBase.";
const String warning5 = "UserName already exist.";
const String warning6 = "Email already exist.";
const String warning7 = "Field cannot be empty.";
const String warning8 = "Full Table";
const String error9 = "Position Taken";
const String warning10 = "Table name already taken";
const String warningEmptyLibrary = "There is no Table yet";
const String warningEmptyContacts = "You doesn't have contacts yet";
const String warningEmptyFriends = "You doesn't have friends yet";
const String warningEmptyReplyPage = "There is no Replies yet";
const String errorToken = "Token Expired.";
const String errorElse = "Failed to connect... Connection Problem.";
const String errorException =
    "OOPs! Something went wrong. Try again in few seconds.";
const String errorVersion = "New version available.";
const String rememberMe =
    "Stay signed in?\n Do this to reduce the number of times you are asked to sign in.";
//List of Universities
List<dynamic> univercitiesName = [];
//List of Majors
List<dynamic> degrees = [];

//Registration  (page[/signup.dart /registration.dart /registration2.dart /registration3.dart])
String? email = null;
int? val2 = null; //for testing purpose
String? val = null; //for testing purpose
String? fName = null;
String? lName = null;
String? userName = null;
String? password = null;
String? repassword = null;
DateTime? dateOfBirth = null;
int? dateOfBirthCalc = null;
String? photo = null;
String? terms = null;
String? cropX = null;
String? cropY = null;
String? cropWidth = null;
String? cropHeight = null;
String? uniId = null;
String? majorId = null;
String? minorId = null;

//6 Code  (page[/Code.dart])
String? code1 = null;
String? code2 = null;
String? code3 = null;
String? code4 = null;
String? code5 = null;
String? code6 = null;

//login  (page[/login.dart /login2.dart])
String? emailLogin = "";
String? passwordLogin = "";

//global
String? currentPage = "Library"; // Library Chat Forum Students Reminders

//Library
bool loadLibrary = false;
bool loadJoinTableLibrary = false;
bool loadCreateTableLibrary = false;
//var tmpid = null;
//List<String> occupenTable = [];

//Createtable
var tableName;
bool isSilent = false;
bool isPrivet = false;

//Chat
var children2 = <ChatUsers>[];
const apiKey = "yzh74xz7aez6";

//Forum1
bool loadForm1 = false;
bool loadLikeDislikeForm1 = false;

//Forum2
String? dropdown2 = null;
String? question = null;
String? context_question = null;

//Forum3
var children3 = <Replies>[];
String? reply_data = null;

//ReplyPage
bool loadReplyPage = false;
bool loadLikeDislikeReplyPage = false;
bool loadCreateReplyPage = false;

//Student
bool loadStudent = false;
bool loadButtonStudent = false;

//StudentProfile
bool loadStudentProfile = false;
bool loadButtonStudentProfile = false;
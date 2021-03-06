library Krowl.globals;

import 'package:flutter/material.dart';
import 'package:Krowl/widgets/Chat/models/chat_users.dart';
import 'package:Krowl/widgets/Forum/ReplyPage/RepliesWidget.dart';

const String version = "v1.0";

//Server Ip  (page[/my_api.dart])
//const String myIP = "https://krowl.dataflow.com.lb:8070/krowlphpTest/";
//const String myIP = "https://kwikcode.net/krowlphp/";
const String myIP = "https://krowl.dataflow.com.lb:8070/krowlphpTest/";
const String jaasUrl = "${myIP}jit/?table=";
const String initialProfilePath ='https://krowl.dataflow.com.lb:8070/krowlphpTest/Assets/incognitoProfile.png';
// const String myIP = "https://krowl.epizy.com";
// const String jaasUrl = "https://krowl.epizy.com/krowlphp/jit/?table=";
// const String myIP = "https://krowl.42web.io";
// const String jaasUrl = "https://krowl.42web.io/krowlphp/jit/?table=";

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

final Color blue = Colors.blue.shade50;
final Color blue_1 = Colors.blue.shade900;
final Color blue_2 = Colors.blue.shade900.withOpacity(0.5);
final Color red = Colors.red.shade50;
final Color red_1 = Colors.red.shade900;
final Color red_2 = Colors.red.shade900.withOpacity(0.5);
final Color transparent = Colors.transparent;

//for 6 digit code
String? sixCodeNb;

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
const String warningEmptyLibrary = "There is no Table yet";
const String warningEmptyContacts = "You don't have contacts yet";
const String warningEmptyFriends = "You don't have friends yet";
const String warningEmptyReplyPage = "There is no Replies yet";
const String warningEmptyPostPage = "There is no Posts yet";
const String errorToken = "Token Expired.";
const String errorElse = "Failed to connect... Connection Problem.";
const String errorException =
    "OOPs! Something went wrong. Try again in few seconds.";
const String errorVersion = "New version available.";
const String rememberMe =
    "Stay signed in?\n Do this to reduce the number of times you are asked to sign in.";


const String codeFailed = "your code is incorrect";
const String codeException = "Oops Something went wrong! please try to login again!";


const String error401 = "You are already on a table.";


const String warning10 = "Table name already taken";
const String warning11 = "[ a-zA-Z0-9_- ] Allowed";
const String error11 = "This email is not Registered";
const String error12 = "Incorrect Email sent";
const String error13 = "Table Name can contain max 15 Characters";
const String error14 = "Table Name can contain lowercase and uppercase characters and special characters( _,-)";
const String error410 = "You are already on a table.";
const String success415 = 'Participant removed successfully.';
const String success416 = 'Table removed successfully.';
const String error417 = 'Can\'t remove it. Participant is in a meeting.';
const String error418 = 'Can\'t remove it. Participants are in a meeting.';

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
int isRegistered = 0; // 0 -> false -> not registered

//email ForgetPassword
String? emailForgetPass;
String? newPassword;
String? newPassword2;

//6 Code  (page[/Code.dart])
String? code1 = null;
String? code2 = null;
String? code3 = null;
String? code4 = null;
String? code5 = null;
String? code6 = null;

//login  (page[/login.dart /login2.dart])
// String? emailLogin = "";
// String? passwordLogin = "";

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
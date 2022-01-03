library flutterKrowl.globals;

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';

const String version = "v1.0";

//Server Ip  (page[/my_api.dart])
const String myIP = "https://kwikcode.net";
//const String myIP = "http://127.0.0.1";
const String jaasUrl ="https://KwikCode.net/krowl/jit/?table=";

//Colors
Color white = Colors.white;
Color blue1 = Colors.blue.shade900;
Color blue2 = Colors.blue.shade50;


//Errors
const String error1 = "No Spaces Allowed.";
const String error2_1 = "Your username must contain at least 8 characters.";
const String error2_2 = "Your username can only contain lowercase and uppercase characters and special characters( _ .).";
const String error2_3 = "Your password must contain at least 8 characters, 1 lowercase(a-z),1 uppercase(A-Z),1 numeric character(0-9) and 1 special character(* . ! @ # \$ % ^ & : , ? _ -).";
const String error2_4 = "Your age must be greater than 17.";
const String error2_5 = "It's not an email format.";
const String error2_6 = "It's not a university email.";
const String error3 = "Please make sure your passwords match.";
const String error4 = "Cannot connect to the dataBase.";
const String error5 = "UserName already exist.";
const String error6 = "Email already exist.";
const String error7 = "Field cannot be empty.";
const String error8 = "Full Table";
const String error9 = "Position Taken";
const String error10 = "Oops! Can't create the Table";
const String error11 = "Oops! Can't load Tables";
const String errorToken = "Token Error.";
const String errorElse = "Failed to connect... Connection Problem.";
const String errorException = "OOPs! Something went wrong. Try again in few seconds.";
const String errorVersion = "New version available.";
const String errorRememberMe= "Stay signed in?\n Do this to reduce the number of times you are asked to sign in.";
//List of Universities
List<dynamic> univercitiesName = [];
//List of Majors
List<dynamic> degrees = [];

//Registration  (page[/signup.dart /registration.dart /registration2.dart /registration3.dart])
String? email = null;
int?val2=null;  //for testing purpose
String? val=null; //for testing purpose
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
String? emailLogin ="";
String? passwordLogin = "";

//Library
var tmpid = null;
var children = <CustomTable>[];
List<String> occupenTable = [];

//Createtable
var tableName;
var selectedPublicPrivet = '1';
// import 'package:Krowl/Data/University_data.dart';
// import 'package:flutter/material.dart';
// import 'package:Krowl/globals/globals.dart' as globals;
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// class ListOfUniversities extends StatefulWidget {
//   ListOfUniversities ({ required this.fillColor,required this.focusedBorderColor,required this.enabledBorderColor, });
//
//   var fillColor;
//   var focusedBorderColor;
//   var enabledBorderColor;
//
//   @override
//   State<ListOfUniversities> createState() => _ListOfUniversitiesState();
// }
//
// class _ListOfUniversitiesState extends State<ListOfUniversities> {
//   final controllerCity = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadFormField<dynamic>(
//       textFieldConfiguration: TextFieldConfiguration(
//         autofocus: true,
//         onEditingComplete: (){},
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: widget.enabledBorderColor),
//               borderRadius: BorderRadius.circular(5)),
//           filled: true,
//           fillColor: widget.fillColor,
//           hintText: "Find your university",
//           hintStyle: TextStyle(
//             fontSize: 15.0,
//             color: Colors.grey.shade400,
//           ),
//           border: InputBorder.none,
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: widget.focusedBorderColor)),
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
//   }
// }

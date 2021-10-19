import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Registration2.dart';
import 'package:faker/faker.dart';

class CityData2 {


  static List getSuggestions(String query) =>
      List.of(globals.degrees).where((city){

        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.contains(queryLower);


      }).toList();

}
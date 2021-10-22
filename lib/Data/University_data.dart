import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Registration2.dart';

class CityData {


  static List getSuggestions(String query) =>
      List.of(globals.univercitiesName).where((city){

        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.contains(queryLower);


      }).toList();

}
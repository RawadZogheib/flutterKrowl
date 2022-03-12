import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Signup/Registration2.dart';

class CityData2 {


  static List getSuggestions(String query) =>
      List.of(globals.degrees).where((city){

        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.contains(queryLower);


      }).toList();

}
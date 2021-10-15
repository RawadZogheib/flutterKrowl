import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/page/Registration2.dart';
import 'package:faker/faker.dart';

class CityData {

  static final faker = Faker();

  static final List<String> cities =
      List.generate(40, (index) => faker.address.city());

  static List getSuggestions(String query) =>
      List.of(cities).where((city){

        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.contains(queryLower);


      }).toList();

}
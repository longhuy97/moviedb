import 'dart:convert';
import 'package:moviedb/detail_person/model/person_model.dart';
import 'package:http/http.dart' as http;

final url1 = 'https://api.themoviedb.org/3/person/';
final url2 = '?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';

Future<PersonModel> fetchPerson(int idd) async {
  final response = await http.get(Uri.parse('$url1$idd$url2'));
  if (response.statusCode == 200) {
    return PersonModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faile to load poster');
  }
}

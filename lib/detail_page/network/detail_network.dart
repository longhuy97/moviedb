import 'dart:convert';

import 'package:moviedb/detail_page/model/detail_model.dart';
import 'package:http/http.dart' as http;

final url1 = 'https://api.themoviedb.org/3/movie/';
final url2 = '?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
final url3 =
    '?api_key=d79d9f8467a0e6d7b24624c522cb2ab3&append_to_response=credits';

Future<DetailModel> fetchPoster(int idd) async {
  final response = await http.get(Uri.parse('$url1$idd$url3'));
  if (response.statusCode == 200) {
    return DetailModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faile to load poster');
  }
}

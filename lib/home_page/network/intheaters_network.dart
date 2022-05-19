import 'dart:convert';
import 'package:moviedb/home_page/model/intheaters_model.dart';
import 'package:http/http.dart' as http;

final url =
    'https://api.themoviedb.org/3/movie/now_playing?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';

Future<InTheaters> fetchMovie() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return InTheaters.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load album");
  }
}

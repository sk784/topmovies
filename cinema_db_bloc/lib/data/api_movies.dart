import 'dart:convert';
import 'dart:io';
import 'package:cinema_db_bloc/model/movie.dart';


class ApiMovies {

  static final String API_KEY = "6fb63ff27d0f4a731233efff79588b20";

  ApiMovies._privateConstructor();
  static final ApiMovies instance =  ApiMovies._privateConstructor();

  final _http = HttpClient();

  final String baseUrl = 'api.themoviedb.org';

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }

  Future<List<Movie>> fetchMovies(
      {int page: 1, String category: "top_rated", String language: "ru-RU"}) async {
    var url = Uri.https(baseUrl, '3/movie/$category',
        {'api_key': API_KEY, 'page': page.toString(),'language': language});

    return _getJson(url).then((json) => json['results']).then((data) =>
        data.map<Movie>((item) => Movie(item)).toList());
  }
}
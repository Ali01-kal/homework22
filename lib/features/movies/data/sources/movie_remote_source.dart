import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieRemoteSource {
  Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load movies");
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data.take(10).map<MovieModel>((e) {
      return MovieModel(
        id: e['id'] ?? 0,
        title: e['title'] ?? '',
        description: e['body'] ?? '',
        year: 2024,
      );
    }).toList();
  }
}


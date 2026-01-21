import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

abstract interface class MovieLocalSource {
  Future<List<MovieModel>> getMovies();
  Future<void> addMovie(MovieModel movie);
  Future<void> deleteMovie(int id);
   Future<void> editMovie(MovieModel movie);
}

class MovieLocalSourceImpl implements MovieLocalSource {
  static const String key = "movies";

  Future<List<MovieModel>> _read() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<void> _save(List<MovieModel> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = movies.map((e) => e.toJson()).toList();
    prefs.setString(key, jsonEncode(jsonList));
  }

    @override
  Future<void> editMovie(MovieModel movie) async {
    final list = await _read();

    final index = list.indexWhere((m) => m.id == movie.id);
    if (index != -1) {
      list[index] = movie; // жаңартамыз
      await _save(list);
    }
  }

  @override
  Future<List<MovieModel>> getMovies() async {
    return await _read();
  }

  @override
  Future<void> addMovie(MovieModel movie) async {
    final list = await _read();
    list.add(movie);
    await _save(list);
  }

  @override
  Future<void> deleteMovie(int id) async {
    final list = await _read();
    list.removeWhere((e) => e.id == id);
    await _save(list);
  }
}

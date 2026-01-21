import 'package:flutter/material.dart';
import 'package:spahomework/features/movies/domain/entity/movie_entity.dart';
import 'package:spahomework/features/movies/domain/repository/movie_repository.dart';

class MovieController extends ChangeNotifier {
  final MovieRepository _repository;
  MovieController(this._repository);

  List<MovieEntity> movies = [];

  Future<void> loadMovies() async{
    movies = await _repository.getMovies();
    notifyListeners();
  }

  Future<void> addMovie(MovieEntity movie) async{
    await _repository.addMovie(movie);
    await loadMovies();
  }

  Future<void> deleteMovie(int id) async{
    await _repository.deleteMovie(id);
    await loadMovies();
  }

  Future<void> editMovie(MovieEntity movie) async{
    await _repository.editMovie(movie);
    await loadMovies();
  }
  
}
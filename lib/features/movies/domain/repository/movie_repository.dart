import 'package:spahomework/features/movies/domain/entity/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getMovies();
  Future<void> addMovie(MovieEntity movie);
  Future<void> deleteMovie(int id);
  Future<void> editMovie(MovieEntity movie);
}
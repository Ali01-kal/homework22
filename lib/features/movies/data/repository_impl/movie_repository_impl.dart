import 'package:spahomework/features/movies/data/models/movie_model.dart';
import 'package:spahomework/features/movies/data/sources/movie_sources.dart';
import 'package:spahomework/features/movies/data/sources/movie_remote_source.dart';
import 'package:spahomework/features/movies/domain/entity/movie_entity.dart';
import 'package:spahomework/features/movies/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieLocalSource local;
  final MovieRemoteSource remote;

  MovieRepositoryImpl(this.local, this.remote);

  @override
  Future<List<MovieEntity>> getMovies() async {
    // 1. Алдымен API-дан аламыз
    final remoteModels = await remote.fetchMovies();

    // 2. Оларды local storage-қа сақтаймыз
    for (final movie in remoteModels) {
      await local.addMovie(movie);
    }

    // 3. Соңында local-дан оқып, Entity-ге айналдырып қайтарамыз
    final models = await local.getMovies();

    return models
        .map((e) => MovieEntity(
              id: e.id,
              title: e.title,
              year: e.year,
              description: e.description,
            ))
        .toList();
  }

  @override
  Future<void> addMovie(MovieEntity movie) async {
    await local.addMovie(
      MovieModel(
        id: movie.id,
        title: movie.title,
        year: movie.year,
        description: movie.description,
      ),
    );
  }

  @override
  Future<void> deleteMovie(int id) async {
    await local.deleteMovie(id);
  }

  @override
  Future<void> editMovie(MovieEntity movie) async {
    await local.editMovie(
      MovieModel(
        id: movie.id,
        title: movie.title,
        year: movie.year,
        description: movie.description,
      ),
    );
  }
}

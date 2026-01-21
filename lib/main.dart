import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/movies/data/sources/movie_sources.dart';
import 'features/movies/data/sources/movie_remote_source.dart';
import 'features/movies/data/repository_impl/movie_repository_impl.dart';
import 'features/movies/presentation/controller/movie_controller.dart';
import 'features/movies/presentation/screen/movie_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        // 👇 local + remote беріліп тұр
        MovieRepositoryImpl(
          MovieLocalSourceImpl(),
          MovieRemoteSource(),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Catalog',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MovieListScreen(),
      ),
    );
  }
}

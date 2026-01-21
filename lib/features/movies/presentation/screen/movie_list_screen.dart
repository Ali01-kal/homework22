import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/movie_controller.dart';
import 'movie_detail_screen.dart';
import 'movie_add_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MovieController>(context, listen: false);
    controller.loadMovies(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Catalog"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => const MovieAddScreen()
              ));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieAddScreen()),
    );
  },
),

      body: Consumer<MovieController>(
        builder: (context, controller, child) {
          return ListView.builder(
  itemCount: controller.movies.length,
  itemBuilder: (context, index) {
    final movie = controller.movies[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.movie),
        title: Text(movie.title),
        subtitle: Text("Year: ${movie.year}"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movie: movie),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            controller.deleteMovie(movie.id);
          },
        ),
      ),
    );
  },
);
        },
      ),
    );
  }
}

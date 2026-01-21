import 'package:flutter/material.dart';
import '../../domain/entity/movie_entity.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${movie.title}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Year: ${movie.year}"),
            SizedBox(height: 10),
            Text("Description:"),
            Text(movie.description),
          ],
        ),
      ),
    );
  }
}

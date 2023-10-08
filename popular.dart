import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movie.dart';
import 'movie_detail.dart';
import 'text.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => PopularMoviesState();
}

class PopularMoviesState extends State<PopularMovies> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = fetchPopularMovies();
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final apiKey =
        '7d9d211a409a411f66ca8ab92b898ad0'; // Replace with your TMDb API key
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Movie> movies = results.map((json) => Movie.fromJson(json)).toList();

      return movies;
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Modified_Text(
            text: 'Popular Movies',
            size: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 400,
              child: FutureBuilder<List<Movie>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No movies found.');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data![index];
                        final posterPath = movie.posterPath;

                        // Check if posterPath is null or empty
                        if (posterPath != null && posterPath.isNotEmpty) {
                          final posterUrl =
                              'https://image.tmdb.org/t/p/w500$posterPath';

                          return GestureDetector(
                            onTap: () {
                              // Navigate to MovieDetailsPage when a movie is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailsPage(movie: movie),
                                ),
                              );
                            },
                            child: Container(
                              width: 140,
                              child: Column(children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(posterUrl)),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: Modified_Text(
                                    text: movie.title,
                                    color: Colors.white,
                                    size: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]),
                            ),
                          );
                        } else {
                          Container();
                          // Handle cases where the posterPath is null or empty
                        }
                      },
                    );
                  }
                },
              ))
        ]));
  }
}

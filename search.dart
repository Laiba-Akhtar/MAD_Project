import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'movie_detail.dart';
import 'text.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => SearchMoviesState();
}

class SearchMoviesState extends State<SearchMovies> {
  late Future<List<Movie>> search = Future<List<Movie>>.value([]);
  Future<List<Movie>> searchMovies(String query) async {
    final apiKey = '7d9d211a409a411f66ca8ab92b898ad0';
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
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

  void onSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        search = searchMovies(query);
      } else {
        // If the search query is empty, revert to displaying popular movies
        Text('No Movies Found!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFF292B37),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26,
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(left: 5),
                  child: TextField(
                    onChanged: onSearch,
                    // controller: search,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search movie here',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Modified_Text(
              text: 'Searched Results!!',
              size: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 400,
              child: FutureBuilder<List<Movie>>(
                future: search,
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

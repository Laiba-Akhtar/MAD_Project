import 'package:flutter/material.dart';

import 'favourites.dart';
import 'login.dart';
import 'popular.dart';
import 'search.dart';
import 'text2.dart';
import 'toprated.dart';
import 'tvshows.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Modified_Text2(
              text: 'Movie App',
              color: Colors.red,
              size: 30.0,
              fontWeight: FontWeight.bold),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyFvouritePage(),
                    ),
                  );
                },
                child: const Modified_Text2(
                    text: 'Favourite',
                    color: Colors.red,
                    size: 30.0,
                    fontWeight: FontWeight.bold))
          ],
        ),
        body: ListView(
          children: [
            SearchMovies(),
            TopRatedMovies(),
            TV(),
            PopularMovies(),
          ],
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'movie.dart';
import 'text.dart';
import 'text2.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => MyMoviePageState();
}

class MyMoviePageState extends State<MovieDetailsPage> {
  //bool isFavoriteScreenActive = false;
  //CollectionReference users;
  //     FirebaseFirestore.instance.collection('Favourites');

  void addUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final User? user = await firebaseAuth.currentUser;

    if (user != null) {
      String uid = user.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Favourites $uid');

      await users.add({
        'poster': widget.movie.posterPath,
        'title': widget.movie.title,
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Modified_Text2(
          text: widget.movie.title,
          color: Colors.red,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            child: Text("Favourite"),
            onPressed: () {
              setState(() {
                addUser();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to favourites")));
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${widget.movie.banner}',
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black
                                  .withOpacity(0.5), // Adjust opacity as needed
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                      bottom: 10,
                      child: Modified_Text(
                        text:
                            '⭐ Average Rating -' + widget.movie.vote.toString(),
                        color: Colors.white,
                        size: 20,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Modified_Text(
                text: 'Releasing on - ' + widget.movie.launch_on.toString(),
                color: Colors.white,
                size: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Container(
                    child: Modified_Text2(
                      text: widget.movie.title,
                      color: Colors.white,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Modified_Text2(
                  text: 'Description',
                  color: Colors.white,
                  size: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Modified_Text(
                  text: widget.movie.overview,
                  color: Colors.white,
                  size: 15,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}

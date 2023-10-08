import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_cep/mainpage.dart';
import 'package:flutter_project_cep/movie.dart';
import 'favourites.dart';
import 'login.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: const Text("hello"),
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => const Login()));
//                 },
//                 child: const Text("login"))
//           ],
//         ),
//       ),
//     );
//   }
// }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://assets.designhill.com/design-blog/wp-content/uploads/2019/04/1.jpg',
                width: 500.0),
            const SizedBox(height: 20.0),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_cep/signup.dart';
import 'authservice.dart';
import 'mainpage.dart';
import 'text.dart';
import 'text2.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginPageState();
}

class LoginPageState extends State<Login> {
  TextEditingController passcont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  final AuthService authService = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  bool _obscureText = true;

  delUser(String docid) {
    users.doc(docid).delete();
  }

  signIn() async {
    final User? user = await authService.signIn(emailcont.text, passcont.text);

    if (user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign IN")));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No such user found")));
    }
  }

  updatepass() {
    authService.resetPassword(emailcont.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check you have recieved email")));
  }

  void emptyfield() {
    emailcont.text = "";
    passcont.text = "";
  }

  @override
  Widget build(BuildContext context) {
    String un = "";
    final screenSize = MediaQuery.of(context).size;
    bool _obscureText = true;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Modified_Text2(
            text: 'Login',
            color: Colors.red,
            size: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF292B37),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: emailcont,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF292B37),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: passcont,
                    obscureText: _obscureText,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Toggle the state
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                      emptyfield();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16),
                        minimumSize: const Size(160, 50)),
                    child: const Text("Login")),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    },
                    child: const Modified_Text(
                      text: "Dont have an Account? SignUp",
                      color: Colors.red,
                      size: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
                TextButton(
                    onPressed: () {
                      if (emailcont.text.isNotEmpty) {
                        updatepass();
                      }
                    },
                    child: const Modified_Text(
                      text: "Forgotten Password?",
                      color: Colors.red,
                      size: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ));
  }
}

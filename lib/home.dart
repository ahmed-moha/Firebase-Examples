

import 'package:firebase_examples/login.dart';
import 'package:firebase_examples/register.dart';
import 'package:firebase_examples/users.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Examples"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(),));
              },
              child: const Text("Register"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
              },
              child: const Text("Login"),
            ),
          ),
           Center(
            child: ElevatedButton(
              onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const Users(),));
              },
              child: const Text("Users"),
            ),
          ),
        ],
      ),
    );
  }
}

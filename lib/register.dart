import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name = "";
  String username = "";
  String password = "";
  bool isLoading = false;
  createUser() async {
    try {
      isLoading = true;
      setState(() {});
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } catch (e) {
      print("THE ERROR: $e");
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.pink,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
            
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: TextField(
                  onChanged: (value) {
                    username = value;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      hintText: "Username", border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                    setState(() {});
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("Submit"),
                  onPressed: () {
                    createUser();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

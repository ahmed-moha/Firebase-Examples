import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  bool isLoading = false;
  UserCredential? user;
  showMessage(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message ?? "",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final auth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken);
      return FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      print("OOPS $e");
    }
  }

  login() async {
    try {
      isLoading = true;
      setState(() {});
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      showMessage(user?.user?.email);
    } catch (e) {
      print(e);
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
          title: const Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.pink,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("Sign In"),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("Sign In With Google"),
                  onPressed: () {
                    loginWithGoogle();
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

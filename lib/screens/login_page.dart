import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../commons/alert_helper.dart';
import '../commons/firebase_collections.dart';
import 'home_screen.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _validateLoginValues() {
    if(emailController.text.length < 5) {
      MenssageHelper.errorMenssage("o email deve possuir pelo menos 5 caracteres", context);
      return true;
    }
    if(passwordController.text.length < 5) {
      MenssageHelper.errorMenssage("a senha deve possuir pelo menos 5 caracteres", context);
      return true;
    }
    return false;
  }

  makeLogin() async {
    bool isInvalid = _validateLoginValues();
    if(!isInvalid) {
      var user;
      QuerySnapshot query = await db.collection(FirebaseCollections.user).where("email", isEqualTo: emailController.text).where("password", isEqualTo: passwordController.text).limit(1).get();
      if(query.docs.isEmpty) {
        MenssageHelper.errorMenssage("Usuário não encontrado! Tente outra combinação de email e senha", context);
        return;
      }
      for (var value in query.docs ) {
        MenssageHelper.successMenssage("Olá ${value.get("name")} seja bem vindo(a)!", context, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
              controller: emailController
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
              controller: passwordController,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 47, 47, 47),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    makeLogin();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
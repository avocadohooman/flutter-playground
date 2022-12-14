import 'package:flutter/material.dart';
import 'package:quiz_app/login/login.dart';
import 'package:quiz_app/topics/topics.dart';
import 'package:quiz_app/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Center(child: Text('error'));
        } else if (snapshot.hasData) {
          return const Topics();
        } else {
          return const Login();
        }
      },
    );
  }
}

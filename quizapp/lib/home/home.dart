import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text(
              'topics',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () => Navigator.pushNamed(context, '/topics')),
      ),
    );
  }
}

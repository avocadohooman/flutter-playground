import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/auth.dart';

import '../services/models.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? "Guest"),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoURL ?? '/assets/user.png'),
                      fit: const FittedBox().fit,
                    )),
              ),
              Text(
                user.email ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              Text(
                report.total.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Quizzes Completted',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('sign out'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
    );
  }
}

import 'package:quiz_app/about/about.dart';
import 'package:quiz_app/home/home.dart';
import 'package:quiz_app/login/login.dart';
import 'package:quiz_app/profile/profile.dart';
import 'package:quiz_app/topics/topics.dart';

var appRoutes = {
  '/': (context) => Home(),
  '/about': (context) => About(),
  '/login': (context) => Login(),
  '/profile': (context) => Profile(),
  '/topics': (context) => Topics(),
};

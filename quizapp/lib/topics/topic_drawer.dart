import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../services/models.dart';

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;

  const TopicDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          Topic topic = topics[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              QuizList(topic: topic),
            ],
          );
        },
        separatorBuilder: (BuildContext context, index) {
          return const Divider();
        },
        itemCount: topics.length,
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map((quiz) {
        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 4,
          margin: const EdgeInsets.all(4),
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(4),
              child: ListTile(
                title: Text(
                  topic.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  quiz.description,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                leading: QuizBadge(topic: topic, quizId: quiz.id),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class QuizBadge extends StatelessWidget {
  final Topic topic;
  final String quizId;
  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(
        FontAwesomeIcons.checkDouble,
        color: Colors.green,
      );
    }
    return const Icon(
      FontAwesomeIcons.solidCircle,
      color: Colors.grey,
    );
  }
}

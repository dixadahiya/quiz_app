import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    int totalQuestions = quizQuestions.length;
    int wrongAnswers = totalQuestions - score;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Result"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),

              const Text(
                "Quiz Completed!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Your Score: $score / $totalQuestions",
                style: const TextStyle(fontSize: 22),
              ),
 const SizedBox(height: 10),

              Text(
                "Correct Answers: $score",
                style: const TextStyle(fontSize: 18),
              ),

              Text(
                "Incorrect Answers: $wrongAnswers",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Restart Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
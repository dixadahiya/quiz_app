import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  void _handleNextQuestion() {
    // 1. Alert user if no option is chosen
    if (_selectedAnswerIndex == null) {
      ScaffoldMessenger.of(context).clearSnackBars(); // Prevents snackbar stacking
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an answer"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // 2. Increment score if answer matches data model
    if (_selectedAnswerIndex == quizQuestions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    // 3. Navigate or advance quiz index safely
    if (_currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null; // Clear radio choice for next screen
      });
    } else {
      if (!mounted) return; // Guard clause against context unmounting crashes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: _score),
        ),
      );
    }
  }

  @override 
  Widget build(BuildContext context) {
    final currentQuestion = quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
      ),
      body: SafeArea( // Ensures UI does not clip beneath phone camera notches
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Tracker Header
              Text(
                "Question ${_currentQuestionIndex + 1}/${quizQuestions.length}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Main Question Text
              Text(
                currentQuestion.question,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),

              // Modernized Radio Choice Section using RadioGroup
              RadioGroup<int>(
                groupValue: _selectedAnswerIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedAnswerIndex = value;
                  });
                },
                child: Column(
                  children: [
                    for (int i = 0; i < currentQuestion.options.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: RadioListTile<int>(
                          value: i,
                          title: Text(currentQuestion.options[i]),
                        ),
                      ),
                  ],
                ),
              ),

              const Spacer(),

              // Action Button Workspace
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleNextQuestion,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentQuestionIndex == quizQuestions.length - 1
                        ? "Finish Quiz"
                        : "Next Question",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

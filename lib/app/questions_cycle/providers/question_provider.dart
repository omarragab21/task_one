import 'package:flutter/material.dart';
import 'package:task_one/app/questions_cycle/models/questions%20_model.dart';
import 'package:task_one/app/questions_cycle/services/questions_api.dart';
import 'package:task_one/services/local_services/sqlite_db.dart';

class QuestionProvider extends ChangeNotifier {
  //*Varibales
  Questions _questions = Questions();
  bool _questionIsLoaded = false;
  int _count = 0;

  //*Getters
  Questions get questions => _questions;
  bool get questionIsLoaded => _questionIsLoaded;
  int get count => _count;
  //*Functions
  Future<void> getAllQuestions() async {
    _count += 1;
    _questions = (await QuestionApi().getAllQuestion(_count))!;
    // ignore: avoid_function_literals_in_foreach_calls
    _questions.items!.forEach((question) async {
      await LocalDataBase().insertDb(
          question.owner!.displayName!,
          question.owner!.profileImage!,
          question.isAnswered!,
          question.answerCount!,
          question.creationDate!,
          question.link!,
          question.title!,
          question.questionId!.toString(),
          question.tags!);
    });
    _questionIsLoaded = true;
    notifyListeners();
  }
}

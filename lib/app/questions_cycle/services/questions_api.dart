// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'package:task_one/services/remote_services/client.dart';

import '../models/questions _model.dart';

class QuestionApi {
  Future<Questions?> getAllQuestion(int countQuestion) async {
    Questions questions = Questions();
    String url =
        'https://api.stackexchange.com/2.3/questions?pagesize=$countQuestion&order=desc&sort=activity&site=stackoverflow';

    try {
      var response = await Client().dio.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        questions = Questions.fromJson(response.data);
        print(questions);
        return questions;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}

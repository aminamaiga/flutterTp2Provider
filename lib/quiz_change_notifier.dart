import 'package:flutter/cupertino.dart';
import 'package:fluttertp2/question_model.dart';

class QuizChangeNotifier extends ChangeNotifier{
  int questionIndex = 0;
  bool? responseStatus;

  nextQuestion() {
      if (questionIndex < 3) {
        ++questionIndex;
      } else {
        questionIndex = 0;
      }
      notifyListeners();
  }

  checkResponse(bool response) {
      if (response == Question.getQuestions().elementAt(questionIndex).response) {
        responseStatus = true;
        nextQuestion();
      } else {
        responseStatus = false;
        notifyListeners();
      }
  }
}
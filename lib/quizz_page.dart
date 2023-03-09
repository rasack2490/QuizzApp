import 'package:flutter/material.dart';
import 'package:quizz_app/datas.dart';
import 'package:quizz_app/question.dart';
import 'package:quizz_app/text_with_style.dart';

class QuizzPage extends StatefulWidget {
  @override
  QuizzPageState createState() => QuizzPageState();
}

class QuizzPageState extends State<QuizzPage> {
  List<Question> questions = Datas().listeQuestions;
  int index = 0;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    final Question question = questions[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Score : $score / ${questions.length}'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithStyle(
                  data: "Question numero: ${index + 1} / ${questions.length}",
                  color: Colors.deepPurpleAccent,
                  style: FontStyle.italic,
                ),
                TextWithStyle(
                    data: question.question, size: 20, weight: FontWeight.bold),
                Image.asset(question.getImage()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    answerBtn(false),
                    answerBtn(true),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton answerBtn(bool b) {
    return ElevatedButton(
      onPressed: () {
        checkAnswer(b);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: b ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Text(b ? "Vrai" : "Faux"),
    );
  }

  checkAnswer(bool answer) {
    final question = questions[index];
    bool bonneReponse = (question.reponse == answer);
    if (bonneReponse) {
      setState(() {
        score++;
      });
    }
    showAnswer(bonneReponse);
  }

  Future<void> showAnswer(bool bonneReponse) async {
    Question question = questions[index];
    String title = (bonneReponse) ? "Bravo !" : "Perdu !";
    String imageToShow =
        (bonneReponse) ? "assets/images/vrai.jpg" : "assets/images/faux.jpg";
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: TextWithStyle(data: title), children: [
            Image.asset(imageToShow),
            TextWithStyle(data: question.explication),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  toNextQuestion();
                },
                child: TextWithStyle(
                    data: "Passer a la question suivante",
                    color: Colors.deepPurpleAccent)),
          ]);
        });
  }

  Future<void> showResult() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
            title: TextWithStyle(data: "C'est fini !"),
            content: TextWithStyle(data: "Votre Score : $score points"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child:
                    TextWithStyle(data: "OK", color: Colors.deepPurpleAccent),
              )
            ]);
      },
    );
  }

  void toNextQuestion() {
    if (index < questions.length - 1) {
      index++;
      setState(() {});
    } else {
      showResult();
    }
  }
}

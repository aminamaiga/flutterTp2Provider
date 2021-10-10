import 'package:flutter/material.dart';
import 'package:fluttertp2/question_model.dart';
import 'package:fluttertp2/quiz_change_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Questions/Reponses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Question> questions = [];

  @override
  Widget build(BuildContext context) {
    questions = Question.getQuestions();

    return ChangeNotifierProvider(
      create: (context) => QuizChangeNotifier(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<QuizChangeNotifier>(
            builder: (context, viewModel, child) {
              return Container(
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 4,
                          width: 300,
                          child: Image.asset('assets/france.PNG')),
                      viewModel.responseStatus == true
                          ? Text('Correcte')
                          : Text('Incorrecte'),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(12),
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                        child: Text(
                          questions
                              .elementAt(viewModel.questionIndex)
                              .question,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                  Provider.of<QuizChangeNotifier>(
                                      context, listen: false).checkResponse(true);
                              },
                              child: Text("Vrai"),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey)),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                    Provider.of<QuizChangeNotifier>(
                                        context, listen: false).checkResponse(false);
                                },
                                child: Text("Faux"),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.blueGrey))),
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<QuizChangeNotifier>(
                                      context, listen: false).nextQuestion();
                                },
                                child: Icon(Icons.arrow_forward),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey)))
                          ],
                        ),
                      )
                    ],
                  )
              );
            }
        ), //This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}



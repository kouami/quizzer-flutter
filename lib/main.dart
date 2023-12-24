import 'package:flutter/material.dart';
import 'package:quizzer/Question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const Quizzer());
}

class Quizzer extends StatelessWidget {
  const Quizzer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Quizzer",
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico'),
          ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizBoard(),
          ),
        ),
      ),
    );
  }
}

class QuizBoard extends StatefulWidget {
  const QuizBoard({super.key});

  @override
  State<QuizBoard> createState() => _MyAppState();
}

class _MyAppState extends State<QuizBoard> {
  List<Icon> scoreKeeper = [];

  List<Question> questions = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    questions[displayText(questionNumber, questions.length)]
                        .question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSans3',
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    textStyle: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    processInput(true);
                  },
                  child: const Text("True"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    processInput(false);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),
                  child: const Text("False"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: scoreKeeper,
                //CircleAvatar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processInput(bool value) {
    if (questionNumber > questions.length - 1) {
      setState(() {
        questionNumber = 0;
        scoreKeeper.clear();
      });
    }

    if (questions[questionNumber].answer == value) {
      scoreKeeper.add(
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scoreKeeper.add(
        const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }

    setState(() {
      questionNumber++;
    });

    if (questionNumber == questions.length) {
      // We have reached the end of the quiz
      Alert(
        type: AlertType.info,
        context: context,
        title: "Finished",
        desc: "You have reached the end of the quiz",
      ).show();

      setState(() {
        questionNumber = 0;
        scoreKeeper.clear();
      });
    }
  }

  int displayText(int number, int questions) {
    if (number > questions - 1) {
      number = 0;
    }
    return number;
  }
}

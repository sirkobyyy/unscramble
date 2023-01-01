import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_game/utilities/constants.dart';
import 'package:dictionary_game/screens/results_page.dart';
import '../components/word.dart';

class Quiz extends StatefulWidget {
  Quiz({required this.rounds, required this.wordList});

  final int rounds;
  final List<Word> wordList;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wordList = widget.wordList;
    totalRounds = widget.rounds;
    currentWord = wordList[0];
  }

  final myController = TextEditingController();
  List<Word> wordList = [];
  int round = 1;
  int totalRounds = 0;
  late Word currentWord;
  int score = 0;

  void checkAnswer(String answer) {
    if (round >= totalRounds) {
      if (currentWord.getCorrectWord().toLowerCase() == answer.toLowerCase()) {
        score++;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompletePage(
            score: score,
            rounds: totalRounds,
          ),
        ),
      );
    } else {
      setState(() {
        if (currentWord.getCorrectWord().toLowerCase() ==
            answer.toLowerCase()) {
          score++;
        }
        currentWord = wordList[round];
        round++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('UNSCRAMBLE',
                    style: TextStyle(
                      fontFamily: 'Bloxat',
                    )),
              ),
              backgroundColor: Colors.black,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Score: $score/$totalRounds",
                            style: kSmallerText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Round: $round/$totalRounds",
                            style: kSmallerText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Text(
                        currentWord.getjumbledWord(),
                        style: kHeadingOneText,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 300,
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Input Answer",
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            round = 1;
                            score = 0;
                          },
                          child: Text(
                            "RESET",
                            style: kSmallerText,
                          ),
                          style: kButtonStyle,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final player = AudioCache();
                            player.play('gameover.wav');
                            checkAnswer(myController.text.trim());
                            myController.clear();
                          },
                          child: Text(
                            "SUBMIT",
                            style: kSmallerText,
                          ),
                          style: kButtonStyle,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => HintDialog(currentWord: currentWord),
                      ),
                      child: Text(
                        "HINT",
                        style: kSmallerText,
                      ),
                      style: kButtonStyle,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class HintDialog extends StatelessWidget {
  const HintDialog({
    Key? key,
    required this.currentWord,
  }) : super(key: key);

  final Word currentWord;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'HINTS',
        style: kMedText,
      ),
      content: SingleChildScrollView(
        child: Text(
          "DEFINITION/S: \n " +
              currentWord.generateAllDefintionsAsText() +
              "\n" +
              "SYNONYM/S: \n" +
              currentWord.generateAllSynonymsAsText() +
              "\n" +
              "PART OF SPEECH: " +
              currentWord.getPartOfSpeech(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'AIGHT!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Bloxat',
                color: Colors.black,
              ),
            ),
        )
      ],
    );
  }
}
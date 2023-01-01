import 'package:dictionary_game/screens/quiz_page.dart';
import 'package:dictionary_game/components/word.dart';
import 'package:dictionary_game/services/word_brain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({required this.numberOfWords, required this.difficulty});

  final int numberOfWords;
  final Difficulty difficulty;

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    numberOfWords = widget.numberOfWords;
    difficulty = widget.difficulty;
    getData();
  }

  int numberOfWords = 0;
  Difficulty difficulty = Difficulty.easy;

  void getData() async {
    WordBrain wordBrain = WordBrain(numberOfWords, difficulty);

    List<Word> wordList = await wordBrain.getWordList();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Quiz(
          rounds: numberOfWords,
          wordList: wordList,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
            color: Colors.grey,
            size: 100.0,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Generating Words for You to Guess!",
              style: kHeadingOneText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

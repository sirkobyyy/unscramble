import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_game/utilities/constants.dart';

class CompletePage extends StatelessWidget {
  CompletePage({required this.score, required this.rounds});
  final int score;
  final int rounds;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CONGRATULATIONS!",
                  style: kMedText,
                ),
                Text(
                  "Your score is: $score/$rounds",
                  style: kMedText,
                ),
                ElevatedButton(
                  onPressed: () {
                    final player = AudioCache();
                    player.play('end.wav');
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "RESET",
                    style: kSmallerText,
                  ),
                  style: kButtonStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

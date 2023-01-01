import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_game/screens/quiz_page.dart';
import 'package:dictionary_game/components/round_icon_card.dart';
import 'package:dictionary_game/services/word_brain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';
import 'loading_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int numberOfWords = 5;
  List<String> difficulty = ['Easy', 'Medium', 'Hard'];
  int countDifficulty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'UNSCRAMBLE',
            style: TextStyle(
              fontFamily: 'Bloxat',
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'SELECT DIFFICULTY',
              style: kHeadingOneText,
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                Text(
                  'Number of Words to Guess',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bloxat',
                  ),
                ),
                Text(
                  numberOfWords.toString() + ' words',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bloxat',
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbColor: Colors.black,
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: numberOfWords.toDouble(),
                    min: 1,
                    max: 10,
                    onChanged: (double newValue) {
                      setState(() {
                        numberOfWords = newValue.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Difficulty',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bloxat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundIconCard(
                      icon: FontAwesomeIcons.lessThan,
                      onPressed: () {
                        setState(
                              () {
                            if (countDifficulty != 0) {
                              countDifficulty--;
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      difficulty[countDifficulty],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bloxat',
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    RoundIconCard(
                      icon: FontAwesomeIcons.greaterThan,
                      onPressed: () {
                        setState(
                              () {
                            if (countDifficulty != 2) {
                              countDifficulty++;
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final player = AudioCache();
                player.play('start.wav');

                Difficulty diff;
                if (countDifficulty == 0) {
                  diff = Difficulty.easy;
                } else if (countDifficulty == 1) {
                  diff = Difficulty.medium;
                } else {
                  diff = Difficulty.hard;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                      numberOfWords: numberOfWords,
                      difficulty: diff,
                    ),
                  ),
                );
              },
              child: Text(
                "PROCEED",
                style: kSmallerText,
              ),
              style: kButtonStyle,
            )
          ],
        ),
      ),

    );
  }
}

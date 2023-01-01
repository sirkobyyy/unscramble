import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_game/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnscrambleApp extends StatefulWidget {
  const UnscrambleApp({Key? key}) : super(key: key);

  @override
  _UnscrambleAppState createState() => _UnscrambleAppState();
}

class _UnscrambleAppState extends State<UnscrambleApp> {

  String? displayName = "";
  final myController = TextEditingController();

  @override
  void initState() {
    getUserData();
  }

  getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString("displayName");
    });
  }

  display(){
    if(displayName != null){
      return Text(
        "HI, " + displayName.toString() + "!",
        style: kHeadingOneText,
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        children: [
          Column(
            children: [
              Text(
                "Please Input Your Name: ",
                style: kHeadingOneText,
                textAlign: TextAlign.center,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Input Name",
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }



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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              display(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "WELCOME TO UNSCRAMBLE!",
                  style: kHeadingOneText,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(displayName == null){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("displayName", myController.text.trim());
                  }
                  final player = AudioCache();
                  player.play('start.wav');
                  Navigator.pushNamed(context, '/settings');
                },
                child: Text(
                  "PROCEED",
                  style: kSmallerText,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

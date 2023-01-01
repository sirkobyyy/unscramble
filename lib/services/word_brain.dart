import 'dart:math';
import 'package:dictionary_game/services/dictionary.dart';
import 'package:dictionary_game/components/word.dart';
import 'package:english_words/english_words.dart' as randomWord;

enum Difficulty{
  easy, medium, hard
}

class WordBrain{

  WordBrain(int numOfWords, Difficulty difficulty){
    this.numOfWords = numOfWords;
    this.difficulty = difficulty;

    if(difficulty == Difficulty.easy)
      this.maximumSyllables = 2;
    else if(difficulty == Difficulty.medium)
      this.maximumSyllables = 3;
    else
      this.maximumSyllables = 4;
  }

  int numOfWords = 0;
  int maximumSyllables = 0;
  Difficulty difficulty = Difficulty.easy;
  List<Word> wordList =[];

  Future<List<Word>> getWordList() async{
    List<String> stringList = _generateWords();
    Dictionary dictionary = Dictionary(wordList: stringList);
    List<dynamic> dictionaryDataList = await dictionary.getDictionaryData();
    List<dynamic> thesaurusDataList = await dictionary.getThesaurusData();

    for(int i = 0; i<dictionaryDataList.length; i++){
      var dictionaryData = dictionaryDataList[i];
      var thesaurusData = thesaurusDataList[i];

      String partOfSpeech = dictionaryData[0]['fl'];
      var definitionData = dictionaryData[0]['shortdef'];

      List<String> definition = [];
      for(String def in definitionData){
        definition.add(def);
      }

      var synonymsData = [];
      try {
        synonymsData = thesaurusData[0]['meta']['syns'][0];
      } catch (e){
        synonymsData = thesaurusData;
      }

      List<String> synonyms = [];
      for(String syn in synonymsData){
        synonyms.add(syn);
      }

      wordList.add(Word(stringList[i].toLowerCase(), partOfSpeech, definition, synonyms));
    }
    return wordList;
  }

  List<String> _generateWords() {
    List<String> stringList = [];

    for(int i = 0; i<numOfWords; i++){
      int syllable = 0;
      String word = "";

      while(true){
        word = randomWord.all[Random().nextInt(4332)];
        syllable = randomWord.syllables(word);
        if(syllable > 1 && syllable <= maximumSyllables) {
          stringList.add(word);
          syllable = 0;
          break;
        }
      }
    }

    stringList.shuffle();
    return stringList;
  }
}
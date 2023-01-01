import 'package:dictionary_game/services/networking.dart';


const dictionaryKey = '9b2fd125-08e6-4a31-a53b-f9ae256971db';
const thesaurusKey = '60ef142a-226e-43ac-84b2-8e8fd1795856';
const merriamURL = 'https://www.dictionaryapi.com/api/v3/references/';

class Dictionary{
  Dictionary({required this.wordList});
  final List wordList;

    Future<List<dynamic>> getDictionaryData() async{
      NetworkHelper networkHelper = NetworkHelper();
      List<dynamic> dictionaryDataList = [];
      for(String s in wordList){
        var dictionaryData = await networkHelper.getData(merriamURL + 'collegiate/json/' + s + '?key=' + dictionaryKey);
        dictionaryDataList.add(dictionaryData);
      }
      return dictionaryDataList;
    }

    Future<List<dynamic>> getThesaurusData() async{
      NetworkHelper networkHelper = NetworkHelper();
      List<dynamic> thesaurusDataList = [];
      for(String s in wordList){
        var thesaurusData = await networkHelper.getData(merriamURL + 'thesaurus/json/' + s + '?key=' + thesaurusKey);
        thesaurusDataList.add(thesaurusData);
      }
      return thesaurusDataList;
    }
}
class Word{
  String _jumbledWord = "";
  String _correctWord = "";
  String _partOfSpeech = "";
  List<String> _definition = [];
  List<String> _synonyms = [];

  Word(String correctWord, String partOfSpeech, List<String> definition, List<String> synonyms){
    this._correctWord = correctWord;
    this._jumbledWord = _shuffleWord(this._correctWord);
    this._partOfSpeech = partOfSpeech;
    this._definition = definition;
    this._synonyms = synonyms;
  }

  String getCorrectWord(){
    return _correctWord;
  }

  String getjumbledWord(){
    return _jumbledWord;
  }
  String getPartOfSpeech(){
    return _partOfSpeech;
  }

  List<String> getDefinition(){
    return _definition;
  }

  List<String> getSynonyms(){
    return _synonyms;
  }

  String generateAllDefintionsAsText(){
    String definitions = "";
    for(int i=0; i<_definition.length; i++){
      definitions += (i+1).toString() + ". " + _definition[i] + "\n";
    }
    return definitions;
  }

  String generateAllSynonymsAsText(){
    if(_synonyms.length == 0){
      return "No available synonyms\n";
    }
    String synonyms = "";
    for(int i=0; i<_synonyms.length; i++){
      synonyms += (i+1).toString() + ". " + _synonyms[i] + "\n";
    }
    return synonyms;
  }

  String _shuffleWord(String word){
    List list = word.split('');
    list.shuffle();
    String shuffledWord = list.join();
    return shuffledWord;
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();

    return MaterialApp(
      home: RandomWord(),
    );
  }
}

class RandomWord extends StatefulWidget {
  const RandomWord({super.key});

  @override
  State<RandomWord> createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {

  final List<WordPair> suggestions = <WordPair>[];

  final TextStyle biggerFont = TextStyle(fontSize: 15);
  @override
  Widget build(BuildContext context) {
    //final WordPair wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);


    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de nombres"),
      ),
      body: buildSuggestions(),
    );
  }

  Widget buildSuggestions(){
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i){
          if(i.isOdd){
            return Divider(
              thickness: 2,
              color: Colors.cyanAccent,
            );
          }

          //Ahora crea una variable indel
          final int index = i ~/ 2;

          if(index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        });
  }

  Widget buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
    );
  }
}





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
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
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
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle biggerFont = TextStyle(fontSize: 15);

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair){
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: biggerFont,
                    ),
                  );
                },
            );
            final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text("Saved Suggestions"),
              ),
              body: ListView(children: divided,),
            );
          },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final WordPair wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de nombres"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
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
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
       setState(() {
         if(alreadySaved){
           _saved.remove(pair);
         }else {
           _saved.add(pair);
         }
       });
      },
    );
  }
}





import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Brain Boxes',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List> oppositeList = [
    ['asleep', 1, true],
    ['awake', 1, true],
    ['day', 2, true],
    ['night', 2, true],
    ['fast', 3, true],
    ['slow', 3, true],
    ['full', 4, true],
    ['hungry', 4, true],
    ['soft', 5, true],
    ['hard', 5, true],
    ['in', 6, true],
    ['out', 6, true],
  ];

  List? firstGuess;
  List? secondGuess;

  checkIfDone() {
    bool condition = true;
    for (List item in oppositeList) {
      if (item[2]) {
        condition = false;
      }
    }
    if (condition) {
      setState(() {
        oppositeList = [
          ['asleep', 1, true],
          ['awake', 1, true],
          ['day', 2, true],
          ['night', 2, true],
          ['fast', 3, true],
          ['slow', 3, true],
          ['full', 4, true],
          ['hungry', 4, true],
          ['soft', 5, true],
          ['hard', 5, true],
          ['in', 6, true],
          ['out', 6, true],
        ];
        oppositeList.shuffle();
      });
    }
  }

  List<Widget> getCards() {
    List<Widget> cards = [];
    int i = 0;
    for (List element in oppositeList) {
      if (element[2]) {
        cards.add(
          FlipCard(
            back: Image(
              image: AssetImage('assets/${element[0]}.jpeg'),
              fit: BoxFit.fill,
            ),
            front: Text('Working'),
            onFlipDone: (bool status) {
              print(firstGuess);
              print(secondGuess);
              setState(() {
                if (firstGuess == null) {
                  firstGuess = element;
                  oppositeList[i][2] = false;
                } else {
                  secondGuess = element;
                  List temp = oppositeList
                      .where((item) => item[1] == element[1])
                      .toList();
                  temp.remove(element);
                  temp = temp.first;
                  if (firstGuess == temp) {
                    oppositeList[oppositeList
                        .indexWhere((item) => item == firstGuess)][2] = false;
                    oppositeList[oppositeList
                        .indexWhere((item) => item == secondGuess)][2] = false;
                    firstGuess = null;
                    secondGuess = null;
                    checkIfDone();
                  } else {
                    print(oppositeList[
                        oppositeList.indexWhere((item) => item == firstGuess)]);
                    oppositeList[oppositeList
                        .indexWhere((item) => item == firstGuess)][2] = true;
                  }
                }
                print(firstGuess);
                print(secondGuess);
              });
            },
          ),
        );
      } else {
        cards.add(
          Image(
            image: AssetImage('assets/${element[0]}.jpeg'),
            fit: BoxFit.fill,
          ),
        );
      }
      i++;
    }
    return cards;
  }

  @override
  void initState() {
    oppositeList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.sports_esports),
        title: Text(''),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                oppositeList = [
                  ['asleep', 1, true],
                  ['awake', 1, true],
                  ['day', 2, true],
                  ['night', 2, true],
                  ['fast', 3, true],
                  ['slow', 3, true],
                  ['full', 4, true],
                  ['hungry', 4, true],
                  ['soft', 5, true],
                  ['hard', 5, true],
                  ['in', 6, true],
                  ['out', 6, true],
                ];
                print(oppositeList);
                oppositeList.shuffle();
              });
            },
            icon: Icon(Icons.replay),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: getCards(),
      ),
    );
  }
}

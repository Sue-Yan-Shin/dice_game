import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int diceNo1 = 1;
  int diceNo2 = 6;
  int player1Point = 0;
  int player2Point = 0;
  bool clicked1 = false;
  bool clicked2 = false;
  int? winner = 0;

  int decideWinner(int diceNo1, int diceNo2) {
    if (diceNo1 > diceNo2) {
      setState(() {
        player1Point++;
      });
      return 1;
    } else if (diceNo1 == diceNo2) {
      setState(() {
        clicked1 = false;
        clicked2 = false;
      });
      return 0;
    } else {
      setState(() {
        player2Point++;
      });
      return 2;
    }
  }

  void showSuccessAlert(BuildContext context) {
    winner = decideWinner(diceNo1, diceNo2);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext content) {
          return AlertDialog(
            title: (winner == 0)
                ? const Text('ဘယ်သူမှ မနိုင်ပါ')
                : Text("ကစားသမား $winner နိုင်ပါတယ်"),
            content: const Text('အရှုံးမပေးနဲ့ ကြိူးစား.. 🎤'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      player1Point = 0;
                      player2Point = 0;
                      clicked1 = false;
                      clicked2 = false;
                    });
                  },
                  child: const Text('Reset')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      clicked1 = false;
                      clicked2 = false;
                    });
                  },
                  child: const Text('Play again')),
            ],
          );
        });
  }

  _updateBtn(int i) {
    Random random = Random();
    switch (i) {
      case 1:
        setState(() {
          diceNo1 = random.nextInt(6) + 1;
          clicked1 = true;
        });
        break;
      case 2:
        setState(() {
          diceNo2 = random.nextInt(6) + 1;
          clicked2 = true;
        });
        break;
    }
    if (clicked1 == true && clicked2 == true) {
      setState(() {
        showSuccessAlert(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'အံစာတုံး ပလုံးပလုံး',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage('images/dice_$diceNo1.png'),
                width: MediaQuery.of(context).size.width / 2,
              ),
              Column(
                children: [
                  Text('အမှတ်:$player1Point'),
                  ElevatedButton(
                    onPressed: clicked1 ? null : () => _updateBtn(1),
                    child: const Text('ကစားသမား ၁'),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage('images/dice_$diceNo2.png'),
                width: MediaQuery.of(context).size.width / 2,
              ),
              Column(
                children: [
                  Text('အမှတ်:$player2Point'),
                  ElevatedButton(
                    onPressed: clicked2 ? null : () => _updateBtn(2),
                    child: const Text('ကစားသမား ၂'),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

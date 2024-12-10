import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false; // Track the theme state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheme
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.blueGrey,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 36, 36, 36),
              ),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.cyanAccent,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blueGrey,
              ),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Dice Roller",
              style: TextStyle(color: Colors.cyanAccent),
            ),
          ),
          actions: [
            // Add a switch to toggle themes
            Switch(
              value: isDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  isDarkTheme = value;
                });
              },
              activeColor: Colors.cyanAccent,
            ),
          ],
        ),
        body: const DiceRollPage(),
      ),
    );
  }
}

class DiceRollPage extends StatefulWidget {
  const DiceRollPage({super.key});

  @override
  _DiceRollPageState createState() => _DiceRollPageState();
}

class _DiceRollPageState extends State<DiceRollPage> {
  int diceNumber = 1;
  int numberOfDice = 1;
  int numberOfSides = 6;
  List<int> diceResults = [];
  Color diceColor = Colors.blueAccent;

  void rollDice() {
    setState(() {
      diceResults.clear();
      for (int i = 0; i < numberOfDice; i++) {
        diceResults.add(Random().nextInt(numberOfSides) + 1);
      }
    });
  }

  void changeDiceColor(Color color) {
    setState(() {
      diceColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Roll the Dice',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          // Displaying the dice results
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: diceResults
                .map((result) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: diceColor,
                          shape: BoxShape.rectangle, // Square dice shape
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            '$result',
                            style: const TextStyle(
                                fontSize: 50, color: Colors.white),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 30),
          // Number of dice slider with label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Number of Dice:"),
              Slider(
                min: 1,
                max: 3,
                divisions: 2,
                value: numberOfDice.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    numberOfDice = value.toInt();
                  });
                },
                label: '$numberOfDice',
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Number of sides slider with label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Sides per Die:"),
              Slider(
                min: 2,
                max: 20,
                divisions: 18,
                value: numberOfSides.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    numberOfSides = value.toInt();
                  });
                },
                label: '$numberOfSides',
              ),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: rollDice,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
            ),
            child: const Text('Roll Dice'),
          ),
          const SizedBox(height: 30),
          // Color Picker for Dice
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Pick a Dice Color:"),
              IconButton(
                icon: const Icon(Icons.color_lens, color: Colors.red),
                onPressed: () => changeDiceColor(Colors.red),
              ),
              IconButton(
                icon: const Icon(Icons.color_lens, color: Colors.green),
                onPressed: () => changeDiceColor(Colors.green),
              ),
              IconButton(
                icon: const Icon(Icons.color_lens,
                    color: Color.fromARGB(255, 0, 255, 234)),
                onPressed: () =>
                    changeDiceColor(Color.fromARGB(255, 0, 255, 234)),
              ),
              IconButton(
                icon: const Icon(Icons.color_lens,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onPressed: () =>
                    changeDiceColor(const Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

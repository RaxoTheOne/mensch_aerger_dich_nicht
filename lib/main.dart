import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mensch ärgere dich nicht',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mensch ärgere dich nicht'),
        ),
        body: const Center(
          child: Board(),
        ),
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<int> positions = List.generate(4, (_) => 0); // Player positions
  List<Color> colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue]; // Player colors
  int currentPlayer = 0; // Current player index

  void rollDice() {
    setState(() {
      final diceValue = Random().nextInt(6) + 1; // Roll dice (1-6)
      if (positions[currentPlayer] + diceValue <= 40) {
        positions[currentPlayer] += diceValue; // Update player position
      }
      // Switch to the next player
      currentPlayer = (currentPlayer + 1) % 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Spieler ${currentPlayer + 1} ist dran',
          style: const TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display dice
            ElevatedButton(
              onPressed: rollDice,
              child: const Text('Würfeln'),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        // Display player pieces
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => Container(
              width: 50.0,
              height: 50.0,
              color: colors[index],
              child: Center(
                child: Text(
                  '${positions[index]}',
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

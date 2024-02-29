import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mensch ärgere dich nicht',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mensch ärgere dich nicht'),
        ),
        body: Center(
          child: Board(),
        ),
      ),
    );
  }
}

class Board extends StatefulWidget {
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
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display dice
            ElevatedButton(
              onPressed: rollDice,
              child: Text('Würfeln'),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        // Display player pieces
        Container(
          height: 300,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  '/Users/benjamingayda-knop/Coden/Projects/mensch_aerger_dich_nicht/assets/mensch-aergere-dich-nicht-farbig.png',
                  height: 300,
                ),
              ),
              for (var i = 0; i < positions.length; i++)
                Positioned(
                  bottom: (positions[i] ~/ 10) * 30.0,
                  left: ((positions[i] % 10) * 30.0) + (i % 2 == 0 ? 10.0 : 0.0),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors[i],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

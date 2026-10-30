import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int maxRange;
  const GameScreen({super.key, required this.maxRange});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int targetNumber;
  String currentInput = '';
  int score = 240;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      targetNumber = Random().nextInt(widget.maxRange) + 1;
      currentInput = '';
    });
  }

  void _onKeyPress(String value) {
    if (value == 'C') {
      setState(() {
        currentInput = '';
      });
    } else {
      setState(() {
        if (currentInput.length < 3) {
          currentInput += value;
        }
      });
    }
  }

  void _checkGuess() {
    if (currentInput.isEmpty) return;

    int guessedValue = int.parse(currentInput);

    if (guessedValue == targetNumber) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Mubarak Ho! 🎉'),
          content: Text('Aapne sahi number ($targetNumber) guess kar liya!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetGame();
              },
              child: const Text('Dobara Khelein'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        score = max(0, score - 20);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            guessedValue < targetNumber
                ? 'Chota number hai! Bada try karein.'
                : 'Bada number hai! Chota try karein.',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A34AC), Color(0xFF1E1B2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'between 1 & ${widget.maxRange}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade700,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade900.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    currentInput.isEmpty ? '?' : currentInput,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              _buildKeypad(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              _buildKeyBtn('1'),
              _buildKeyBtn('2'),
              _buildKeyBtn('3'),
              _buildKeyBtn('C', isAction: true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildKeyBtn('4'),
              _buildKeyBtn('5'),
              _buildKeyBtn('6'),
              _buildInfoTile('Score'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildKeyBtn('7'),
              _buildKeyBtn('8'),
              _buildKeyBtn('9'),
              _buildInfoTile('$score'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildKeyBtn('0'),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.green, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _checkGuess,
                    child: const Text(
                      'Check',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyBtn(String text, {bool isAction = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 55,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green, width: 2),
            backgroundColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => _onKeyPress(text),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.green.shade800.withOpacity(0.4),
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

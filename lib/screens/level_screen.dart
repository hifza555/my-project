import 'package:flutter/material.dart';

import 'game_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

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
              const SizedBox(height: 40),
              const Icon(Icons.cyclone, size: 130, color: Color(0xFFEAB308)),
              const Spacer(),
              _buildLevelButton(
                context: context,
                title: 'Level 1',
                subtitle: 'Easy',
                icon: Icons.diamond,
                color: Colors.green,
                maxRange: 9,
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context: context,
                title: 'Level 2',
                subtitle: 'Normal',
                icon: Icons.diamond_outlined,
                color: Colors.lightBlue,
                maxRange: 50,
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context: context,
                title: 'Level 3',
                subtitle: 'Hard',
                icon: Icons.diamond_rounded,
                color: Colors.redAccent,
                maxRange: 100,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int maxRange,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Material(
        color: const Color(0xFF1D61E7),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(maxRange: maxRange),
              ),
            );
          },
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 30),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quant/globals.dart';

class GameSummary extends StatefulWidget {
  final int correctAnswers;
  final int incorrectAnswers;

  const GameSummary({super.key, required this.correctAnswers, required this.incorrectAnswers});

  @override
  State<GameSummary> createState() => _GameSummaryState();
}

class _GameSummaryState extends State<GameSummary> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        playTimer.stop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: primaryBackgroundColour,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              content: SizedBox(
                width: 120,
                height: 120,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Session Overview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Correct:     ${widget.correctAnswers}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "Incorrect:   ${widget.incorrectAnswers}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Time: ${_formatDuration(playTimer.elapsed)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
            
                    String formattedTime = _formatDuration(playTimer.elapsed);
                    playTimer.reset();
            
                    setState(() {});
                  },
                  child: const Text(
                    'Return to Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  
  if (duration.inHours > 0) {
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}"; 
  } else {
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}
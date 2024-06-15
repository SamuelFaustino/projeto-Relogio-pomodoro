import 'dart:async';
import 'package:flutter/material.dart';

class SessaoScreen extends StatefulWidget {
  final String sessionName;
  final int remainingActivityTime;
  final int remainingRestTime;
  final int repetitions;

  const SessaoScreen({
    super.key,
    required this.sessionName,
    required this.remainingActivityTime,
    required this.remainingRestTime,
    required this.repetitions,
  });

  @override
  _SessaoScreenState createState() => _SessaoScreenState();
}

class _SessaoScreenState extends State<SessaoScreen> {
  late Timer? activityTimer;
  late Timer? restTimer;
  late int activityTimeLeft;
  late int restTimeLeft;
  int currentRepetition = 1;
  bool activityFinished = false;
  bool restFinished = false;

  @override
  void initState() {
    super.initState();
    activityTimeLeft = widget.remainingActivityTime * 60;
    restTimeLeft = widget.remainingRestTime * 60;
    startActivityTimer();
  }

  void startActivityTimer() {
    activityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (activityTimeLeft > 0) {
          activityTimeLeft--;
        } else {
          activityFinished = true;
          activityTimer?.cancel();
          showEndDialog('Tempo de Atividade Acabou!', startRestTimer);
        }
      });
    });
  }

  void startRestTimer() {
    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (restTimeLeft > 0) {
          restTimeLeft--;
        } else {
          restFinished = true;
          restTimer?.cancel();
          if (currentRepetition < widget.repetitions) {
            showEndDialog('Tempo de Descanso Acabou!', () {
              setState(() {
                currentRepetition++;
                activityFinished = false;
                restFinished = false;
                activityTimeLeft = widget.remainingActivityTime * 60;
                restTimeLeft = widget.remainingRestTime * 60;
              });
              startActivityTimer();
            });
          } else {
            showEndDialog('Sessão Completa!', () {
              Navigator.pop(context);
            });
          }
        }
      });
    });
  }

  void showEndDialog(String message, VoidCallback onOkPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            'Alerta',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOkPressed();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    activityTimer?.cancel();
    restTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessão'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.sessionName,
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text(
                activityFinished ? 'Tempo de Descanso' : 'Tempo de Atividade',
                style: const TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                formatTime(activityFinished ? restTimeLeft : activityTimeLeft),
                style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Repetição $currentRepetition de ${widget.repetitions}',
                style: const TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  backgroundColor: const Color.fromARGB(255, 158, 158, 158),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

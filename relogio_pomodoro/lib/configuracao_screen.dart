import 'package:flutter/material.dart';
import 'sessao_screen.dart';

class ConfiguracaoScreen extends StatefulWidget {
  const ConfiguracaoScreen({super.key});

  @override
  _ConfiguracaoScreenState createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  String sessionName = '';
  int selectedActivityTime = 10;
  int selectedRestTime = 10;
  int selectedRepetitions = 1;

  List<int> activityTimes = [
    0,
    1,
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60
  ];
  List<int> repetitions = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextField(
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                decoration: const InputDecoration(
                  labelText: 'Nome da Sessão',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Color.fromARGB(255, 50, 50, 50),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    sessionName = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  const Text(
                    'Tempo de Atividade:',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(width: 10.0),
                  DropdownButton<int>(
                    value: selectedActivityTime,
                    dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                    onChanged: (int? value) {
                      setState(() {
                        selectedActivityTime = value!;
                      });
                    },
                    items: activityTimes.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value minutos',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  const Text(
                    'Tempo de Descanso:',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(width: 10.0),
                  DropdownButton<int>(
                    value: selectedRestTime,
                    dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                    onChanged: (int? value) {
                      setState(() {
                        selectedRestTime = value!;
                      });
                    },
                    items: activityTimes.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value minutos',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  const Text(
                    'Quantidade de Repetições:',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(width: 10.0),
                  DropdownButton<int>(
                    value: selectedRepetitions,
                    dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                    onChanged: (int? value) {
                      setState(() {
                        selectedRepetitions = value!;
                      });
                    },
                    items: repetitions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessaoScreen(
                        sessionName: sessionName,
                        remainingActivityTime: selectedActivityTime,
                        remainingRestTime: selectedRestTime,
                        repetitions: selectedRepetitions,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  backgroundColor: const Color.fromARGB(255, 128, 198, 255),
                ),
                child: const Text(
                  'Iniciar',
                  style: TextStyle(fontSize: 18.0),
                ),
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

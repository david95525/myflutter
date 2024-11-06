import 'package:flutter/material.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodglucose_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodpressure_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bodytemperature_board.dart';
import 'package:flutter_example/pages/dashboard/boards/oxygen_board.dart';
import 'package:flutter_example/pages/dashboard/boards/pain_board.dart';
import 'package:flutter_example/pages/dashboard/boards/user_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _bodytempController = TextEditingController(text: "97");
  final _sysController = TextEditingController(text: "130");
  final _diaController = TextEditingController(text: "84");
  final _bpmController = TextEditingController(text: "80");
  final _spo2Controller = TextEditingController(text: "98");
  final _oxibpmController = TextEditingController(text: "86");
  final _glucoseController = TextEditingController(text: "90");
  int _pain = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(children: [
          const UserBoard(),
          BodyTemperatureBoard(bodytempController: _bodytempController),
          BloodpressureBoard(
            sysController: _sysController,
            diaController: _diaController,
            bpmController: _bpmController,
          ),
          OxygenBoard(
              spo2Controller: _spo2Controller,
              oxibpmController: _oxibpmController),
          BloodglucoseBoard(glucoseController: _glucoseController),
          PainBoard(changePain: _changePain, painlevel: _pain),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () => _save(),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 65, 133)),
              child: const Text('Save',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
            ),
          )
        ])
      ]),
    );
  }

  void _changePain(int level) {
    setState(() {
      _pain = level;
    });
  }

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('body_temp', _bodytempController.text);
    prefs.setString('sys', _sysController.text);
    prefs.setString('dia', _diaController.text);
    prefs.setString('bpm', _bpmController.text);
    prefs.setString('spo2', _spo2Controller.text);
    prefs.setString('oxi_bpm', _oxibpmController.text);
    prefs.setString('glucose', _glucoseController.text);
    prefs.setInt('pain_level', _pain);
  }
}

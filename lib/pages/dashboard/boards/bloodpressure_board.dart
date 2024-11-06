import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class BloodpressureBoard extends StatefulWidget {
  const BloodpressureBoard(
      {super.key,
      required this.sysController,
      required this.diaController,
      required this.bpmController});
  final TextEditingController sysController;
  final TextEditingController diaController;
  final TextEditingController bpmController;
  @override
  State<BloodpressureBoard> createState() => _BloodpressureBoardState();
}

class _BloodpressureBoardState extends State<BloodpressureBoard> {
  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(
                  Icons.monitor_heart,
                  size: 50,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                  CustomLocalizations.of(context)?.text("BloodPressure") ??
                      "BloodPressure",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 10, left: MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  CustomLocalizations.of(context)?.text("Pulse") ?? "Pulse",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ]),
          Wrap(children: [
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(
                  Icons.monitor_heart,
                  size: 40,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
                width: 75,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.005),
                child: TextField(
                  controller: widget.sysController,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
                child: TextField(
                  controller: TextEditingController(text: "/"),
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  enabled: false,
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            Container(
                width: 75,
                margin: const EdgeInsets.only(right: 0),
                child: TextField(
                  controller: widget.diaController,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: const Text("mmHg",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ))),
            Container(
                width: 75,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: TextField(
                  controller: widget.bpmController,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: const Text("bpm",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )))
          ])
        ]);
  }
}

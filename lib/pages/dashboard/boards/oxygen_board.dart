import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class OxygenBoard extends StatefulWidget {
  const OxygenBoard(
      {super.key,
      required this.spo2Controller,
      required this.oxibpmController});
  final TextEditingController spo2Controller;
  final TextEditingController oxibpmController;
  @override
  State<OxygenBoard> createState() => _OxygenBoardState();
}

class _OxygenBoardState extends State<OxygenBoard> {
  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(
                  Icons.thermostat,
                  size: 50,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: const Text("SpO2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1, top: 10),
                child: const Text(
                  "Pulse",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ]),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                width: 75,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: TextField(
                  controller: widget.spo2Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 40,
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
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.width * 0.03),
                child: const Text("%",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ))),
            Container(
                width: 75,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: TextField(
                  controller: widget.oxibpmController,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 40,
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
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text("bpm",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )))
          ])
        ]);
  }
}

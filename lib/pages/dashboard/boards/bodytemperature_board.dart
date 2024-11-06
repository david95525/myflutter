import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class BodyTemperatureBoard extends StatefulWidget {
  const BodyTemperatureBoard({super.key, required this.bodytempController});
  final TextEditingController bodytempController;

  @override
  State<BodyTemperatureBoard> createState() => _BodyTemperatureBoardState();
}

class _BodyTemperatureBoardState extends State<BodyTemperatureBoard> {
  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.thermostat,
                  size: 50,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                  CustomLocalizations.of(context)?.text("BodyTemperature") ??
                      "Body Temperature",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ]),
          Wrap(children: [
            Container(
                width: 75,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                ),
                child: TextField(
                  controller: widget.bodytempController,
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
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.width * 0.02),
                child: const Text("°F",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )))
          ]),
        ]);
  }
}

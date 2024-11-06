import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class BloodglucoseBoard extends StatefulWidget {
  const BloodglucoseBoard({super.key, required this.glucoseController});
  final TextEditingController glucoseController;
  @override
  State<BloodglucoseBoard> createState() => _BloodglucoseBoardState();
}

class _BloodglucoseBoardState extends State<BloodglucoseBoard> {
  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01),
                child: const Icon(
                  Icons.bloodtype,
                  size: 50,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: const Text("Blood Glucose",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ]),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                width: 80,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.14),
                child: TextField(
                  controller: widget.glucoseController,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 45,
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
                    left: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.height * 0.08),
                child: const Text(
                  "mg/dL",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ))
          ])
        ]);
  }
}

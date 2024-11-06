import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class PainBoard extends StatefulWidget {
  const PainBoard({super.key, required this.changePain,required this.painlevel});
  final Function changePain;
  final int painlevel;
  @override
  State<PainBoard> createState() => _PainBoardState();
}

class _PainBoardState extends State<PainBoard> {
  @override
  Widget build(BuildContext context) {
    List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.64,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: const Text(
                        "Pain Level",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  for (int i = 1; i <= numberList.length; i++) ...[
                    TextButton(
                        onPressed: () => widget.changePain(i),
                        style: TextButton.styleFrom(
                            backgroundColor: i == widget.painlevel
                                ? Colors.red
                                : Colors.grey[200],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )),
                        child: Text(i.toString())),
                    Container(
                        margin: EdgeInsets.zero,
                        width: 1,
                        height: i == numberList.length ? 0 : 20,
                        child: const VerticalDivider(
                            color: Colors.grey, thickness: 1))
                  ]
                ]))
          ])
        ]);
  }
}

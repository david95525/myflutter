import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/provider/member_provider.dart';
import 'package:flutter_example/widgets/custom_board.dart';
import 'package:provider/provider.dart';

class UserBoard extends StatelessWidget {
  const UserBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.81,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: const Color.fromARGB(255, 200, 245, 253),
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Icon(
                Icons.people,
                size: MediaQuery.of(context).size.height * 0.15,
                color: const Color.fromARGB(255, 29, 65, 133),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("2023-02-21 22:45"),
                      Text(
                        context.watch<MemberProvider>().name,
                        style: const TextStyle(
                            fontSize: 42, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${CustomLocalizations.of(context)?.text("Age") ?? "Age"}:${context.watch<MemberProvider>().age}                Main/02",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        context.watch<MemberProvider>().sex,
                        style: const TextStyle(fontSize: 20),
                      )
                    ])),
            Container(
                padding: EdgeInsets.only(
                    right: 10, left: MediaQuery.of(context).size.width * 0.2),
                height: MediaQuery.of(context).size.height * 0.2,
                child: const VerticalDivider(color: Colors.grey, thickness: 1)),
            Container(
                padding: const EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.people,
                        size: 50,
                        color: Color.fromARGB(255, 29, 65, 133),
                      ),
                      Text(
                        CustomLocalizations.of(context)?.text("Height") ??
                            "Height",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${context.watch<MemberProvider>().height} cm",
                        style: const TextStyle(fontSize: 30),
                      )
                    ])),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.people,
                        size: 50,
                        color: Color.fromARGB(255, 29, 65, 133),
                      ),
                      Text(
                        CustomLocalizations.of(context)?.text("Weight") ??
                            "Weight",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${context.watch<MemberProvider>().weight} kg",
                        style: const TextStyle(fontSize: 30),
                      )
                    ]))
          ])
        ]);
  }
}

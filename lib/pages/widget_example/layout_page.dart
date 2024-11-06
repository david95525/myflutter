import 'package:flutter/material.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});
  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 10, minHeight: 50.0),
          child: const SizedBox(
            width: 200,
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
        ),
        ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60.0, minHeight: 50.0),
            child: UnconstrainedBox(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.green),
                ),
              ),
            )),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(
              " hello world ",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(" I am Jack "),
          ],
        ),
        const Text(" hello world "),
        const Text(" I am Jack "),
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
                height: 100.0,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 30.0,
                        color: Colors.red,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ))),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 20,
              color: Colors.blue,
              child: const Text("Hello world",
                  style: TextStyle(color: Colors.white)),
            ),
            const Positioned(
              left: 18.0,
              child: Text("I am Jack"),
            ),
            const Positioned(
              top: 18.0,
              child: Text("Your friend"),
            )
          ],
        ),
        DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}

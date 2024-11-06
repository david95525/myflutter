import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  PointerEvent? _event;
  String _operation = "No Gesture detected!";
  String _dragposition = "(0,0)";
  double _top = 0.0;
  double _left = 0.0;
  double _height = 200.0;
  double _weight = 100.0;
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Wrap(
          children: [
            Text("Listener"),
            Text("AbsorbPointer"),
            Text("GestureDetector Tap"),
            Text("GestureDetector Drag"),
            Text("GestureRecognizer"),
          ],
        ),
        Wrap(
          children: [
            Listener(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 100.0,
                height: 200.0,
                child: Text(
                  '${_event?.localPosition ?? ''}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPointerDown: (PointerDownEvent event) =>
                  setState(() => _event = event),
              onPointerMove: (PointerMoveEvent event) =>
                  setState(() => _event = event),
              onPointerUp: (PointerUpEvent event) =>
                  setState(() => _event = event),
            ),
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 100.0,
                    height: 200.0,
                  ),
                ),
              ),
              onPointerDown: (event) => debugPrint("up"),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 100.0,
                height: 200.0,
                child: Text(
                  _operation,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => updateTapText("Tap"),
              onDoubleTap: () => updateTapText("DoubleTap"),
              onLongPress: () => updateTapText("LongPress"),
            ),
            SizedBox(
                width: 100,
                height: 200,
                child: ColoredBox(
                  color: Colors.grey,
                  child: Stack(children: [
                    Positioned(
                      top: _top,
                      left: _left,
                      child: GestureDetector(
                        child: const CircleAvatar(child: Text("A")),
                        onPanDown: (DragDownDetails e) {
                          updateDragText(e.globalPosition.toString());
                        },
                        onPanUpdate: (DragUpdateDetails e) {
                          setState(() {
                            _left += e.delta.dx;
                            _top += e.delta.dy;
                          });
                        },
                        onPanEnd: (DragEndDetails e) {},
                      ),
                    )
                  ]),
                )),
            Text(_dragposition),
            RichText(
                text: TextSpan(
              text: "點我變色",
              style: TextStyle(
                fontSize: 12.0,
                color: _toggle ? Colors.red : Colors.black,
              ),
              recognizer: _tapGestureRecognizer
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            )),
          ],
        ),
        Wrap(children: [
          const Text("GestureDetector ScaleUpdate"),
          GestureDetector(
            child:
                Image.asset('assets/back.jpg', width: _weight, height: _height),
            onScaleUpdate: (ScaleUpdateDetails details) {
              setState(() {
                _height = 200 * details.scale.clamp(.8, 10.0);
                _weight = 100 * details.scale.clamp(.8, 10.0);
              });
            },
          ),
        ])
      ],
    );
  }

  void updateTapText(String text) {
    setState(() {
      _operation = text;
    });
  }

  void updateDragText(String text) {
    setState(() {
      _dragposition = text;
    });
  }
}

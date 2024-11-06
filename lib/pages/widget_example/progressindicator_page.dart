import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 3,
            width: 200,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.red, end: Colors.green)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
              height: 3,
              width: 500,
              child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue))),
        ],
      ),
    );
  }
}

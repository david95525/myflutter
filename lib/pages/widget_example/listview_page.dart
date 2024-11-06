import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});
  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("滾動控制")),
      body: Scrollbar(
        controller: _controller,
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0,
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(
                  .0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
              }),
    );
  }
}

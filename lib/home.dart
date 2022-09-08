import 'package:flutter/material.dart';

import 'counter.dart';
import 'http_request.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.title,
    this.message,
  });

  final String title;
  final String? message;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.message?.isNotEmpty ?? false
                  ? widget.message!
                  : 'You have pushed the button this many times:',
            ),
            Text(
              key: const ValueKey('counter-text'),
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () => HttpRequest.head(
                  'https://docs.flutter.dev/cookbook/testing/unit/mocking'),
              child: const Text(
                'HTTP Head Request',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    key: const ValueKey('increment-button'),
                    onPressed: () => setState(_counter.increment),
                    elevation: 0,
                    child: const Icon(Icons.add),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () => setState(_counter.decrement),
                  elevation: 0,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

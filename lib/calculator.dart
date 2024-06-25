import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _increment = 2;
  int _numberOnClicks = 0;

  void _incrementCounter() {
    setState(() {
      _counter+=_increment;
      _numberOnClicks++;
    });
  }

   void setIncrement(value) async {
    setState(() {
      _increment = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final int total = _counter + _increment;
    String newString = 'Vous avez cliqué $_numberOnClicks fois';

    Widget w() {
      if(_numberOnClicks > 0) {
        return Text(
          newString,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      } else {
        return const Text('');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: "Enter your number"),
              keyboardType: TextInputType.number,
              onChanged: (String value) async {
                if (value == '0') {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Nope'),
                        content: Text('Vous ne pouvez pas incrémenter par zéro'),
                      );
                    },
                  );
                } else {
                  setIncrement(value);
                }
              }
            ),
            w(),
            const Text(
              '',
            ),
            Text(
              '$_counter + $_increment',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '',
            ),
            Text(
              '$total',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            // isExtended: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[const Icon(Icons.add), Text('$_increment')]
            )
          ),
    );
  }
}
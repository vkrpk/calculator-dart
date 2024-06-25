import 'package:flutter/material.dart';

const List<String> operatorList = <String>['+', '-', '%'];

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _increment = 2;
  int _numberOnClicks = 0;
  String _dropdownValue = operatorList.first;

  int calcul() {
    if(_increment == 0) {
      return _counter;
    }
    if(_dropdownValue == '+') {
      return _counter+_increment;
    } else if (_dropdownValue == '-') {
      return _counter-_increment;
    } else {
      return _counter ~/ _increment;
    }
  }

  void _incrementCounter(isTrue) {
    if (isTrue) {
      setState(() {
        _counter=calcul();
        _numberOnClicks++;
      });
    }
  }

   void setIncrement(value) async {
    setState(() {
      _increment = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            DropdownButton<String>(
              value: _dropdownValue,
              // initialSelection: operatorList.first,
              items: operatorList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              hint: const Text(
                "Choose a Car Model",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
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
                        content: Text('Vous ne pouvez pas calculer par zéro'),
                      );
                    },
                  );
                } else if (value == '' || value == null) {
                    setIncrement('0');
                  return;
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
              '$_counter $_dropdownValue $_increment',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '',
            ),
            Text(
              '${calcul()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () => _incrementCounter(true),
            tooltip: 'Increment',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // const Icon(Icons.add),
                Text('$_dropdownValue $_increment')
              ]
            )
          ),
    );
  }
}

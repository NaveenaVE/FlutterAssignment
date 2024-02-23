import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  _FibonacciPageState createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  final TextEditingController _positionController = TextEditingController();
  String? errorMessage;
  BigInt? result;

  final Map<int, BigInt> _fibonacciCache = HashMap();

  void calculateFibonacci() {
    FocusManager.instance.primaryFocus?.unfocus();
    _fibonacciCache.clear();
    final String inputText = _positionController.text.trim();
    if (inputText.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a number';
        result = null;
      });
      return;
    }

    final int position = int.tryParse(inputText) ?? 0;
    if (position < 0) {
      setState(() {
        errorMessage = 'Please enter a non-negative number';
        result = null;
      });
      return;
    }

    setState(() {
      try {
        result = null;
        result = fibonacci(position);
      }
      catch(e)
      {
        errorMessage = 'Please try again with different number';
      }
      if(result == null)
        {
          errorMessage = 'Please try again with different number';
        }
      else {
        errorMessage = null;
      }
    });
  }
// Recursive function with memoization
  BigInt fibonacci(int n) {
    if (n <= 1) return BigInt.from(n);

    // Check if the Fibonacci number for 'n' is already computed
    if (!_fibonacciCache.containsKey(n)) {
      // If not computed, recursively calculate and store in the cache
      _fibonacciCache[n] = fibonacci(n - 1) + fibonacci(n - 2);
    }

    // Return the computed Fibonacci number from the cache
    return _fibonacciCache[n]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find nth Element'),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter position',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _positionController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Enter position',
                  hintText: 'Enter a non-negative number',
                ),
              ),
              const SizedBox(height: 4),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    calculateFibonacci();
                  },
                  child: const Text('Find Element',style: TextStyle(color: Colors.green),),
                ),
              ),
              const SizedBox(height: 20),
              if (result != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Value at Position ${_positionController.text} in Fibonacci Series:',
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      maxLines: 1000,
                    ),
                    Text(
                      '$result',
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1000,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }
}

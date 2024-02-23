// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:techquest/ques/fileuploadpage.dart';
import 'package:techquest/ques/substringpage.dart';
import 'ques/fibonaccipage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fibonacci Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Questions'),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                '1. Create a file upload feature that accepts any image or video files less than 10MB and upload it to firebase storage',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FileUploadScreen()),
                  );
                },
                child: const Text('Answer 1',style: TextStyle(color: Colors.green),),
              ),
              const SizedBox(height: 40),
              const Text(
                '2. Recursive function that accepts integer value and returns the fibonacci value at the position in the series',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FibonacciPage()),
                  );
                },
                child: const Text('Answer 2',style: TextStyle(color: Colors.green),),
              ),
              const SizedBox(height: 40),
              const Text(
                '3. A Balanced string that consists of two different characters and both appear exactly same no of times',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SubstringPage()),
                  );
                },
                child: const Text('Answer 3',style: TextStyle(color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


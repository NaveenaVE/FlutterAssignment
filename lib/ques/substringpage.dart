
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubstringPage extends StatefulWidget {
  const SubstringPage({super.key});

  @override
  _SubstringPageState createState() => _SubstringPageState();
}
class _SubstringPageState extends State<SubstringPage> {
  final TextEditingController _inputController = TextEditingController();
  String? errorMessage;
  List<String> _result = [];

  void _getBalancedSubstrings(String S) {
    if (_inputController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter string';
        _result = [];
      });
      return;
    }
    List<String> substrings = [];
    for (int i = 0; i < S.length; i++) {
      for (int j = i + 2; j <= S.length; j++) {
        String substring = S.substring(i, j);
        if (_isBalanced(substring) && !substrings.contains(substring)) {
          substrings.add(substring);
        }
      }
    }
    setState(() {
      errorMessage = null;
      _result = _longestBalancedSubstrings(substrings);
    });
  }

  bool _isBalanced(String s) {
    Set<String> set = s.split('').toSet();
    if (set.length != 2) return false;
    int count1 = s.replaceAll(set.elementAt(0), '').length;
    int count2 = s.replaceAll(set.elementAt(1), '').length;
    return count1 == count2;
  }

  List<String> _longestBalancedSubstrings(List<String> substrings) {
    int maxLength = 0;
    List<String> longestSubstrings = [];
    for (String substring in substrings) {
      if (substring.length > maxLength) {
        maxLength = substring.length;
        longestSubstrings = [substring];
      } else if (substring.length == maxLength) {
        longestSubstrings.add(substring);
      }
    }
    return longestSubstrings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Balanced Substrings'),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _inputController,
              maxLines: null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[a-z]')), // Allow only lowercase letters
              ],
              decoration: const InputDecoration(
                hintText: 'Enter string...',
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  _getBalancedSubstrings(_inputController.text);
                },
                child: const Text('Get Balanced Substrings',style: TextStyle(color: Colors.green),),
              ),
            ),
            const SizedBox(height: 20),
            _result.isNotEmpty ?
            Text('Longest Balanced Substrings: ${_result.length}', style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
      ):Container(),
            Expanded(
              child: ListView.builder(
                itemCount: _result.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_result[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

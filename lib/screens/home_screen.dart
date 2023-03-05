import 'package:flutter/material.dart';
import 'package:wordgridapp/screens/alphabet_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  int _rows = 0;
  int _columns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Grid Size'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of rows';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rows = int.parse(value!);
                },
                decoration: const InputDecoration(
                  labelText: 'Number of Rows',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of columns';
                  }
                  return null;
                },
                onSaved: (value) {
                  _columns = int.parse(value!);
                },
                decoration: const InputDecoration(
                  labelText: 'Number of Columns',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlphabetInputPage(rows: _rows, columns: _columns),
                        ));
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

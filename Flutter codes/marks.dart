import 'package:flutter/material.dart';

void main() => runApp(MarksPage(
      email: '', 
      rollNumber: '', 
      name: '', 
      branch: '', 
      gender: '', 
    ));

class MarksPage extends StatelessWidget {
  final String email;
  final String rollNumber;
  final String name;
  final String branch;
  final String gender;

  const MarksPage({
    Key? key,
    required this.email,
    required this.rollNumber,
    required this.name,
    required this.branch,
    required this.gender,
  }) : super(key: key);

  static const String _title = 'Marks Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: MyForm(
            email: email,
            rollNumber: rollNumber,
            name: name,
            branch: branch,
            gender: gender,
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  final String email;
  final String rollNumber;
  final String name;
  final String branch;
  final String gender;

  const MyForm({
    Key? key,
    required this.email,
    required this.rollNumber,
    required this.name,
    required this.branch,
    required this.gender,
  }) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> subjects = ['Wireless Technology', 'Image Processing', 'Data Mining and Business Intelligence', 'WebX', 'Artificial Intelligence and Data Science'];
  Map<String, TextEditingController> marksControllers = {};

  @override
  void initState() {
    super.initState();
    for (String subject in subjects) {
      marksControllers[subject] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in marksControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          for (String subject in subjects)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  subject,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: marksControllers[subject],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Marks',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter marks for $subject';
                    }
                    return null;
                  },
                ),
              ],
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.reset();
                  for (TextEditingController controller
                      in marksControllers.values) {
                    controller.clear();
                  }
                },
                child: const Text('Clear'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validation passed, handle form submission
                    _submitForm();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Handle form submission here
    Map<String, String> marksMap = {};
    for (String subject in subjects) {
      marksMap[subject] = marksControllers[subject]!.text;
    }

    // Navigate to the next page and pass the collected data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalPage(
          email: widget.email,
          rollNumber: widget.rollNumber,
          name: widget.name,
          branch: widget.branch,
          gender: widget.gender,
          marksMap: marksMap,
        ),
      ),
    );
  }
}

class FinalPage extends StatelessWidget {
  final String email;
  final String rollNumber;
  final String name;
  final String branch;
  final String gender;
  final Map<String, String> marksMap;

  const FinalPage({
    Key? key,
    required this.email,
    required this.rollNumber,
    required this.name,
    required this.branch,
    required this.gender,
    required this.marksMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Page')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Roll Number: $rollNumber', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Branch: $branch', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Gender: $gender', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Marks:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: marksMap.entries.map((entry) {
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: TextStyle(fontSize: 16)),
                        Text(entry.value, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'marks.dart';
class InfoPage extends StatefulWidget {
  final String email;

  const InfoPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String? rollNumber;
  String? name;
  String? selectedBranch;
  String? selectedGender;

  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> branches = ['Comps', 'IT', 'Electronics', 'Chemical', 'Civil'];
  final List<String> genders = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Information Page')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: rollNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Roll Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your roll number';
                  }
                  return null;
                },
                onSaved: (value) => rollNumber = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => name = value,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedBranch,
                onChanged: (value) {
                  setState(() {
                    selectedBranch = value;
                  });
                },
                items: branches.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch,
                    child: Text(branch),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Branch',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your branch';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Gender', style: TextStyle(fontSize: 16)),
                  ...genders.map((gender) {
                    return RadioListTile<String>(
                      title: Text(gender),
                      value: gender,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      rollNumberController.clear();
                      nameController.clear();
                      setState(() {
                        selectedBranch = null;
                        selectedGender = null;
                      });
                    },
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Navigate to the next page and pass the collected data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarksPage(
                              email: widget.email,
                              rollNumber: rollNumber!,
                              name: name!,
                              branch: selectedBranch!,
                              gender: selectedGender!,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


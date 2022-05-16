import 'package:flutter/material.dart';
import 'package:navigation_app/db/database.dart';

import '../model/students.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();

  late Future<List<Student>> _studentList;

  bool _isUpdate = false;
  late Student _studentForUpdate;

// Get students list from db
  void refreshList() {
    setState(() {
      _studentList = DBProvider.instance.getStudents();
    });
  }

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite DB'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: _validateName,
                    onSaved: (value) {},
                    controller: _studentNameController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Name",
                      icon: Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                // color: Colors.green,
                child: Text(
                  (_isUpdate ? 'UPDATE' : 'ADD'),
                ),
                onPressed: () {
                  if (!_isUpdate) {
                    // Add new record
                    // Check if the form is valid
                    if (_formStateKey.currentState!.validate()) {
                      // Insert new record into DB
                      DBProvider.instance.insertStudent(
                          Student(null, _studentNameController.text));
                    }
                  } else {
                    // Update resord
                    // Check if the form is valid
                    if (_formStateKey.currentState!.validate()) {
                      // Insert new record into DB
                      DBProvider.instance
                          .updateStudent(Student(_studentForUpdate.id,
                              _studentNameController.text))
                          .then((value) {
                        setState(() {
                          _isUpdate = false;
                        });
                      });
                    }
                  }

                  // Reset form and update list
                  _studentNameController.text = '';
                  refreshList();
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                child: const Text('RESET'),
                onPressed: () {
                  // Reset form and update list
                  setState(() {
                    _isUpdate = false;
                  });

                  _studentNameController.text = '';
                  refreshList();
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder<List<Student>>(
              future: _studentList,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return generateList(snapshot.data!);
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Text('No Data Found');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            ),
          ],
          rows: students
              .map(
                (student) => DataRow(cells: [
                  DataCell(Text(student.id.toString())),
                  DataCell(Text(student.name), onTap: () {
                    setState(() {
                      _isUpdate = true;
                      _studentForUpdate = Student(student.id, student.name);
                    });
                    _studentNameController.text = student.name;
                  }),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        DBProvider.instance.deleteStudent(student);
                        refreshList();
                      },
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}

String? _validateName(String? value) {
  if (value!.isNotEmpty) {
    return null;
  } else {
    return '*Имя обязательное поле';
  }
}

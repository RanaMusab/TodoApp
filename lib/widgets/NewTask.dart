import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_app/apidetails/ApiService.dart';
import 'package:todo_app/model/fetchTask.dart';

class NewTask extends StatefulWidget {

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _form = GlobalKey<FormState>();
  bool completed = false;
  final descController = TextEditingController();
  ProgressDialog pr;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    return SingleChildScrollView(
        child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          top: 10,
        ),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  maxLines: 4,
                  controller: descController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Describe Your Task',
                    hintStyle: TextStyle(color: Colors.grey),
                    // isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(15, 15, 7.5, 7.5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  )),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: () async {
                    await ApiService()
                        .addTasks(descController.text, pr)
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  textColor: Colors.white,
                  child: Text('Add Task')),
            ],
          ),
        ),
      ),
    ));
  }
}

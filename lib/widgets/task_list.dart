import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_app/Screens/HomeScreen.dart';
import 'package:todo_app/apidetails/ApiService.dart';

import 'package:todo_app/model/addTask.dart';
import 'package:todo_app/model/fetchTask.dart';

import 'NewTask.dart';

class TaskList extends StatelessWidget {
  final AllTask tasks;

  TaskList(this.tasks);

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Container(
      // height: MediaQuery.of(context).size.width,
      child: tasks.data.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No task added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '<<<< Drag Right for Completed >>>>',
                    style: TextStyle(fontSize: 10, color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Dismissible(
                        key: ValueKey(index.toString()),
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).errorColor,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40,
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        ),
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(39, 99, 209, 10),
                          ),
                          child: Icon(
                            Icons.done_all,
                            color: Colors.white,
                            size: 40,
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        ),
                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Are you sure?'),
                                content:
                                    Text("Do you want to remove this Task?"),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: Text('NO'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: Text('YES'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if(tasks.data[index].completed){
                               Fluttertoast.showToast(
                                  msg: "Task Already Completed",
                                  textColor: Colors.white,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.deepPurple);
                            }else{
                            return ApiService()
                                .updateTasks(true, tasks.data[index].id, pr).whenComplete(() {

                                  Get.offAll(HomeScreen());
                            });}
                          }
                        },
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await ApiService()
                                .deleteTasks(tasks.data[index].id, pr)
                                .then((value) {
                              if (value) {
                                Fluttertoast.showToast(
                                    msg: "Deleted Successfully",
                                    textColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.deepPurple);
                              }
                            });
                          }
                        },
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              trailing: Icon(
                                Icons.label_important_outlined,
                                color: Colors.deepPurple,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                  tasks.data[index].completed
                                      ? 'assets/splash_log.png'
                                      : 'assets/Notdone.png',
                                ),
                                backgroundColor: Colors.deepPurple,
                                radius: 30,
                              ),
                              title: Text(
                                'Task ' + (index + 1).toString(),
                                style: Theme.of(context).textTheme.title,
                              ),
                              subtitle: Text(tasks.data[index].description),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: tasks.data.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '<<<< Drag Left for Delete >>>>',
                    style: TextStyle(fontSize: 10, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
    );
  }
}

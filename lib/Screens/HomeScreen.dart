import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Screens/LoginScreen.dart';
import 'package:todo_app/Storage/shared_preference.dart';
import 'package:todo_app/apidetails/ApiService.dart';
import 'package:todo_app/model/fetchTask.dart';
import 'package:todo_app/widgets/NewTask.dart';
import 'package:todo_app/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AllTask model;
  bool loading = true;

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await ApiService().fetchTasks().then((value) {
      setState(() {
        model=value;
        loading=false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                SharedPrefClient().clearUser();
                Get.offAll(LoginScreen());
              })
        ],
        title: Text('All Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder: (_) {
              return GestureDetector(
                onTap: () {},
                child: NewTask(),
                behavior: HitTestBehavior.opaque,
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body:
          loading ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator())) : TaskList(model,),
    );
  }
}

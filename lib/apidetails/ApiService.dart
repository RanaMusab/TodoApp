import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as g;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Screens/HomeScreen.dart';
import 'package:todo_app/Storage/shared_preference.dart';
import 'package:todo_app/model/LoginModel.dart';
import 'package:todo_app/model/addTask.dart';
import 'package:todo_app/model/fetchTask.dart';

import 'apiclass.dart';

class ApiService {
  Dio _dio = new Dio();

  Future Login(String email, String password, ProgressDialog pr) async {
    var resp;
    pr.show();

    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      resp = await _dio.post("${API.Login}", data: {
        "email": email,
        "password": password,
      });
    } catch (e) {
      pr.hide();
      Fluttertoast.showToast(
          msg: "Please check your credentials and Login again",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
    }
    if (resp.statusCode == 200) {
      var loginUser = resp.data;
      print(resp);
      LoginModel userModel = LoginModel.fromJson(loginUser);

      pr.hide();
      SharedPrefClient().setUser(
        name: userModel.user.name,
        email: userModel.user.email,
        id: userModel.user.id,
        age: userModel.user.age,
        token: userModel.token,
      );
      Fluttertoast.showToast(
          msg: "Login Successfully",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
      g.Get.offAll(HomeScreen());
    } else {
      pr.hide();
      Fluttertoast.showToast(
          msg: "" + resp.statusMessage,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
    }
  }

  Future SignUp(String name, String email, String password, int age,
      ProgressDialog pr) async {
    var resp;
    pr.show();

    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      resp = await _dio.post("${API.Register}", data: {
        "name": name,
        "email": email,
        "password": password,
        "age": age,
      });
    } catch (e) {
      pr.hide();
      Fluttertoast.showToast(
          msg: "Something went wrong or email already exists",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
    }
    if (resp.statusCode == 201) {
      var loginUser = resp.data;
      print(resp);
      LoginModel userModel = LoginModel.fromJson(loginUser);

      pr.hide();
      SharedPrefClient().setUser(
        name: userModel.user.name,
        email: userModel.user.email,
        id: userModel.user.id,
        age: userModel.user.age,
        token: userModel.token,
      );
      Fluttertoast.showToast(
          msg: "Registered Successfully",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
      g.Get.offAll(HomeScreen());
    } else {
      pr.hide();
      Fluttertoast.showToast(
          msg: "" + resp.statusMessage,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
    }
  }

  Future<bool> deleteTasks(String id,ProgressDialog pr) async {
    pr.show();
    final sharedPref = await SharedPreferences.getInstance();
    String token = sharedPref.getString('token');
    // String id= sharedPref.getString('_id');
    var resp;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Authorization'] = token;
      resp = await _dio.delete("${API.addTask+'/'+id}");
    } catch (e) {
      pr.hide();
      Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
    }
    if (resp.statusCode == 200) {
    pr.hide();
     return true;
    }
  }
  Future<AllTask> fetchTasks() async {
    final sharedPref = await SharedPreferences.getInstance();
    String token = sharedPref.getString('token');
    // String id= sharedPref.getString('_id');
    var resp;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Authorization'] = token;
      resp = await _dio.get("${API.addTask}");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
      return null;
    }
    if (resp.statusCode == 200) {
      var data = resp.data;
      print(resp);
      AllTask model = AllTask.fromJson(data);
      return model;
    }
  }

  Future<bool> addTasks(String desc, ProgressDialog pr) async {
    final sharedPref = await SharedPreferences.getInstance();
    String token = sharedPref.getString('token');
    var resp;
    pr.show();

    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Authorization'] = token;
      resp = await _dio.post("${API.addTask}", data: {
        "description": desc,
      });
    } catch (e) {
      pr.hide();
      Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
      return false;
    }
    if (resp.statusCode == 201) {
      var data = resp.data;
      print(resp);
      AddTask model = AddTask.fromJson(data);
      if (model.success) {
        pr.hide();
        Fluttertoast.showToast(
            msg: "Added Successfully",
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.deepPurple);
        return true;
      }
    }
  }
  Future<bool> updateTasks(bool completed, String id,ProgressDialog pr) async {
    final sharedPref = await SharedPreferences.getInstance();
    String token = sharedPref.getString('token');
    var resp;
    pr.show();
print(id);
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Authorization'] = token;
      resp = await _dio.put("${API.addTask+'/'+id}", data: {
        "completed": completed,
      });
    } catch (e) {
      pr.hide();
      Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepPurple);
      return false;
    }
    if (resp.statusCode == 200) {
      var data = resp.data;
      AddTask model = AddTask.fromJson(data);
      if (model.success) {
        pr.hide();
        Fluttertoast.showToast(
            msg: "Task Completed",
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.deepPurple);
        return false;
      }
    }
  }
}

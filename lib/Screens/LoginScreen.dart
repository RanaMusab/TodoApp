import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_app/apidetails/ApiService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  ProgressDialog pr;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool register = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/splash_log.png'))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                register ? 'Sign Up Here' : 'Login Here',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              register
                  ? SizedBox(
                      height: 30,
                    )
                  : SizedBox.shrink(),
              register
                  ? TextFormField(
                      controller: nameController,
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
                        hintText: 'Enter Name',
                        prefixIcon: Icon(Icons.person),

                        // isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ))
                  : SizedBox.shrink(),
              register
                  ? SizedBox(
                      height: 30,
                    )
                  : SizedBox.shrink(),
              register
                  ? TextFormField(
                      controller: ageController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter Age";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter Age in years',
                        prefixIcon: Icon(Icons.calendar_today),

                        // isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ))
                  : SizedBox.shrink(),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Email";
                    }
                    if (!value.contains('@') && !value.contains('.com')) {
                      return "Please Enter Correct Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,

                    filled: true,
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.mail),

                    // isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  )),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Password";
                    }
                    if (value.length < 6) {
                      return "Password Length should be greater than 6";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),

                    // isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  )),
              SizedBox(
                height: 30,
              ),
              register
                  ? InkWell(
                      onTap: () {
                        final val = _formKey.currentState.validate();
                        if (!val) {
                          return;
                        } else {
                          ApiService().SignUp(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              int.parse(ageController.text),
                              pr);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.deepPurple),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        final val = _formKey.currentState.validate();
                        if (!val) {
                          return;
                        } else {
                          ApiService().Login(emailController.text,
                              passwordController.text, pr);
                          // emailController.clear();
                          // passwordController.clear();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.deepPurple),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    register = !register;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(register ? 'Back to' : 'New User?'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      register ? 'Login?' : 'Register Here',
                      style: TextStyle(color: Colors.deepPurple),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

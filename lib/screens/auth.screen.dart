import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/helpers/dialog-alert.helper.dart';
import 'package:shoap_app/providers/auth.provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoggedIn = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    DialogAlertsHelper.showSpinner(context);
    try {
      if (!_isLoggedIn) {
        await Provider.of<AuthProvider>(context, listen: false).signup(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await Provider.of<AuthProvider>(context, listen: false).login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
      Navigator.of(context).pop();
    } catch (err) {
      print(err);
      Navigator.of(context).pop();
      DialogAlertsHelper.showErrorMsg(context, 'Something went wrong', () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.indigoAccent],
                  end: Alignment.bottomRight)),
          child: Center(
            child: Column(
              children: [
                Transform.rotate(
                  angle: -(pi / 10),
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 100, right: 50),
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange),
                    // transform: Matrix4.rotationZ(-250.0)..translate(100, 100, 100),
                    child: Card(
                      elevation: 16,
                      color: Colors.orange,
                      child: Center(
                        child: const Text(
                          'My Shop App',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              shadows: [
                                Shadow(color: Colors.white70, blurRadius: 10.0),
                                Shadow(color: Colors.white60, blurRadius: 10.0),
                                Shadow(color: Colors.white54, blurRadius: 10.0),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isLoggedIn ? 300 : 400,
                  padding:
                      EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 12),
                  margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height - 100) * 0.10),
                  child: Card(
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  labelText: 'Email',
                                  suffixIcon: const Icon(Icons.email),
                                ),
                                validator: (value) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  labelText: 'Password',
                                  suffixIcon: const Icon(Icons.keyboard),
                                ),
                                validator: (val) {
                                  final trimmedVal = val.trim();
                                  if (trimmedVal.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (trimmedVal.length < 6) {
                                    return 'Password must be 6 or more char long';
                                  }
                                  return null;
                                },
                              ),
                              if (_isLoggedIn == false)
                                AnimatedOpacity(
                                  opacity: !_isLoggedIn ? 1.0 : 0.0,
                                  duration: Duration(microseconds: 600),
                                  curve: Curves.bounceInOut,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8),
                                      labelText: 'Confirm Password',
                                      suffixIcon: const Icon(Icons.keyboard),
                                    ),
                                    validator: (val) {
                                      if (val != _passwordController.text) {
                                        return 'password and confirm password must be same';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _submitForm();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                          !_isLoggedIn ? 'Signup' : 'Login'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('--or--'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLoggedIn = !_isLoggedIn;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                          _isLoggedIn ? 'Signup' : 'Login'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

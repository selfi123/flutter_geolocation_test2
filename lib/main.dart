import 'dart:io';
import 'package:flutter_geolocation_test2/pages/logoanim.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_geolocation_test2/widget_tree.dart';
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
  ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyALDNpdn_cxSyRoAGUBzglk9Guorim-QZA",
        appId: "1:482126041881:android:f7848a6b1e89c437c52b88",
        messagingSenderId: "482126041881",
        projectId: "flutter-hosmngment"
    )
  )
 : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ImageAnimationScreen(),
    );
  }
}

/*
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
    title: Text('Login'),
    ),
      body: Center( child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ Image.asset('assets/snims.png'),


            const SizedBox(height: 30),
            const Text( 'Sree Narayana Institute of Medical Sciences',
              style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, ), ),
            SizedBox(height: 20),
            TextFormField( decoration:
            InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(), ),
              validator: (value) { if (value == null || value.isEmpty)
              { return 'Please enter your email address'; } return null; },
            ),
            SizedBox(height: 20), TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password'; }
                return null; },
              obscureText: true, ),
            SizedBox(height: 30),
            ElevatedButton( onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Handle login form submission
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DutyTime()),
                );
              }
            },
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), ), ), ),
            SizedBox(height: 20),
            Text( 'Forgot your password?',
              style:
              TextStyle( fontSize: 16, color: Colors.blue[700], ), ), ], ), ), ), ), ), );
  }
}
*/
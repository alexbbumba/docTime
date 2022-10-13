import 'package:doc_time/screens/authenticate/authenticate.dart';
import 'package:doc_time/screens/home.dart';
import 'package:doc_time/screens/patient_doctor.dart';
import 'package:doc_time/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // returns either home widget or the authenticate widget
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              return DoctorOrPatient();
            } else {
              return Authenticate();
            }
          }),
    );
  }
}

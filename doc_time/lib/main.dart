import 'package:doc_time/globals.dart';

import 'package:doc_time/screens/doctor/main_doctor.dart';
import 'package:doc_time/screens/home.dart';
import 'package:doc_time/screens/patient/booking_screen.dart';

import 'package:doc_time/screens/patient/patient.dart';
import 'package:doc_time/screens/patient_doctor.dart';

import 'package:doc_time/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>
            user == null ? const Wrapper() : const DoctorOrPatient(),
        '/decision': (context) =>
            isDoctor ? const MainPageDoctor() : const MainPatient(),
        '/home': (context) => Home(),
        '/booking': (context) => BookingScreen(doctor: '', doctorUid: '')
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

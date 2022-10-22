import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DocDetails extends StatefulWidget {
  final DocumentSnapshot details;
  const DocDetails({super.key, required this.details});

  @override
  State<DocDetails> createState() => _DocDetailsState();
}

class _DocDetailsState extends State<DocDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromARGB(255, 183, 203, 219),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                        },
                        icon: Icon(Icons.arrow_back)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.notifications)),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(widget.details['img']),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.details['address'],
                  style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                ),
                Text(
                  widget.details['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: Colors.brown),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 250, 193),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                      ),
                      Divider(),
                      Text(
                        widget.details['bio'],
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        icon: Icon(Icons.lock_clock)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/booking', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue),
                        child: const Text('Schedule Appointment'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

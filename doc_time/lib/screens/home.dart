import 'package:doc_time/screens/details/doc_details.dart';
import 'package:flutter/material.dart';
import 'package:doc_time/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DocDetails(details: post);
    }));
  }

  final AuthService _auth = AuthService();
  final CollectionReference doctorsData =
      FirebaseFirestore.instance.collection('doctor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 203, 219),
      appBar: AppBar(
        title: Text(
          'Avilable Doctors',
          style: TextStyle(
            color: Colors.brown,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: doctorsData.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapsot) {
          if (streamSnapsot.hasData) {
            return ListView.builder(
                itemCount: streamSnapsot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapsot.data!.docs[index];

                  return Container(
                      child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(children: [
                                InkWell(
                                  onTap: () {
                                    navigateToDetail(documentSnapshot);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 245, 248, 204),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: NetworkImage(
                                                  documentSnapshot['img']),
                                            ),
                                            Column(
                                              children: [
                                                Text(documentSnapshot['name'],
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 20.0,
                                                    )),
                                                Text(
                                                    documentSnapshot['address'],
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 15.0,
                                                    )),
                                                Text(
                                                    documentSnapshot[
                                                        'hospital'],
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 15.0,
                                                    )),
                                                Text(
                                                    documentSnapshot[
                                                        'specialization'],
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 15.0,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]))),
                    ],
                  ));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      //   child: Container(
      //     color: Colors.blue,
      //     child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.green, padding: EdgeInsets.all(15.0)),
      //         onPressed: () async {
      //           await _auth.signOut();
      //           Navigator.pop(
      //             context,
      //             MaterialPageRoute(builder: (context) => const Authenticate()),
      //           );
      //         },
      //         child: Text(
      //           'Sign Out',
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         )),
      //   ),
      // ),
    );
  }
}

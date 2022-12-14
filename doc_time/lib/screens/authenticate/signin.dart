import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doc_time/globals.dart';
//import 'package:doc_time/helperFunction/shared-pref_helper.dart';
import 'package:doc_time/screens/authenticate/register.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: withEmailPassword(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/group1.jpg'),
                  fit: BoxFit.fill
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                'Login',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // email
            TextFormField(
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Email',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Email';
                } else if (!emailValidate(value)) {
                  return 'Please enter correct Email';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            // password
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              //keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Password',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Password';
                return null;
              },
              obscureText: true,
            ),
            // sign in button
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  focusNode: f3,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // showLoaderDialog(context);
                      _signInWithEmailAndPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.indigo[900],
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // forget password
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // dont have account
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () => _pushPage(context, const Register()),
                    child: Text(
                      'Signup here',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }

      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      var basicInfo = snap.data() as Map<String, dynamic>;

      isDoctor = basicInfo['type'] == 'doctor' ? true : false;

      // // save data to local storage
      // SharedPreferenceHelper().saveUserId(user.uid);
      // // SharedPreferenceHelper().saveProfileUrl(user);
      // SharedPreferenceHelper().saveUserName(basicInfo['name']);
      // SharedPreferenceHelper().saveAccountType(basicInfo['type']== 'doctor'? true :false);

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/decision', (Route<dynamic> route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(" There was a problem signing you in"),
          ],
        ),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}



// import 'package:doc_time/services/auth.dart';
// import 'package:flutter/material.dart';

// class SignIn extends StatefulWidget {
//   final Function toggleView;

//   const SignIn({Key? key, required this.toggleView}) : super(key: key);

//   @override
//   State<SignIn> createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String email = '';
//   String password = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 183, 203, 219),
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 27, 30, 32),
//           elevation: 0,
//           title: Text('Sign in to the docTime'),
//           actions: [
//             TextButton.icon(
//                 onPressed: () {
//                   widget.toggleView();
//                 },
//                 icon: Icon(Icons.person),
//                 label: Text(
//                   'Register',
//                   style: TextStyle(
//                     color: Colors.green,
//                   ),
//                 ))
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.fromLTRB(10, 80, 10, 0),
//           child: Container(
//             child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                           hintText: 'Email',
//                           fillColor: Colors.white,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2.0),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.pink, width: 2.0),
//                             borderRadius: BorderRadius.circular(10),
//                           )),
//                       validator: (val) {
//                         if (val!.isEmpty) {
//                           return 'Email is required';
//                         } else {
//                           return null;
//                         }
//                       },
//                       onChanged: (val) {
//                         setState(() {
//                           email = val;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                           hintText: 'password',
//                           fillColor: Colors.white,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2.0),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.pink, width: 2.0),
//                             borderRadius: BorderRadius.circular(10),
//                           )),
//                       validator: (val) {
//                         if (val!.isEmpty) {
//                           return 'Password is required';
//                         } else {
//                           return null;
//                         }
//                       },
//                       onChanged: (val) {
//                         setState(() {
//                           password = val;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 20.0),

//                     // Elevated Button For Signinig In.
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             padding: EdgeInsets.all(15.0)),
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             _auth.signInWithEmailAndPassword(email, password);
//                           }
//                         },
//                         child: Text(
//                           'Sign in',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         )),
//                     Container(
//                         child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'dont have an account',
//                           style: TextStyle(
//                             color: Colors.brown,
//                             fontSize: 18.0,
//                           ),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               widget.toggleView();
//                             },
//                             child: Text(
//                               'SignUp',
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                               ),
//                             ))
//                       ],
//                     ))
//                   ],
//                 )),
//           ),
//         ));
//   }
// }

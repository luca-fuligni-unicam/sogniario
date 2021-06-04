import 'package:flutter/material.dart';
import 'package:web/models/nomination.dart';
import 'package:web/services/rest_api/login_api.dart';
import 'package:web/services/rest_api/nomination_api.dart';
import 'package:web/widgets/alert.dart';


class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController motivation = TextEditingController();
  NominationApi? nominationApi;
  LoginApi? loginApi;
  bool log = false;

  @override
  void initState() {
    nominationApi = NominationApi();
    loginApi = LoginApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 360,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                )
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                ),
                side: BorderSide(
                  color: Colors.blue.shade200,
                  width: 2,
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      children: [

                        Text(
                          'Sogniario Sign Up',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        ),

                        SizedBox(height: 5),

                        TextField(
                          decoration: InputDecoration(labelText: 'Name'),
                          controller: name,
                        ),

                        TextField(
                          decoration: InputDecoration(labelText: 'Email'),
                          controller: email,
                        ),

                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          controller: password,
                        ),

                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(labelText: 'Motivation'),
                          controller: motivation,
                        ),

                        SizedBox(height: 5),

                        TextButton(
                            onPressed: () async {
                              setState(() => log = true);
                              bool logged = await loginApi!.login({
                                'username': 'guest_researcher',
                                'password': 'guest_researcher',
                              }, false);

                              logged = await nominationApi!.registered(
                                Nomination(
                                  name: name.text,
                                  email: email.text,
                                  password: nominationApi!.sha512Encrypt(password.text),
                                  motivation: motivation.text
                                )
                              );

                              if (logged) {
                                name.clear();
                                email.clear();
                                password.clear();
                                motivation.clear();

                                setState(() => log = false);
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Alert(
                                          type: AlertDialogType.SUCCESS,
                                          content: 'Registered successfully, now you have to wait to be accepted by the admin!'
                                      );
                                    }
                                );
                              } else {
                                setState(() => log = false);
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Alert(
                                          type: AlertDialogType.ERROR,
                                          content: 'Problem with the registration!'
                                      );
                                    }
                                );
                              }

                            },
                            child: log ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
                                )) : Text('Sign Up'),
                        ),

                        SizedBox(height: 5),

                        Divider(
                          thickness: 0.7,
                          color: Colors.black54,
                          indent: 30,
                          endIndent: 30,
                        ),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Do you have an account?'),
                              SizedBox(width: 5),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Login'),
                              )
                            ])

                      ])
              ),
            ),
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:web/services/rest_api/login_api.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:web/views/auth/sign_up_page.dart';
import 'package:web/views/home.dart';
import 'package:web/widgets/alert.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';
  LoginApi loginApi = LoginApi();
  bool log = false;

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
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
                )
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
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
                          'Sogniario Login',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        ),

                        SizedBox(height: 5),

                        TextField(
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (_email) {
                            email = _email;
                          },
                        ),

                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          onChanged: (_password) {
                            password = _password;
                          },
                        ),

                        SizedBox(height: 5),

                        TextButton(
                            onPressed: () async {
                              setState(() => log = true);
                              bool logged = await loginApi.login({
                                'username': email,
                                'password': loginApi.sha512Encrypt(password),
                              }, true);


                              if (logged) {
                                setState(() => log = false);
                                Map<String, dynamic> payload = Jwt.parseJwt(loginApi.getToken().substring(7));

                                if (payload['authorities'].length < 8) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => Home(isAdmin: false)), (route) => false
                                  );
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => Home(isAdmin: true)), (route) => false
                                  );
                                }

                              } else {
                                setState(() => log = false);
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Alert(
                                          type: AlertDialogType.WARNING,
                                          content: 'Problem with the login!\n'
                                              ' - Check your username or password.\n'
                                              ' - If the username and password are correct, you wait to be accepted by the admin!'
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
                                )) : Text('Login')
                        ),

                        SizedBox(height: 5),

                        Divider(
                          thickness: 0.7,
                          color: Colors.black54,
                          indent: 30,
                          endIndent: 30,
                        ),

                        SizedBox(height: 5),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Do not have an account?'),
                              SizedBox(width: 5),
                              TextButton(
                                onPressed: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => SignUp())
                                  );
                                },
                                child: Text('Sign Up'),
                              )
                            ])

                      ]),
                )
            ),
          ),
        ),
      )
    );
  }
}

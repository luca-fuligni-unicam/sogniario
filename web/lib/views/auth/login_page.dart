import 'package:flutter/material.dart';
import 'package:web/services/routes.dart';
import 'package:web/views/auth/sign_up_page.dart';
import 'package:web/views/home.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),

                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),

                        SizedBox(height: 5),

                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.home, (route) => false
                              );
                            },
                            child: Text('Login')
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
                              Text('Non hai un account?'),
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

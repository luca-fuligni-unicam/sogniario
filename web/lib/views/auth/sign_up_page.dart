import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController motivationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    motivationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 450,
          width: 400,
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
            child: Center(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    children: [

                      Text(
                        'Sogniario\nSign Up',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),

                      SizedBox(height: 5),

                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Nome'),
                      ),

                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),

                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),

                      TextField(
                        controller: motivationController,
                        maxLines: 3,
                        decoration: InputDecoration(labelText: 'Motivazione'),
                      ),

                      SizedBox(height: 5),

                      TextButton(
                          onPressed: () {},
                          child: Text('Registrati')
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
                            Text('Hai già un account?'),
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
      ),
    );
  }
}

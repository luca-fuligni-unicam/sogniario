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
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
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
                          decoration: InputDecoration(labelText: 'Motivation'),
                        ),

                        SizedBox(height: 5),

                        TextButton(
                            onPressed: () {},
                            child: Text('Sign Up')
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

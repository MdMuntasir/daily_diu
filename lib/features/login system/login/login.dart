import 'package:diu_student/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  late TextEditingController emailController, passwordController;

  // <----- to hide keyboard ----->

  late FocusNode _focusNode; // FocusNode instance variable here

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Disposing the FocusNode instance
    // emailController.dispose();
    // passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // <----- to hide keyboard ----->

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // to hide keyboard
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo here
                FlutterLogo(size: 100),
                SizedBox(height: 20),
                // Welcome text
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Email field
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'E.g: softenge@diu.edu.bd',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(27, 95, 225, 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "E.g: softenge@diu.edu.bd",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
                          ),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Forgot password text button
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to forgot password screen
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ),
                // Login button
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(height: 10),

                // Create account button
                TextButton(
                  onPressed: () {
                    // Navigate to create account screen
                  },
                  child: Text(
                    'Don\'t Have a account? Create Account.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login()
  {

    setState(() {
      emailController.clear();
      passwordController.clear();
    });

    if(emailController.text == "admin" && passwordController.text == "admin")
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }

  }

}

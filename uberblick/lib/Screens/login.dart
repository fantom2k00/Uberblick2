import 'package:flutter/material.dart';
import '../SQFLite/users.dart';
import '../SQFLite/foods.dart';
import 'dashboard.dart';
import 'signup.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\n\nUberblick\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: "Future Solutions\n\n\n",
                      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: "Login\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const StatefulLogin(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 80, right: 80),
              child: OutlinedButton(
                child: Text('SIGN UP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  minimumSize: const Size.fromHeight(60),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup()),
                  );
                },
              ),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\nThe Problem is Big.\n",
                      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: "Our solution is small.",
                      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatefulLogin extends StatefulWidget {
  const StatefulLogin({Key key}) : super(key: key);

  @override
  State<StatefulLogin> createState() => _StatefulLogin();
}

class _StatefulLogin extends State<StatefulLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final users = Users.instance;
  final foods = Foods.instance;

  @override
  Widget build(BuildContext context) {
    const badCredentials = SnackBar(
      content: Text("Oops, wrong credentials. Retry or sign up to Uberblick!"),
    );

    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Email',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child:OutlinedButton(
                child: Text('Login', style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.secondary)),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    backgroundColor: const Color.fromRGBO(0x81, 0xB2, 0x9A, 1),
                    minimumSize: const Size.fromHeight(55)
                ),
                onPressed: () async {
                  List<Map> userList = await users.getUsers();
                  for (var i = 0; i < userList.length; i++) {
                    if(userList[i]['email'].toString().toLowerCase() == emailController.text.toLowerCase()) {
                      if(userList[i]['password'] == passwordController.text) {
                        await foods.addFood();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(userList[i])),
                        );
                      }
                      break;
                    }
                    if(i == userList.length - 1) {
                      ScaffoldMessenger.of(context).showSnackBar(badCredentials);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
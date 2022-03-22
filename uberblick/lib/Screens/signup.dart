import 'package:flutter/material.dart';
import '../SQFLite/users.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'login.dart';
import '../Models/user.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatelessWidget {
  const Signup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).primaryColor,
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
                      text: "Sign Up\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const StatefulSignup(),
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

class StatefulSignup extends StatefulWidget {
  const StatefulSignup({Key key}) : super(key: key);

  @override
  State<StatefulSignup> createState() => _StatefulSignup();
}

class _StatefulSignup extends State<StatefulSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  String countryController = 'Antarctica';
  TextEditingController birthyearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                controller: emailController,
                validator: (value) {
                  if (!EmailValidator.validate(value)) {
                    return 'Incorrect email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Email',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                validator: (value) {
                  RegExp rgx = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');
                  if (!rgx.hasMatch(value)) {
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return 'Must contain numbers, capital and lowercase letters';
                  }
                  return null;
                },
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Nickname may not be empty';
                  }
                  return null;
                },
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                controller: nicknameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Nickname',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(22)),
                        color: Theme.of(context).primaryColor,
                      ),

                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          title: Text('Nationality', style: TextStyle(color: Theme.of(context).primaryColor),),
                        ),

                        theme: CountryTheme(
                          isShowFlag: false,
                          isShowTitle: true,
                          isShowCode: false,
                          isDownIcon: true,
                          showEnglishName: true,

                        ),

                        initialSelection: '+672',
                        onChanged: (CountryCode code) {
                          countryController = code.name;
                        },
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      controller: birthyearController,
                      validator: (value) {
                        if (int.tryParse(value) != null) {
                          if(int.parse(value) < 1900 || int.parse(value) > 2022) {
                            return 'Invalid year';
                          }
                        } else {
                          return 'Invalid year';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).primaryColor,
                        hintText: 'Birthyear',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(left: 80, right: 80),
              child: TextButton(
                child: const Text('SIGN UP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  primary: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  minimumSize: const Size.fromHeight(60),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    User newUser = User(
                      email: emailController.text.toLowerCase(),
                      password: passwordController.text,
                      nickname: nicknameController.text,
                      country: countryController,
                      birthyear: int.parse(birthyearController.text),
                    );
                    Users.instance.addUser( newUser.getUser() );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/login.dart';
import 'SQFLite/users.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Uberblick',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        brightness: Brightness.light,
        primaryColor: const Color.fromRGBO(0xF4, 0xF1, 0xDE, 1.0),
        scaffoldBackgroundColor: const Color.fromRGBO(0xF4, 0xF1, 0xDE, 1.0),
        colorScheme: theme.colorScheme.copyWith(
          secondary: const Color.fromRGBO(0x3D, 0x40, 0x5B, 1.0),
          tertiary:const Color.fromRGBO(0xF2, 0xCC, 0x8F, 1.0),
        ),

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final users = Users.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(80)),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Uberblick\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: "Future Solutions\n",
                      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\n\nWelcome to Uberblick\n\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).colorScheme.secondary),
                    ),
                    TextSpan(
                      text: "Your search for transparency ends here.\nRelevant metrics - customised.\nPowered by A.I.\n\n\n",
                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 80, right: 80),
                alignment: Alignment.center,
                child:OutlinedButton.icon(
                  label: const Text('     Login     ', style: TextStyle(fontSize: 18)),
                  icon: const Icon(Icons.arrow_forward),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: const Size.fromHeight(50)
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                ),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

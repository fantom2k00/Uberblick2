import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scanner.dart';
import 'scan_list.dart';
import 'login.dart';
import 'history_list.dart';
import '../SQFLite/foods.dart';
import '../SQFLite/scans.dart';
import '../SQFLite/receipts.dart';

class Dashboard extends StatelessWidget {
  final Map<String, dynamic> user;
  const Dashboard(this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const emptyScans = SnackBar(
      content: Text("You don't have any saved scans yet. Blick some products first!"),
    );
    const openHelp = SnackBar(
      content: Text("Swipe down to open the scanner. Afterwards, new scans will appear in the 'Saved scans' section."),
    );

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onVerticalDragEnd: (dragEndDetails) async {
        if (dragEndDetails.primaryVelocity > 0) {
          final foods = Foods.instance;
          foods.deleteFoods();
          await foods.addFood();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scanner(user)),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          leading: IconButton(
            icon: const Icon(Icons.help_outline_outlined),
            color: Theme.of(context).primaryColor,
            iconSize: 40,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(openHelp);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 80, right: 80),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 140, bottom: 80),
                        child: TextButton(
                          child: Text('Scanner', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 40))),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: Theme.of(context).primaryColor,
                            elevation: 0,
                          ),
                          onPressed: () async {
                            final foods = Foods.instance;
                            foods.deleteFoods();
                            await foods.addFood();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Scanner(user)),
                            );
                          },
                        ),
                      ),
                    ),

                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Card(
                            child: SizedBox(
                              width: 150.0,
                              height: 50.0,
                              child: OutlinedButton(
                                child: Text('Saved Scans', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
                                style: TextButton.styleFrom(
                                   backgroundColor: Theme.of(context).colorScheme.tertiary,
                                ),
                                onPressed: () async {
                                  final scans = Scans.instance;
                                  try {
                                    List<Map<String, dynamic>> scanList = await scans.getScans(user['user_id']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ScanList(scanList, user)),
                                    );
                                  } catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(emptyScans);
                                  }
                                },
                              ),
                            ),
                          ),

                          Card(
                            child: SizedBox(
                              width: 150.0,
                              height: 50.0,
                              child: OutlinedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                                ),
                                child: Text('History', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
                                onPressed: () async {
                                  final receipts = Receipts.instance;
                                  try {
                                    List<Map<String, dynamic>> receiptList = await receipts.getReceipts(user['user_id']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ReceiptList(receiptList, user)),
                                    );
                                  } catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(emptyScans);
                                  }
                                },
                              ),
                            ),
                          ),

                          Card(
                            child: SizedBox(
                              width: 150.0,
                              height: 50.0,
                              child: OutlinedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                                ),
                                child: Text('Settings', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
                                onPressed: () {},
                              ),
                            ),
                          ),

                          Card(
                            child: SizedBox(
                              width: 150.0,
                              height: 50.0,
                              child: OutlinedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                                ),
                                child: Text('Logout', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      const Login()), (Route<dynamic> route) => false);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Image(image: AssetImage('assets/images/dashboard_score.png')),
              iconSize: 320,
              onPressed: () {

              },
            )
          ],
        ),
      ),
    );
  }
}
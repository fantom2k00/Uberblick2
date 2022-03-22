import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:device_apps/device_apps.dart';
import 'package:uberblick/Models/receipt.dart';
import 'product_facts.dart';
import '../SQFLite/foods.dart';
import '../SQFLite/scans.dart';
import '../SQFLite/receipts.dart';
import '../Models/scan.dart';
import '../Models/receipt.dart';
import 'package:google_fonts/google_fonts.dart';

class Scanner extends StatefulWidget {
  final Map<String, dynamic> user;
  const Scanner(this.user, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey();
  Map<String, dynamic> food = {'food_id': null};
  List<String> items = [];
  Barcode result;
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Scanner', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 36), color: Theme.of(context).colorScheme.secondary)),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).colorScheme.secondary,
            iconSize: 36,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: _buildQrView(context)
              ),
              Expanded(
                  flex: 1,
                  child: Container()
              )
            ],
          ),

          Visibility(
            visible: food['food_id'] != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 120, right: 120, bottom: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromRGBO(190, 190, 190, 1),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: "\nNutriscore: ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromRGBO(60, 60, 60, 1)),
                        ),
                        TextSpan(
                          text: "${food['nutriscore']}\n",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                        ),
                        const TextSpan(
                          text: "CO2: ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromRGBO(60, 60, 60, 1)),
                        ),
                        TextSpan(
                          text: "${food['kg_co2_eq']}kg/${food['unit']}\n",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
                  alignment: Alignment.center,
                  child:TextButton(
                      child: const Text('See more?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromRGBO(60, 60, 60, 1))),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      primary: const Color.fromRGBO(26, 83, 255, 1.0),
                      backgroundColor: const Color.fromRGBO(128, 255, 170, 1),
                      minimumSize: const Size.fromHeight(80)
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductFacts(food)),
                      );
                    },
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 10, color: Color.fromRGBO(220, 220, 220, 1), spreadRadius: 15)],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.pink,
                    child: IconButton(
                      icon: const Icon(Icons.add_rounded),
                      iconSize: 60,
                      color: Colors.white,
                      onPressed: () async {
                        final scans = Scans.instance;

                        Scan newScan = Scan(
                          userId: widget.user['user_id'],
                          foodId: food['food_id'],
                          dateTime: DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()),
                          location: 'Leuven, Belgium',
                        );

                        await scans.addScan( newScan.getScan() );
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Visibility(
            visible: items.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.pink,
                child: IconButton(
                  icon: const Icon(Icons.payments_rounded),
                  iconSize: 60,
                  color: Colors.white,
                  onPressed: () async {
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.flash_on, color: Theme.of(context).colorScheme.secondary,),
        onPressed: () async {
          await controller?.toggleFlash();
          setState(() {});
        },
      ),
    );
  }

  _openPopup(context, String foods) {
    controller.pauseCamera();
    Alert(
      context: context,
      title: 'Payment',
      content: const Text('Would you like to pay?'),
      buttons: [
        DialogButton(
          child: const Text("No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            controller.resumeCamera();
            items = [];
          },
        ),

        DialogButton(
          child: const Text("Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            final receipts = Receipts.instance;
            Receipt newReceipt = Receipt(
              userId: widget.user['user_id'],
              foodIds: foods,
              dateTime: DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()),
              location: 'Leuven, Belgium',
            );
            await receipts.addReceipt( newReceipt.getReceipt() );
            Navigator.pop(context);
            Navigator.pop(context);
            DeviceApps.openApp('com.ing.banking');
          }
        )
      ]
    ).show();
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    final foods = Foods.instance;
    final List<Map> foodList = await foods.getFoods();

    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        final split = result.code.split(' ');
        if(split[0] == 'uberblick_app_identifier') {
          food = foodList[int.parse(split[1])];
        } else if (split[0] == 'uberblick_shop_identifier') {
          _openPopup(context, split[1]);
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
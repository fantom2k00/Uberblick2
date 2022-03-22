import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_facts.dart';

class ReceiptInfo extends StatelessWidget {
  final Map<String, dynamic> receipt;
  final List<Map<String, dynamic>> foodList;
  const ReceiptInfo(this.receipt, this.foodList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Scan #${receipt['receipt_id']}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 36), color: Theme.of(context).colorScheme.secondary)),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 30),
            height: 10,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Icon(
            Icons.qr_code,
            color: Theme.of(context).colorScheme.secondary,
            size: 300,
          ),
          Text('Shopping Details', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 30), color: Theme.of(context).colorScheme.secondary)),
          Container(
            margin: const EdgeInsets.only(top: 6, right: 50, left: 50),
            height: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text('\nDate: ${receipt['date_time'].split(' ')[0]}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Time: ${receipt['date_time'].split(' ')[1]}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Location: ${receipt['location']}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),

          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Container(
              alignment: Alignment.center,
              child:OutlinedButton(
                child: Text('See More...', style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.secondary)),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: const Size.fromHeight(55)
                ),
                onPressed: () async {

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
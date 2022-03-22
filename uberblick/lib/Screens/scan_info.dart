import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_facts.dart';

class ScanInfo extends StatelessWidget {
  final Map<String, dynamic> scan;
  final Map<String, dynamic> food;
  const ScanInfo(this.scan, this.food, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Scan #${scan['scan_id']}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 36), color: Theme.of(context).colorScheme.secondary)),
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
          Text('${food['food']}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 30), color: Theme.of(context).colorScheme.secondary)),
          Container(
            margin: const EdgeInsets.only(top: 6, right: 50, left: 50),
            height: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text('\nDate: ${scan['date_time'].split(' ')[0]}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Time: ${scan['date_time'].split(' ')[1]}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Location: ${scan['location']}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),

          Text('\nNutriscore: ${food['nutriscore']}', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('CO2 Emitted: ${(food['kg_co2_eq'] * food['quantity']).toStringAsFixed(2)}kg', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Water Used: ${(food['water_use'] * food['quantity']).toStringAsFixed(2)}l', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
          Text('Land Used: ${(food['land_use'] * food['quantity']).toStringAsFixed(2)}m²\n\n', style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductFacts(food)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
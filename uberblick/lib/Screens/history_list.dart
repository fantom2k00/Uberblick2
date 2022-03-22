import 'package:flutter/material.dart';
import '../SQFLite/receipts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'receipt_info.dart';
import '../SQFLite/foods.dart';

class ReceiptList extends StatelessWidget {
  final List<Map<String, dynamic>> receipts;
  final Map<String, dynamic> user;
  const ReceiptList(this.receipts, this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Shopping History', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 36), color: Theme.of(context).colorScheme.secondary)),
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
            margin: const EdgeInsets.only(top: 6, right: 50, bottom: 20),
            height: 10,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(
            flex: 1,
            child: StatefulScanList(receipts, user)
          ),
        ],
      ),
    );
  }
}

class StatefulScanList extends StatefulWidget {
  final List<Map<String, dynamic>> receipts;
  final Map<String, dynamic> user;
  const StatefulScanList(this.receipts, this.user, {Key key}) : super(key: key);

  @override
  State<StatefulScanList> createState() => _StatefulScanList();
}

class _StatefulScanList extends State<StatefulScanList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.receipts.length,
      itemBuilder: (context, index) => Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: ListTile(
            onTap: () async {
              final foods = Foods.instance;
              final foodIds = widget.receipts[index]['food_ids'].split(',');
              List<Map<String, dynamic>> foodList = [];
              for (var i = 1; i < foodIds.length; i++) {
                foodList.add(await foods.getFood(i));
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReceiptInfo(widget.receipts[index], foodList)),
              );
            },
            leading: Icon(Icons.qr_code, size: 60, color: Theme.of(context).primaryColor,),
            title: Text('Scan #${widget.receipts[index]['receipt_id'].toString()}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).primaryColor)),
            subtitle: Text('${widget.receipts[index]['date_time'].toString().split(' ')[0]}\n${widget.receipts[index]['date_time'].toString().split(' ')[1]}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 14), color: Theme.of(context).primaryColor)),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outlined, size: 35),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                final receipts = Receipts.instance;
                receipts.deleteReceipt(widget.receipts[index]['receipt_id'], widget.user['user_id']);
                List<Map<String, dynamic>> receiptList = await receipts.getReceipts(widget.receipts[0]['user_id']);
                setState(() {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiptList(receiptList, widget.user)),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
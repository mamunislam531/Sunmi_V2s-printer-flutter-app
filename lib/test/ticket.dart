import 'package:flutter/material.dart';
 import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class TicketCounterApp extends StatefulWidget {
  @override
  _TicketCounterAppState createState() => _TicketCounterAppState();
}

class _TicketCounterAppState extends State<TicketCounterApp> {
  String? _selectedStart;
  String? _selectedDestination;

  final List<String> _locations = ['Point A', 'Point B', 'Point C', 'Point D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Counter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedStart,
              hint: Text('Select Start Point'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStart = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDestination,
              hint: Text('Select Destination Point'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDestination = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _printTicket,
              child: Text('Print Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  void _printTicket() {
    if (_selectedStart != null && _selectedDestination != null) {
      _printInvoice(_selectedStart!, _selectedDestination!);
    } else {
      // Show error if either start or destination is not selected
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select both start and destination points'),
      ));
    }
  }

  Future<void> _printInvoice(String start, String destination) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

    await SunmiPrinter.printText('Ticket Invoice');
    await SunmiPrinter.lineWrap(1);
     await SunmiPrinter.printText('Start Point: $start');
    await SunmiPrinter.printText('Destination Point: $destination');
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.exitTransactionPrint(true);
  }
}

import 'package:ble_provider/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectedPage extends StatelessWidget {
  const ConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bleProvider = Provider.of<BleProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Connected"),
          centerTitle: true,
        ),
        body: Center(
          child: bleProvider.recievedData.isEmpty
              ? const CircularProgressIndicator()
              : Text("Recieved Data: ${bleProvider.recievedData}"),
        ));
  }
}

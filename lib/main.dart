import 'package:ble_provider/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // NavigationService service = NavigationService.Na;
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => BleProvider(),
      child: const MaterialApp(
        title: 'Flutter BLE Demo',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bleProvider = Provider.of<BleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLE Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 140,
              onPressed: () {
                bleProvider.scan(context);
              },
              icon: bleProvider.connectedDevicesList.isEmpty
                  ? const Icon(Icons.bluetooth_disabled)
                  : const Icon(Icons.bluetooth_connected),
            ),
          ],
        ),
      ),
    );
  }
}

class TurnOnBluetooth extends StatelessWidget {
  const TurnOnBluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLE Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Turn On Bluetooth"),
        ),
      ),
    );
  }
}

import 'package:ble_provider/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bleProvider = Provider.of<BleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Found ${bleProvider.foundDevices.length} Devices"),
      ),
      body: ListView.builder(
        itemCount: bleProvider.foundDevices.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.devices),
            title: Text(bleProvider.foundDevices[index].name),
            subtitle: Text("${bleProvider.foundDevices[index].id}"),
            trailing: bleProvider.connectedDevicesList
                    .contains(bleProvider.foundDevices[index])
                ? ElevatedButton(
                    onPressed: () {
                      bleProvider.disconnect(bleProvider.foundDevices[index]);
                    },
                    child: const Text("Disconnect"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      bleProvider.connect(
                          context, bleProvider.foundDevices[index]);
                    },
                    child: const Text("Connect"),
                  ),
          );
        },
      ),
    );
  }
}

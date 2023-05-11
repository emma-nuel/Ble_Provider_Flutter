import 'dart:async';
import 'package:ble_provider/connected.dart';
import 'package:ble_provider/scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

class BleProvider extends ChangeNotifier {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  late BluetoothDevice device;
  late StreamSubscription<ScanResult> scanSubscription;
  List recievedData = [];
  List<BluetoothDevice> foundDevices = [];
  List<BluetoothDevice> connectedDevicesList = [];

  // bool bluetoothOn() => flutterBlue.isOn;

  void scan(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const ScanPage()),
      ),
    );
    connectedDevicesList = await flutterBlue.connectedDevices;
    flutterBlue.startScan(timeout: const Duration(seconds: 10));
    flutterBlue.scanResults.listen((results) {
      foundDevices = [];
      for (ScanResult result in results) {
        foundDevices.add(result.device);
      }
      notifyListeners();
    });
  }

  void connect(BuildContext context, BluetoothDevice device) async {
    flutterBlue.stopScan();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const ConnectedPage()),
      ),
    );
    connectedDevicesList = await flutterBlue.connectedDevices;

    if (connectedDevicesList.isEmpty) {
      device.connect().then((_) {
        device.discoverServices().then((services) {
          for (var service in services) {
            if (service.uuid.toString() == serviceUuid) {
              for (var characteristic in service.characteristics) {
                if (characteristic.uuid.toString() == characteristicUuid) {
                  characteristic.read().then((value) async {
                    recievedData = String.fromCharCodes(value).split(',');
                    connectedDevicesList = await flutterBlue.connectedDevices;
                    notifyListeners();
                  });
                }
              }
            }
          }
        });
      });
    } else {
      device.discoverServices().then((services) {
        for (var service in services) {
          if (service.uuid.toString() == serviceUuid) {
            for (var characteristic in service.characteristics) {
              if (characteristic.uuid.toString() == characteristicUuid) {
                characteristic.read().then((value) async {
                  recievedData = String.fromCharCodes(value).split(',');
                  connectedDevicesList = await flutterBlue.connectedDevices;
                  notifyListeners();
                });
              }
            }
          }
        }
      });
    }
  }

  void disconnect(BluetoothDevice device) async {
    await device.disconnect();
    connectedDevicesList = [];
    notifyListeners();
    // print(connectedDevicesList);
  }
}

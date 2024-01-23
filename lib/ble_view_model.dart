
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
enum MyConnectionState {
  connecting,
  connected,
  disconnecting,
  disconnected
}
enum DeviceState {
  idle,
  tempLoop1,
  tempLoop2,
  done
}
class BleViewModel with ChangeNotifier{

  var connectionStatus = MyConnectionState.disconnected;
  // final flutterReactiveBle = FlutterReactiveBle();
  // late StreamSubscription<DiscoveredDevice> _scanStream;
  // late StreamSubscription<ConnectionStateUpdate> _connection;
  // late QualifiedCharacteristic _txCharacteristic;
  // late QualifiedCharacteristic _rxCharacteristic;
  // late Stream<List<int>> _receivedDataStream;
  final devices = <DiscoveredDevice>[];
  void addDevice(DiscoveredDevice device) {
    devices.add(device);
    notifyListeners();
  }
  void updateDevices(List<DiscoveredDevice> newDevices) {
    devices.clear();
    devices.addAll(newDevices);
    notifyListeners();
  }

  void cleanDevices() {
    devices.clear();
    notifyListeners();
  }
  void updateDevice(DiscoveredDevice device) {
    final index = devices.indexWhere((element) => element.id == device.id);
    if (index != -1) {
      devices[index] = device;
    }else{
      addDevice(device);
    }
    notifyListeners();
  }

  void updateConnectionStatus(MyConnectionState status) {
    connectionStatus = status;
    notifyListeners();
  }

}
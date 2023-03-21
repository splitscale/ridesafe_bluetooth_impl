import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ridesafe_core/connected_device/connected_device.dart';
import 'package:ridesafe_core/exceptions/service_exception.dart';
import 'package:ridesafe_core/services/connected_device_service.dart';

class BluetoothConnectedDeviceService implements ConnectedDeviceService {
  final ConnectedDevice<BluetoothConnection> _device;

  BluetoothConnectedDeviceService(this._device);

  @override
  Future<void> disconnect() {
    try {
      return _device.connection.finish();
    } catch (e) {
      throw ServiceException('disconnecting the device Failed: $e');
    }
  }

  @override
  bool get isConnected {
    try {
      return _device.connection.isConnected;
    } catch (e) {
      throw ServiceException('get connection status Failed: $e');
    }
  }

  @override
  Future<void> send(String json) {
    try {
      String data = jsonEncode(json);

      if (data.isEmpty) throw ServiceException('Message is empty.');

      _device.connection.output.add(Uint8List.fromList(ascii.encode(data)));

      return _device.connection.output.allSent;
    } catch (e) {
      throw ServiceException('Failed to send message: $e');
    }
  }

  @override
  Stream<String> startListening() {
    try {
      return _device.connection.input!.map(ascii.decode);
    } catch (e) {
      throw ServiceException(
          'listening to device data stream starting Failed: $e');
    }
  }

  @override
  Future<void> stopListening() {
    try {
      return _device.connection.close();
    } catch (e) {
      throw ServiceException(
          'listening to device data stream stopping Failed: $e');
    }
  }
}

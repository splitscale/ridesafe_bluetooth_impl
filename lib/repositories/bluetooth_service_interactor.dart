import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ridesafe_core/device/device.dart';
import 'package:ridesafe_core/connected_device/connected_device.dart';
import 'package:ridesafe_core/exceptions/service_exception.dart';
import 'package:ridesafe_core/services/device_service.dart';

/// bluetooth specific implementation
class BluetoothServiceInteractor
    implements DeviceService<Future<BluetoothState>, BluetoothConnection> {
  final FlutterBluetoothSerial _serial;

  BluetoothServiceInteractor(this._serial);

  @override
  Future<ConnectedDevice<BluetoothConnection>> connect(Device device) async {
    try {
      final BluetoothConnection conn =
          await BluetoothConnection.toAddress(device.address);

      return ConnectedDevice.fromDevice(device, conn);
    } catch (e) {
      throw ServiceException('Error while connecting the device: $e');
    }
  }

  @override
  Future<List<Device>> getPairedDevices() async {
    try {
      List<BluetoothDevice> devices = await _serial.getBondedDevices();

      return devices
          .map((e) => Device(
                e.name.toString(),
                e.address.toString(),
              ))
          .toList();
    } catch (e) {
      throw ServiceException('Error while getting paired devices: $e');
    }
  }

  @override
  Future<BluetoothState> getServiceState() async {
    try {
      return _serial.state;
    } catch (e) {
      throw ServiceException('Error while getting service state: $e');
    }
  }

  @override
  Future<bool> isPaired(Device device) async {
    try {
      final BluetoothBondState state =
          await _serial.getBondStateForAddress(device.address);

      return state.isBonded;
    } catch (e) {
      throw ServiceException('Error while getting paired state: $e');
    }
  }

  @override
  Future<bool> isServiceAvailable() async {
    try {
      return await _serial.isAvailable ?? false;
    } catch (e) {
      throw ServiceException('Failed to get service available state: $e');
    }
  }

  @override
  Future<bool> isServiceEnabled() async {
    try {
      return await _serial.isEnabled ?? false;
    } catch (e) {
      throw ServiceException('Failed to get service enabled state: $e');
    }
  }

  @override
  Future<bool> pair(Device device, String pin) async {
    try {
      return await _serial.bondDeviceAtAddress(device.address, pin: pin) ??
          false;
    } catch (e) {
      throw ServiceException('Failed pairing attempt: $e');
    }
  }

  @override
  Stream<Device> startScanning() {
    try {
      return _serial.startDiscovery().map((e) => Device(
            e.device.name.toString(),
            e.device.address.toString(),
          ));
    } catch (e) {
      throw ServiceException('Failed to start scan: $e');
    }
  }

  @override
  Future<void> stopScanning() {
    try {
      return _serial.cancelDiscovery();
    } catch (e) {
      throw ServiceException('Failed stop scan: $e');
    }
  }

  @override
  Future<void> enableService() {
    try {
      return _serial.requestEnable();
    } catch (e) {
      throw ServiceException('Failed to enable service: $e');
    }
  }

  @override
  Future<void> openInternalSettings() {
    try {
      return _serial.openSettings();
    } catch (e) {
      throw ServiceException('Failed failed to open device settings: $e');
    }
  }
}

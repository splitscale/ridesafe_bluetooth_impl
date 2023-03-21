import 'package:ridesafe_core/device/device.dart';
import 'package:ridesafe_core/connected_device/connected_device.dart';
import 'package:ridesafe_core/services/device_service.dart';
import 'package:ridesafe_core/services/state/service_state.dart';

/// bluetooth specific implementation
// TODO: implement bluetooth serial
class BluetoothServiceInteractor implements DeviceService {
  @override
  Future<ConnectedDevice> connect(String deviceMacAddress) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<List<Device>> getPairedDevices() {
    // TODO: implement getPairedDevices
    throw UnimplementedError();
  }

  @override
  Future<ServiceStatus> getServiceState() {
    // TODO: implement getServiceState
    throw UnimplementedError();
  }

  @override
  Future<bool> isPaired(String deviceMacAddress) {
    // TODO: implement isPaired
    throw UnimplementedError();
  }

  @override
  Future<bool> isServiceAvailable() {
    // TODO: implement isServiceAvailable
    throw UnimplementedError();
  }

  @override
  Future<bool> isServiceEnabled() {
    // TODO: implement isServiceEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool> pair(String deviceMacAddress, String pin) {
    // TODO: implement pair
    throw UnimplementedError();
  }

  @override
  Stream<Device> startScanning() {
    // TODO: implement startScanning
    throw UnimplementedError();
  }

  @override
  Future<void> stopScanning() {
    // TODO: implement stopScanning
    throw UnimplementedError();
  }
}

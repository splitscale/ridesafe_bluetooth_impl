import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ridesafe_bluetooth_impl/repositories/bluetooth_service_interactor.dart';

class BluetoothService {
  final BluetoothServiceInteractor _interactor;

  BluetoothService()
      : _interactor = BluetoothServiceInteractor(
          FlutterBluetoothSerial.instance,
        );

  BluetoothServiceInteractor get service => _interactor;
}

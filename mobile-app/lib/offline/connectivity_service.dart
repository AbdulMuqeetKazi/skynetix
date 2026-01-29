import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get isOnline async* {
    await for (final result in _connectivity.onConnectivityChanged) {
      if (result == ConnectivityResult.none) {
        yield false;
      } else {
        yield true;
      }
    }
  }
}

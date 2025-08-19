import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final InternetConnection _internetConnection;
  late StreamSubscription _subscription;

  ConnectivityCubit(this._internetConnection)
    : super(ConnectivityStatus.connected) {
    _subscription = _internetConnection.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        emit(ConnectivityStatus.connected);
      } else {
        emit(ConnectivityStatus.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

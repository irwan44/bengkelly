import 'dart:io'; // Import dart:io for Platform
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';

enum UpdateStatus { checking, available, notAvailable, error }

class UpdateBloc extends Bloc<dynamic, UpdateStatus> {
  UpdateBloc() : super(UpdateStatus.checking);

  @override
  Stream<UpdateStatus> mapEventToState(event) async* {
    if (event == 'check_for_update') {
      yield* _mapCheckForUpdateToState();
    }
  }

  Stream<UpdateStatus> _mapCheckForUpdateToState() async* {
    yield UpdateStatus.checking;

    final packageInfo = (Platform.isAndroid)
        ? await PackageInfo.fromPlatform()
        : PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
    );
    final currentVersion = packageInfo.version;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.flexibleUpdateAllowed) {
        final latestVersion = updateInfo.availableVersionCode.toString();
        if (currentVersion != latestVersion) {
          yield UpdateStatus.available;
        } else {
          yield UpdateStatus.notAvailable;
        }
      } else {
        yield UpdateStatus.notAvailable;
      }
    } catch (e) {
      yield UpdateStatus.error;
      print('Error checking for updates: $e');
    }
  }

  void performImmediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }
}

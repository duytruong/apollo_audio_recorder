import 'package:simple_permissions/simple_permissions.dart';

class PermissionRequest {

  static Future<bool> handleRecordAudioPermission() async {
    await _testPlatformVersion();
    bool result = false;
    if (await SimplePermissions.getPermissionStatus(Permission.RecordAudio) !=
        PermissionStatus.authorized) {
      PermissionStatus recordAudioPermissionStatus =
          await SimplePermissions.requestPermission(Permission.RecordAudio);
      result = recordAudioPermissionStatus == PermissionStatus.authorized;
    } else
      result = true;
    return result;
  }

  static Future<bool> handleWriteExternalStoragePermission() async {
    await _testPlatformVersion();
    bool result = false;
    if (await SimplePermissions.getPermissionStatus(
        Permission.WriteExternalStorage) !=
        PermissionStatus.authorized) {
      PermissionStatus writeExternalStoragePermissionStatus =
      await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      result =
          writeExternalStoragePermissionStatus == PermissionStatus.authorized;
    } else
      result = true;
    return result;
  }

  static Future<bool> handleReadExternalStoragePermission() async {
    await _testPlatformVersion();
    bool result = false;
    if (await SimplePermissions.getPermissionStatus(
        Permission.ReadExternalStorage) !=
        PermissionStatus.authorized) {
      PermissionStatus writeExternalStoragePermissionStatus =
      await SimplePermissions.requestPermission(
          Permission.ReadExternalStorage);
      result =
          writeExternalStoragePermissionStatus == PermissionStatus.authorized;
    } else
      result = true;
    return result;
  }

  static Future _testPlatformVersion() async =>
      await SimplePermissions.platformVersion;
}

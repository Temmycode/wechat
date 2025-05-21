import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> initializePermissions() async {
    requestContactPermission();
  }

  static Future<bool> requestImagePermissions() async {
    var storageStatus = await Permission.storage.status;
    var photoStatus = await Permission.photos.status;

    if (!storageStatus.isGranted && !photoStatus.isGranted) {
      final statuses = await [Permission.storage, Permission.photos].request();

      return statuses[Permission.storage]!.isGranted ||
          statuses[Permission.photos]!.isGranted;
    }

    return storageStatus.isGranted || photoStatus.isGranted;
  }

  static Future<bool> requestCameraPermissions() async {
    var cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      final status = await Permission.camera.request();
      return status.isGranted;
    }

    return cameraStatus.isGranted;
  }

  static Future<PermissionStatus> requestContactPermission() async {
    // Check current status
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      print('is granting request');

      // Request permission
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      print('is granted / permanently denied');
      return permission;
    }
  }
}

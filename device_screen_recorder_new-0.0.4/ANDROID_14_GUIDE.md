# Android 14+ Compatibility Guide

## MediaProjection Foreground Service Requirement

Starting from Android 14 (API level 34), the MediaProjection API requires:
1. A foreground service with the type `FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION`
2. The `FOREGROUND_SERVICE_MEDIA_PROJECTION` permission

This plugin has been updated to handle these requirements automatically.

## What was changed

1. **Added Required Permissions**: 
   - `android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION`

2. **Service Configuration**: The HBRecorder's `ScreenRecordService` is now properly declared in the AndroidManifest.xml with:
   - `android:foregroundServiceType="mediaProjection"`
   - Proper service attributes for Android 14+ compatibility

3. **Automatic Integration**: Apps using this plugin will automatically inherit the correct service configuration.

## Technical Details

The fix involves:
- Adding the `FOREGROUND_SERVICE_MEDIA_PROJECTION` permission to both the plugin and example app manifests
- Declaring the `com.hbisoft.hbrecorder.ScreenRecordService` with the correct `foregroundServiceType`
- Ensuring the service is properly configured for media projection operations

## Build Configuration

The plugin now targets Android API level 34 to ensure compatibility with the latest Android features and requirements.

## Manifest Configuration

### Plugin Manifest (`android/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION" />

<application>
    <service 
        android:name="com.hbisoft.hbrecorder.ScreenRecordService"
        android:foregroundServiceType="mediaProjection"
        android:enabled="true"
        android:exported="false" />
</application>
```

### App Integration
Apps using this plugin should include the permission in their `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION" />
```

## Error Resolution

This update resolves the following errors that occurred on Android 14+:
```
java.lang.IllegalStateException: Must register a callback before starting capture, to manage resources in response to MediaProjection states.
```
```
java.lang.SecurityException: Media projections require a foreground service of type ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION
```
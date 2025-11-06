## 0.0.6

* Fix Android 14+ compatibility issue with MediaProjection foreground service requirement
* Add FOREGROUND_SERVICE_MEDIA_PROJECTION permission for Android 14+ support
* Configure HBRecorder service with proper foregroundServiceType for media projection
* Update compileSdkVersion to 34 for Android 14+ support
* Maintain backward compatibility with older Android versions
* Add comprehensive Android 14 compatibility guide

## 0.0.5

* Cache screen recording permission to avoid asking multiple times
* Default to entire screen recording without user interaction after first permission grant
* Add method to clear permission cache if needed

## 0.0.4

* Upgrade HBRecorder version

## 0.0.3

* Fixed return result on screen recording

## 0.0.2

* Updated Android dependencies

## 0.0.1

* Android screen recording.

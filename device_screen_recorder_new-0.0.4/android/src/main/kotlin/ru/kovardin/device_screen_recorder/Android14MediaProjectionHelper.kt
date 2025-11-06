package ru.kovardin.device_screen_recorder

import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.util.Log

class Android14MediaProjectionHelper {
    
    companion object {
        private const val TAG = "Android14MediaProjectionHelper"
        
        /**
         * Creates a MediaProjection with proper callback registration for Android 14+
         */
        fun createMediaProjection(
            context: Context,
            resultCode: Int,
            data: Intent,
            callback: MediaProjection.Callback? = null
        ): MediaProjection? {
            return try {
                val mediaProjectionManager = context.getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
                val mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)
                
                // Register callback for Android 14+ to handle MediaProjection state changes
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { // API 34 (Android 14)
                    val projectionCallback = callback ?: object : MediaProjection.Callback() {
                        override fun onStop() {
                            super.onStop()
                            Log.d(TAG, "MediaProjection stopped")
                        }
                        
                        override fun onCapturedContentResize(width: Int, height: Int) {
                            super.onCapturedContentResize(width, height)
                            Log.d(TAG, "MediaProjection content resized: ${width}x${height}")
                        }
                        
                        override fun onCapturedContentVisibilityChanged(isVisible: Boolean) {
                            super.onCapturedContentVisibilityChanged(isVisible)
                            Log.d(TAG, "MediaProjection content visibility changed: $isVisible")
                        }
                    }
                    
                    // Register the callback before any virtual display creation
                    mediaProjection?.registerCallback(projectionCallback, null)
                    Log.d(TAG, "MediaProjection callback registered for Android 14+")
                }
                
                mediaProjection
            } catch (e: Exception) {
                Log.e(TAG, "Failed to create MediaProjection: ${e.message}", e)
                null
            }
        }
        
        /**
         * Safely unregisters callback and stops MediaProjection
         */
        fun stopMediaProjection(mediaProjection: MediaProjection?, callback: MediaProjection.Callback?) {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE && callback != null) {
                    mediaProjection?.unregisterCallback(callback)
                    Log.d(TAG, "MediaProjection callback unregistered")
                }
                mediaProjection?.stop()
                Log.d(TAG, "MediaProjection stopped")
            } catch (e: Exception) {
                Log.e(TAG, "Error stopping MediaProjection: ${e.message}", e)
            }
        }
    }
}
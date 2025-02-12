package com.example.sleepcyclesapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANEEL_OVERLAY_SCREEN = "com.example.sleepcyclesapp/overlay_lock_screen"
    private val CHANNEL_SCREENWAKEUP = "com.example.sleepcyclesapp/screen_wakeup"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize the MethodChannels

        // 1
        overLockScreenChanel(flutterEngine)
        // 2
        screenWakeUpChanel(flutterEngine)

    }

    private fun overLockScreenChanel(flutterEngine: FlutterEngine){
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANEEL_OVERLAY_SCREEN).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "enableOverlayScreen" -> {
                    OverLockScreen().enableShowWhenLocked(window)
                    result.success(null)
                }
                "disableOverlayScreen" -> {
                    OverLockScreen().disableShowWhenLocked(window)
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    private fun screenWakeUpChanel(flutterEngine: FlutterEngine){
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_SCREENWAKEUP).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "turnOn" -> {

                    result.success(null)
                }
                "turnOff" -> {
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

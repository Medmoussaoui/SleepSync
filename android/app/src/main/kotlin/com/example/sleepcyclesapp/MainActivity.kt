package com.example.sleepcyclesapp

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANEEL_OVERLAY_SCREEN = "com.example.sleepcyclesapp/overlay_lock_screen"
    private val CHANNEL_ALARM_SCHEDULE = "com.example.sleepcyclesapp/alarm_schedule"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // 1
        overLockScreenChanel(flutterEngine)
        alarmScheduleChannel(flutterEngine)
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


    private fun alarmScheduleChannel(flutterEngine: FlutterEngine){
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ALARM_SCHEDULE).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "setAlarm" -> {
                    val timeInMillis = call.argument<Long>("timeInMillis")
                    if (timeInMillis != null) {
                        scheduleBackgroundService(timeInMillis)
                        result.success(null)
                    } else {
                        result.error("INVALID_TIME", "Time not provided", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun scheduleBackgroundService(timeInMillis: Long) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, ServiceAlarmReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(this, 0,intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)

        // ✅ Check if we have permission to schedule exact alarms (Android 12+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val alarmManager = getSystemService(AlarmManager::class.java)
            if (!alarmManager.canScheduleExactAlarms()) return
        }

        // ✅ Use setAlarmClock() for Android 12+ or setExactAndAllowWhileIdle() for older versions
        val alarmClockInfo = AlarmManager.AlarmClockInfo(timeInMillis, pendingIntent)
       val res =  alarmManager.setAlarmClock(alarmClockInfo, pendingIntent)
    }

//    private fun scheduleBackgroundServiceTTTT(timeInMillis: Long) {
//        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
//        val intent = Intent(this, ServiceAlarmReceiver::class.java)
//
//        val pendingIntent = PendingIntent.getBroadcast(
//            this,
//            0,
//            intent,
//            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
//        )
//
//        // ✅ Check if we have permission to schedule exact alarms (Android 12+)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//            val alarmManager = getSystemService(AlarmManager::class.java)
//            if (!alarmManager.canScheduleExactAlarms()) return
//        }
//
//        // ✅ Use setAlarmClock() for Android 12+ or setExactAndAllowWhileIdle() for older versions
//        val alarmClockInfo = AlarmManager.AlarmClockInfo(timeInMillis, pendingIntent)
//        alarmManager.setAlarmClock(alarmClockInfo, pendingIntent)
//    }





}



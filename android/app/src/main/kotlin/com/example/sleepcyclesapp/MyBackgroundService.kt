package com.example.sleepcyclesapp

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.AlarmManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MyBackgroundService : Service() {

    private lateinit var wakeLock: PowerManager.WakeLock


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        openWakeUpScreen()
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }


    fun openWakeUpScreen(){
        val context = this
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val timeMills = System.currentTimeMillis() + 2000

        val newIntent = Intent(this, FlutterActivity::class.java)
        newIntent.putExtra("route", "/wakeUpScreen")
        newIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK

        val pendingIntent = PendingIntent.getActivity(
            context, 0, newIntent, PendingIntent.FLAG_CANCEL_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) return
        }

        alarmManager.setExact(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent)

        stopSelf()

        // Remove the app from recent tasks (history)
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        activityManager.appTasks.forEach { it.finishAndRemoveTask() }

        // Kill the app completely
        android.os.Process.killProcess(android.os.Process.myPid())
    }
}

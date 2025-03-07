package com.example.sleepcyclesapp
import android.app.ActivityManager
import android.app.AlarmManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.os.PowerManager

class MyBackgroundService : Service() {

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        openWakeUpScreen()
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    //

    fun openWakeUpScreen() {
        val context = this
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val timeMills = System.currentTimeMillis() + 2000

        val newIntent = Intent(this, MainActivity::class.java)
        newIntent.putExtra("route", "/wakeUpScreen")
        newIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP

        val pendingIntent = PendingIntent.getActivity(
            context, 0, newIntent, PendingIntent.FLAG_CANCEL_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) return
        }

       //   alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            // API 23+ (Marshmallow and above)
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent);
        } else {
            // API 21-22 (Lollipop & Lollipop MR1)
            alarmManager.setExact(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent);
        }

        wakeUpDevice()

        // Remove the app from recent tasks (history)
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        activityManager.appTasks.forEach { it.finishAndRemoveTask() }

       stopSelf()
        // Kill the app completely
        android.os.Process.killProcess(android.os.Process.myPid())
    }

    private fun wakeUpDevice() {
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        val wakeLock = powerManager.newWakeLock(
            PowerManager.FULL_WAKE_LOCK or 
            PowerManager.ACQUIRE_CAUSES_WAKEUP or 
            PowerManager.ON_AFTER_RELEASE,
            "MyApp:WakeLock"
        )
    
        wakeLock.acquire(10000) // Keep screen on for 3 seconds
        wakeLock.release()
    }
}

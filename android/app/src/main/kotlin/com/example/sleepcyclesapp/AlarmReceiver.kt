package com.example.sleepcyclesapp

import android.app.ActivityManager
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.PowerManager
import android.os.PowerManager.*
import android.util.Log
import androidx.core.content.ContextCompat

class AlarmReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "AlarmReceiver"
        private const val WAKE_LOCK_TIMEOUT_MS = 10000L // 10 seconds
        private const val WAKE_LOCK_TAG = "SleepCyclesApp:WakeLock"
        const val ROUTE_EXTRA = "route"
        const val WAKE_UP_SCREEN_ROUTE = "/wakeUpScreen"
    }

    override fun onReceive(context: Context, intent: Intent) {
        Log.d(TAG, "Alarm received")
        openWakeUpScreen(context)
    }

    private fun openWakeUpScreen(context: Context) {
        wakeUpDevice(context)

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val timeMills = System.currentTimeMillis() + 2000

        val newIntent = Intent(context, MainActivity::class.java)
        newIntent.putExtra(ROUTE_EXTRA, WAKE_UP_SCREEN_ROUTE)
        newIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP

        val pendingIntent = PendingIntent.getActivity(
            context, 0, newIntent, PendingIntent.FLAG_CANCEL_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (!alarmManager.canScheduleExactAlarms()) {
                Log.e(TAG, "Can't schedule exact alarms.")
                return
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            // API 23+ (Marshmallow and above)
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent)
        } else {
            // API 21-22 (Lollipop & Lollipop MR1)
            alarmManager.setExact(AlarmManager.RTC_WAKEUP, timeMills, pendingIntent)
        }

        removeAppFromRecent(context)
    }

    private fun wakeUpDevice(context: Context) {
        val powerManager = ContextCompat.getSystemService(context, PowerManager::class.java)
        if (powerManager == null) {
            Log.e(TAG, "PowerManager service not available.")
            return
        }

        val wakeLock = powerManager.newWakeLock(
            PARTIAL_WAKE_LOCK or ACQUIRE_CAUSES_WAKEUP,
            WAKE_LOCK_TAG
        )

        try {
            wakeLock.acquire(WAKE_LOCK_TIMEOUT_MS)
            Log.d(TAG, "Wake lock acquired")
            // Perform tasks that need the device to be awake here
        } catch (e: SecurityException) {
            Log.e(TAG, "Security exception acquiring wake lock", e)
        } catch (e: Exception) {
            Log.e(TAG, "Error acquiring wake lock", e)
        } finally {
            if (wakeLock.isHeld) {
                wakeLock.release()
                Log.d(TAG, "Wake lock released")
            }
        }
    }

    private fun removeAppFromRecent(context: Context) {
        Log.w(TAG, "Attempting to remove app from recent tasks and kill process.")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
            activityManager?.appTasks?.forEach {
                try {
                    it.finishAndRemoveTask()
                    Log.d(TAG, "Removed task from recent tasks.")
                } catch (e: SecurityException) {
                    Log.e(TAG, "Security exception removing task", e)
                } catch (e: Exception) {
                    Log.e(TAG, "Error removing task", e)
                }
            }
        } else {
            Log.w(TAG, "Removing app from recent tasks is not supported on API levels below LOLLIPOP.")
        }
        // Killing the process is generally discouraged.
        // Consider if this is really needed and when.
        try {
            android.os.Process.killProcess(android.os.Process.myPid())
            Log.d(TAG, "App process killed.")
        } catch (e: Exception) {
            Log.e(TAG, "Error killing app process", e)
        }
    }
}
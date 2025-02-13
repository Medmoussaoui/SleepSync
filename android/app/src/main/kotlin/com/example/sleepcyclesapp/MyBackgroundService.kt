package com.example.sleepcyclesapp

import android.app.Service
import android.content.Intent
import android.os.IBinder
import io.flutter.embedding.android.FlutterActivity

class MyBackgroundService : Service() {
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // Perform your background task
        openWakeUpScreen()
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun openWakeUpScreen() {
        val newIntent = Intent(this, FlutterActivity::class.java)
        newIntent.putExtra("route", "/wakeUpScreen")
        newIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        startActivity(newIntent)
        // Stop the service after execution
//        stopSelf()
    }
}

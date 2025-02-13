package com.example.sleepcyclesapp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class ServiceAlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context != null) {
            val serviceIntent = Intent(context, MyBackgroundService::class.java)
            context.startService(serviceIntent)
        }
    }
}

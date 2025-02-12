package com.example.sleepcyclesapp

import android.view.WindowManager
import android.view.Window

class OverLockScreen {

    // Enable showing on lock screen
    fun enableShowWhenLocked(window: Window) {
        window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                        WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )
    }

    // Disable showing on lock screen
    fun disableShowWhenLocked(window: Window) {
        window.clearFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                        WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )
    }
}
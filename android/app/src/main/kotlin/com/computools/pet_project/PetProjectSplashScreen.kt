package com.computools.pet_project

import android.animation.Animator
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import io.flutter.embedding.android.SplashScreen

class PetProjectSplashScreen : SplashScreen {
    private lateinit var splashView : View

    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View {
        splashView = LayoutInflater.from(context).inflate(R.layout.splash_view, null)
        return splashView
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        animateAway(onTransitionComplete)
    }

    private fun animateAway(onTransitionComplete: Runnable) {
        splashView.animate().setListener(object : Animator.AnimatorListener {
            override fun onAnimationEnd(animation: Animator?) {
                onTransitionComplete.run()
            }

            override fun onAnimationStart(animation: Animator?) {}

            override fun onAnimationCancel(animation: Animator?) {}

            override fun onAnimationRepeat(animation: Animator?) {}

        })
                .alpha(0f)
                .setDuration(1000)
                .start()
    }
}


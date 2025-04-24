package com.checkapp

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import io.flutter.embedding.android.FlutterActivity
import com.facebook.react.bridge.ReadableMap
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngine
import com.facebook.react.bridge.ReadableType

class FlutterModule(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {
    val ENGINE_ID = "main_engine"

    init {
        // Khởi tạo bất kỳ thứ gì nếu cần thiết
    }

    override fun getName(): String {
        return "FlutterModule"  // Tên module này để React Native gọi
    }

    @ReactMethod
    fun openFlutterActivity(mapData: String) {

        val activity: Activity? = currentActivity
        activity?.let {
//            var flutterEngine = FlutterEngineCache.getInstance().get(ENGINE_ID)
//            if (flutterEngine == null) {
//                flutterEngine = FlutterEngine(reactApplicationContext.applicationContext)
//                flutterEngine.dartExecutor.executeDartEntrypoint(
//                    DartExecutor.DartEntrypoint.createDefault()
//                )
//                FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)
//            }

            val intent = Intent(it, CustomFlutterActivity::class.java)
            intent.putExtra("cached_engine_id", ENGINE_ID)
            intent.putExtra("destroy_engine_with_activity", false)
            intent.putExtra("DATA", mapData)
            it.startActivity(intent)

        }

//        FlutterActivity
//            .createDefaultIntent((Context)getCurrentActivity())
    }

    @ReactMethod
    fun showToast() {
        Toast.makeText(reactApplicationContext, "------b------------", Toast.LENGTH_SHORT).show()
    }


}
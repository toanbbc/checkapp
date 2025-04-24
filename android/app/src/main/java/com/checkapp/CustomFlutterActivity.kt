package com.checkapp

import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngineCache
import com.facebook.react.bridge.ReadableType
import org.json.JSONObject
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class CustomFlutterActivity : FlutterActivity() {

    private val CHANNEL = "flutter_back_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, _ ->
                if (call.method == "finishActivity") {
                    finish()
                }
            }
    val dataForm = intent.getStringExtra("DATA") ?: ""
    val engineId = intent.getStringExtra("cached_engine_id") ?: ""
//    val gson = Gson()
//    val type = object : TypeToken<Map<String, Any>>() {}.type
//    val mapData: Map<String, Any> = gson.fromJson(dataForm, type)

    val engine = FlutterEngineCache.getInstance().get(engineId)
    if (engine != null) {
        val channel = MethodChannel(engine.dartExecutor.binaryMessenger, "setup_config")
        channel.invokeMethod("sendData", dataForm)
    }
    }

   
}
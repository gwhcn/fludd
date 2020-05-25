package com.gwh.fludd

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull;
import com.gwh.fludd.constant.FluddPluginMethods
import com.gwh.fludd.handler.FluddMethodHandler
import com.gwh.fludd.handler.FluddResponseHandler

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FluddPlugin */
public class FluddPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "fludd")
        channel.setMethodCallHandler(this);
        FluddResponseHandler.setMethodChannel(channel)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "fludd")
            channel.setMethodCallHandler(FluddPlugin())
            FluddMethodHandler.setRegistrar(registrar.activity())
            FluddResponseHandler.setMethodChannel(channel)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
        when (call.method) {
            FluddPluginMethods.REGISTER_APP -> {
                FluddMethodHandler.registerApp(call, result)
            }
            FluddPluginMethods.UNREGISTER_APP -> {
                FluddMethodHandler.unregisterApp(result)
            }
            FluddPluginMethods.IS_Ding_Ding_INSTALLED -> {
                FluddMethodHandler.checkInstall(result)
            }
            FluddPluginMethods.SEND_AUTH -> {
                FluddMethodHandler.sendAuth(call, result)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        FluddMethodHandler.setRegistrar(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        FluddMethodHandler.setRegistrar(binding.activity)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        FluddMethodHandler.setRegistrar(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        FluddMethodHandler.setRegistrar(null)
    }
}

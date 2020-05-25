package com.gwh.fludd.handler

import android.content.Context
import com.android.dingtalk.share.ddsharemodule.DDShareApiFactory
import com.android.dingtalk.share.ddsharemodule.IDDShareApi
import com.android.dingtalk.share.ddsharemodule.message.SendAuth
import com.gwh.fludd.constant.CallResult
import com.gwh.fludd.constant.FluddPluginKeys
import io.flutter.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object FluddMethodHandler {
    var iddShareApi: IDDShareApi? = null

    private var context: Context? = null

    fun setRegistrar(registrar: Context?) {
        this.context = registrar
    }

    fun registerApp(call: MethodCall, result: MethodChannel.Result) {
        Log.d("钉钉Registrar：", "context:${context != null}")
        if (iddShareApi != null) {
            result.success(true)
            return
        }

        val appId: String? = call.argument(FluddPluginKeys.APP_ID)
        if (appId.isNullOrBlank()) {
            result.error(CallResult.RESULT_APPID_NULL, "are you sure your app id is correct ?", null)
            return
        }
        iddShareApi = DDShareApiFactory.createDDShareApi(context, appId, false)
        result.success(true)
    }

    fun unregisterApp(result: MethodChannel.Result) {
        iddShareApi?.unregisterApp()
        result.success(true)
    }

    fun checkInstall(result: MethodChannel.Result) {
        if (iddShareApi == null)
            result.error(CallResult.RESULT_API_NULL, "DingDing Api Not Registered", null)
        else
            result.success(iddShareApi!!.isDDAppInstalled)
    }

    fun sendAuth(call: MethodCall, result: MethodChannel.Result) {
        val req = SendAuth.Req()
        req.scope = SendAuth.Req.SNS_LOGIN;
        req.state = "state";
        if (iddShareApi == null) {
            result.error(CallResult.RESULT_API_NULL, "DingDing Api Not Registered", null)
        } else if (!iddShareApi!!.isDDAppInstalled) {
            result.error(CallResult.RESULT_NOT_INSTALLED, "DingDing not installed", null)
        } else if (req.supportVersion > iddShareApi!!.ddSupportAPI) {
            //钉钉版本过低，不支持登录授权
            result.error(CallResult.RESULT_VERSION_IS_TOO_LOW, "DingDing version is too low", null)
        } else {
            result.success(iddShareApi?.sendReq(req))
        }
    }
}
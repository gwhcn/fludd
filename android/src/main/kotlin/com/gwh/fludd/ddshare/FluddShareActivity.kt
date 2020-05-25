package com.gwh.fludd.ddshare

import android.app.Activity
import android.os.Bundle
import android.util.Log
import com.android.dingtalk.share.ddsharemodule.IDDAPIEventHandler
import com.android.dingtalk.share.ddsharemodule.message.BaseReq
import com.android.dingtalk.share.ddsharemodule.message.BaseResp
import com.gwh.fludd.handler.FluddMethodHandler
import com.gwh.fludd.handler.FluddResponseHandler


open class FluddShareActivity : Activity(), IDDAPIEventHandler {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try { //activity的export为true，try起来，防止第三方拒绝服务攻击
            FluddMethodHandler.iddShareApi?.handleIntent(intent, this);
        } catch (e: Exception) {
            e.printStackTrace()
            Log.d("lzc", "e===========>$e")
            finish()
        }
    }

    override fun onReq(baseReq: BaseReq) {
        Log.d("lzc", "onReq=============>")
    }

    override fun onResp(baseResp: BaseResp) {
        FluddResponseHandler.handleResponse(baseResp)
        finish()
    }
}
package fcm.study.estudo.flutter.hello_lbs_flutter

import android.location.Location
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.telephony.TelephonyManager
import android.telephony.gsm.GsmCellLocation
import android.content.Context

class MainActivity: FlutterActivity() {

    private val CHANNEL = "flutter.dev/geolocation"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL)
                .setMethodCallHandler {
                    call: MethodCall?,
                    result: MethodChannel.Result? ->
                    val telephony: TelephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                    if (telephony.getPhoneType() === TelephonyManager.PHONE_TYPE_GSM) {
                        val location: GsmCellLocation = telephony.getCellLocation() as GsmCellLocation
                        if (location != null) {
                            val lac = location.getLac().toString()
                            val cid = location.getCid()
                            var send = "$lac,$cid"
                            result!!.success(send)
                        }
                    }

                }
    }
}

package news.chen.yu.ionic;

import org.apache.cordova.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

import android.content.Intent;
import android.net.Uri;
import android.content.pm.PackageManager;

public class AlicloudFeedback extends CordovaPlugin {
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Log.d("news.chen.yu.ionic", action);
        if (action.equals("open")) {
            String param = args.getString(0);
            this.open(param, callbackContext);
            callbackContext.success();
            return true;
        }

        return false;
    }

    private void open(String param, CallbackContext callbackContext) {
        try {
            Log.d("news.chen.yu.ionic", "opening map ...");
            JSONObject obj = new JSONObject(param);
            // Log.d("news.chen.yu.ionic", obj.toString());
            int type = obj.getInt("type");
            double latitude = obj.getDouble("latitude");
            double longitude = obj.getDouble("longitude");
            String appName = obj.getString("appName");
            String currentName = obj.getString("currentName");
            String distName = obj.getString("distName");
            Log.d("news.chen.yu.ionic", Integer.toString(type));
            Log.d("news.chen.yu.ionic", Double.toString(latitude));
            Log.d("news.chen.yu.ionic", Double.toString(longitude));
            Log.d("news.chen.yu.ionic", appName);
            Log.d("news.chen.yu.ionic", currentName);
            Log.d("news.chen.yu.ionic", distName);
            
            PackageManager pm = this.cordova.getActivity().getPackageManager();
            
            if(type == 1) {
              Intent i1 = new Intent();
              String url = String.format("androidamap://navi?sourceApplication=%s&lat=%f&lon=%f&dev=0&style=2", appName, latitude, longitude);

              if(!this.isPackageInstalled("com.autonavi.minimap", pm)) {
                url = "http://www.autonavi.com";
              }
              
              i1.setData(Uri.parse(url));
              this.cordova.startActivityForResult((CordovaPlugin) this, i1, 0);
            } else if(type == 2) {
              Intent i1 = new Intent();
              String url = String.format("baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%s&mode=driving&coord_type=gcj02", latitude, longitude, distName);

              if(!this.isPackageInstalled("com.baidu.BaiduMap", pm)) {
                url = "https://mobile.baidu.com/item?docid=9304852";
              }
              
              i1.setData(Uri.parse(url));
              this.cordova.startActivityForResult((CordovaPlugin) this, i1, 0);
            }
            
        } catch(Exception e) {
            Log.e("news.chen.yu.ionic", e.toString());
        }
    }
    
    private boolean isPackageInstalled(String packagename, PackageManager packageManager) {
        try {
            packageManager.getPackageInfo(packagename, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
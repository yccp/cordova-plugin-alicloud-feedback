### cordova 国内地图导航插件

支持苹果，高德，百度。

### 安装

```
cordova plugin add cordova-plugin-yc-navigator --save
```
或
```
ionic cordova plugin add cordova-plugin-yc-navigator
```

### 使用方法

```js
window.YCNavigator.open({
  type: 0, // 0为苹果地图，1为高德地图，2为百度地图
  latitude: 43.8266300000, // 目标纬度
  longitude: 87.6168800000, // 目标经度
  currentName: '当前位置', // 当前位置名称
  distName: '乌鲁木齐', // 目标位置名称
  appName: '我的APP', // APP名字
});


```
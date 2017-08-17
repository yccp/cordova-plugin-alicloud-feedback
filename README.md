# 阿里云移动用户反馈 cordova 插件

> 支持ios, android
开通服务: [https://www.aliyun.com/product/feedback](https://www.aliyun.com/product/feedback)

## 安装

```
cordova plugin add cordova-plugin-alicloud-feedback --variable APP_KEY=你的KEY --variable APP_SECRET=你的SECRET --save
```
或
```
ionic cordova plugin add cordova-plugin-alicloud-feedback --variable APP_KEY=你的KEY --variable APP_SECRET=你的SECRET
```

> 相关依赖
[cordova-plugin-cocoapod-support](https://www.npmjs.com/package/cordova-plugin-cocoapod-support)
```
cordova plugin add cordova-plugin-cocoapod-support --save
```
或
```
ionic cordova plugin add cordova-plugin-cocoapod-support
```

## 使用方法

```js
window.AlicloudFeedback.open({
  // 自定义参数，目前仅ios有用
}, function() {
  console.log('成功');
}, function(e) {
  console.error(e);
});

```
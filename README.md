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
>打开反馈页面
```js
window.AlicloudFeedback.open({
  // 自定义参数，目前仅ios有用
}, function() {
  console.log('成功');
}, function(e) {
  console.error(e);
});

```
> 获取未读数量
```js
window.AlicloudFeedback.fetchUnreadCount(function(x) {
  console.log(x);
}, function(e) {
  console.error(e);
});
```

## IONIC Wrap
[https://github.com/yc-ionic/alicloud-feedback](https://github.com/yc-ionic/alicloud-feedback)

## 代码捐献

非常期待您的代码捐献。
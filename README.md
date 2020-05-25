# fludd

[![License](https://img.shields.io/badge/license-MIT-green.svg)](/LICENSE)

## 介绍
flutter 钉钉登录

## 使用方式

1. 注册申请到的AppID：Fludd.registerApp(appId: "xxxxx");
2. 注册回调监听(stream记得界面销毁时cancel掉)：Fludd.responseFromAuth.listen((resp) { });
3. ios需要传bundleId： Fludd.sendAuth(bundleId: 'bundleId');

## ios接入
Info.plist配置查询钉钉授权登录scheme权限。LSApplicationQueriesSchemes中添加dingtalk, dingtalk-open, dingtalk-sso。dingtalk用于查询是否安装钉钉。dingtalk-open用于查询是否支持开放平台接口调用（不需要查询开放平台接口可不填）。dingtalk-sso用于查询是否支持授权登录。注：iOS系统限制LSApplicationQueriesSchemes最多只能有50个，超出的话会有一部分不生效。
[!钉钉开放平台文档](https://github.com/415593725/flutter_k_chart/blob/master/example/images/screenshots.png)

## android接入
不用做什么设置


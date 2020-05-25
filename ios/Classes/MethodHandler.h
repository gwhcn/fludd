//
//  MethodHandler.h
//  fludd
//
//  Created by liuxiang on 2020/3/2.
//

#import <Foundation/Foundation.h>
#import "FluddPlugin.h"
@interface MethodHandler : NSObject
+ (void)regist:(FlutterMethodCall *)call result:(FlutterResult)result;
+ (void)unregist:(FlutterMethodCall *)call result:(FlutterResult)result;
+ (void)checkInstall:(FlutterMethodCall *)call result:(FlutterResult)result;
+ (void)sendAuth:(FlutterMethodCall *)call result:(FlutterResult)result;
@end

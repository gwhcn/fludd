//
//  MethodHandler.m
//  fludd
//
//  Created by liuxiang on 2020/3/2.
//

#import "MethodHandler.h"
#import <DTShareKit/DTOpenAPI.h>
#import <DTShareKit/DTOpenAPIObject.h>
#import "Constants.h"

@implementation MethodHandler
static bool isRegist = false;
+ (void)regist:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary<NSString *, id> *args = (NSDictionary<NSString *, id> *) [call arguments];
    if (!isRegist) {
        result(@([DTOpenAPI registerApp:args[APP_ID]]));
    } else {
        isRegist = true;
        result(@(isRegist));
    }
    
}
+ (void)unregist:(FlutterMethodCall *)call result:(FlutterResult)result{
    result(@(true));
}

+ (void)checkInstall:(FlutterMethodCall *)call result:(FlutterResult)result{
    result(@(DTOpenAPI.isDingTalkInstalled));
}

+ (void)sendAuth:(FlutterMethodCall *)call result:(FlutterResult)result{
    if (!DTOpenAPI.isDingTalkInstalled) {
        FlutterError *err = [FlutterError errorWithCode:RESULT_NOT_INSTALLED message:@"DingDing not installed" details:nil];
        result(err);
    } else {
        NSDictionary<NSString *, id> *args = (NSDictionary<NSString *, id> *) [call arguments];
        DTAuthorizeReq *req = [DTAuthorizeReq new];
        req.bundleId = args[BUNDLE_ID];
        result(@([DTOpenAPI sendReq:req]));
    }
}
@end

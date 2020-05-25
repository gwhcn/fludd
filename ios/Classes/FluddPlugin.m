//#import "FluddPlugin.h"
//
//@implementation FluddPlugin
//+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  FlutterMethodChannel* channel = [FlutterMethodChannel
//      methodChannelWithName:@"fludd"
//            binaryMessenger:[registrar messenger]];
//  FluddPlugin* instance = [[FluddPlugin alloc] init];
//  [registrar addMethodCallDelegate:instance channel:channel];
//}
//
//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}
//
//@end

#import "FluddPlugin.h"
#import "Constants.h"
#import "MethodHandler.h"
#import "RespHandler.h"

@interface FluddPlugin ()
@property (strong, nonatomic) RespHandler *respH;
@end

@implementation FluddPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"fludd" binaryMessenger:[registrar messenger]];
    FluddPlugin *instance = [FluddPlugin new];
    instance.respH = [RespHandler initWithChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *method = call.method;
    
    if ([method isEqualToString:METHOD_REGISTER_APP]) {
        [MethodHandler regist:call result:result];
        return;
    }
    if ([method isEqualToString:METHOD_UNREGISTER_APP]) {
        [MethodHandler unregist:call result:result];
        return;
    }
    if ([method isEqualToString:METHOD_IS_Ding_Ding_INSTALLED]) {
        [MethodHandler checkInstall:call result:result];
        return;
    }
    
    if ([method isEqualToString:METHOD_SEND_AUTH]) {
        [MethodHandler sendAuth:call result:result];
        return;
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    return [_respH handleUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [_respH handleUrl:url];
}

@end

//
//  RespHandler.m
//  fludd
//
//  Created by liuxiang on 2020/3/2.
//

#import "RespHandler.h"
#import "FluddPlugin.h"
#import <DTShareKit/DTOpenAPI.h>
#import <DTShareKit/DTOpenAPIObject.h>

@interface RespHandler ()<DTOpenAPIDelegate>
@property (strong, nonatomic) FlutterMethodChannel *channel;
@end
@implementation RespHandler

+ (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
    RespHandler *h = [RespHandler new];
    h.channel = channel;
    return h;
}

- (BOOL)handleUrl:(NSURL *)url {
    return [DTOpenAPI handleOpenURL:url delegate: self];
}

- (void)onResp:(DTBaseResp *)resp {
    if ([resp isKindOfClass:[DTAuthorizeResp class]]) {
        DTAuthorizeResp *aResp = (DTAuthorizeResp *)resp;
        NSDictionary *dict = @{
            @"errStr": aResp.errorMessage,
            @"errCode": @(aResp.errorCode),
//            @"state":@(aResp.),
            @"code": aResp.accessCode,
        };
        [_channel invokeMethod:@"onAuthResponse" arguments:dict];
    } else {
        
    }
}

@end

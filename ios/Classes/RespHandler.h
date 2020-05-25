//
//  RespHandler.h
//  fludd
//
//  Created by liuxiang on 2020/3/2.
//

#import <Foundation/Foundation.h>

@class FlutterMethodChannel;
@interface RespHandler : NSObject

+ (instancetype)initWithChannel:(FlutterMethodChannel *)channel;

- (BOOL)handleUrl:(NSURL *)url;
@end

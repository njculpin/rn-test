//
//  APIBridge.m
//  basic
//
//  Created by Nick Culpin on 6/24/20.
//  Copyright © 2020 basic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>


//@interface RCT_EXTERN_MODULE(APIBridge, NSObject)
//    RCT_EXTERN_METHOD(download:(NSString*)searchTerm callback:(RCTResponseSenderBlock))
//@end

@interface RCT_EXTERN_MODULE(APIBridge, NSObject)
    RCT_EXTERN_METHOD(download:(NSString *)searchTerm resolve:(RCTPromiseResolveBlock *)resolve reject:(RCTPromiseRejectBlock *)reject)
@end

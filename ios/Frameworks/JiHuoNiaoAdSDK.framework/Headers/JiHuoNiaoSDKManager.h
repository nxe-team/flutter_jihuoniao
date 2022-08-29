//
//  JiHuoNiaoSDKManager.h
//  JiHuoNiaoAdSDK
//
//  Created by ZJL on 2022/07/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JiHuoNiaoSDKManager : NSObject

+ (void)startWithAppid:(NSString *)appID AppKey:(NSString *)appkey;

/**
 SDK版本号
*/
+ (NSString *)SDKVersion;

@end

NS_ASSUME_NONNULL_END

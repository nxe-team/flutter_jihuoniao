//
//  JHNRewardAd.h
//  JiHuoNiaoAdSDK
//
//  Created by ZJL on 2022/07/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JHNRewardAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)JHNRewardedVideoAdDidLoad;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)JHNRewardedVideoAdFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)JHNRewardedVideoAdViewRenderSuccess;

/**
 This method is called when video ad is closed.
 */
- (void)JHNRewardedVideoAdDidClose;

/**
 This method is called when video ad is clicked.
 */
- (void)JHNRewardedVideoAdDidClick;

/**
 This method is called when video ad has reward.
 */
- (void)JHNRewardedVideoAdHasReward:(NSString*)tID;

@end

@interface JHNRewardAd : NSObject
/*
 扩展参数，非必传
 */
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *extra;

@property(nonatomic,weak) id<JHNRewardAdDelegate> delegate;

- (instancetype)initWithSlotID:(NSString *)slotID;
//加载并显示
- (void)loadShowRewardAd:(UIViewController *)viewController;
//仅加载
- (void)loadRewardAd;
//显示
- (void)showRewardAd:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END

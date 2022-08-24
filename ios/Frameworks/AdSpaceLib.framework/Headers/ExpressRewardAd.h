//
//  ExpressRewardAd.h
//  AdSpaceLib
//
//  Created by ZJL on 2022/07/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpressRewardedAdDelegate <NSObject>

/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressRewardedVideoAdDidLoad;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAdFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)nativeExpressRewardedVideoAdViewRenderSuccess;

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressRewardedVideoAdDidClose;

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressRewardedVideoAdDidClick;

/**
 This method is called when video ad has reward.
 */
- (void)nativeExpressRewardedVideoAdHasReward:(NSString*)tID;

@end

@interface ExpressRewardAd : NSObject
@property(nonatomic,weak) id<ExpressRewardedAdDelegate> delegate;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *extra;

- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAndShowRewardAd:(UIViewController *)viewController;
- (void)loadAd;
- (void)show:(UIViewController *)viewController;
- (void)native_Selector:(SEL)selector
                      withOptions:(NSDictionary*)options
                       usingBlock:(id)block
                            error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END

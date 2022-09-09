//
//  JHNInterstitialAd.h
//  JiHuoNiaoAdSDK
//
//  Created by ZJL on 2022/07/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JHNInterstitialAdDelegate <NSObject>

@optional

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)JHNInterstitialAdFailWithCode:(NSInteger)code TipStr:(NSString *)tipStr ErrorMessage:(NSString *)errorMessage;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)JHNInterstitialAdRenderSuccess;

/**
 This method is called when interstitial ad is clicked.
 */
- (void)JHNInterstitialAdDidClick;

/**
 This method is called when interstitial ad is closed.
 */
- (void)JHNInterstitialAdDidClose;

@end

@interface JHNInterstitialAd : NSObject

@property(nonatomic,weak) id<JHNInterstitialAdDelegate> delegate;

- (instancetype)initWithSlotID:(NSString *)slotID;

/*
 加载成功后直接显示，暂无预加载
 */
- (void)loadAd;

@end

NS_ASSUME_NONNULL_END

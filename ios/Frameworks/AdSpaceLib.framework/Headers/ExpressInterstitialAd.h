//
//  ExpressInterstitialAd.h
//  AdSpaceLib
//
//  Created by ZJL on 2022/07/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpressInterstitialAdDelegate <NSObject>
@optional

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)nativeExpresInterstitialAdFailWithCode:(NSInteger)code TipStr:(NSString *)tipStr ErrorMessage:(NSString *)errorMessage;


/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpresInterstitialAdRenderSuccess;

/**
 This method is called when interstitial ad is clicked.
 */
- (void)nativeExpresInterstitialAdDidClick;

/**
 This method is called when interstitial ad is closed.
 */
- (void)nativeExpresInterstitialAdDidClose;

@end

@interface ExpressInterstitialAd : NSObject

@property(nonatomic,weak) id<ExpressInterstitialAdDelegate> delegate;
- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAd;
- (void)native_Selector:(SEL)selector
                      withOptions:(NSDictionary*)options
                       usingBlock:(id)block
                            error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END

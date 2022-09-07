//
//  JHNFeedAd.h
//  JiHuoNiaoAdSDK
//
//  Created by ZJL on 2022/09/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JHNFeedAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)JHNFeedAdDidLoad:(NSArray *)feedDataArray;

/**
 This method is called when video ad materia failed to load.
 */
- (void)JHNFeedAdFailWithCode:(NSInteger)code TipStr:(NSString *)tipStr ErrorMessage:(NSString *)errorMessage;


- (void)JHNFeedAdViewRenderSuccess;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)JHNFeedAdViewExposure;

/**
 This method is called when video ad is closed.
 */
- (void)JHNFeedAdDidClose:(id)feedAd;

/**
 This method is called when video ad is clicked.
 */
- (void)JHNFeedAdDidClick;

@end

@interface JHNFeedAd : NSObject

@property(nonatomic,weak) id<JHNFeedAdDelegate> delegate;

//自动播放时，是否静音。默认 YES。loadAd前设置。
@property (nonatomic, assign) BOOL videoMuted;

- (instancetype)initWithSlotID:(NSString *)slotID Size:(CGSize)size;

- (void)loadAdWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END

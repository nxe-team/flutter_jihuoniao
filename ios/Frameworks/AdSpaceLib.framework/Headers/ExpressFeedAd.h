//
//  ExpressFeedAd.h
//  AdSpaceLib
//
//  Created by ZJL on 2022/09/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpressFeedAdDelegate <NSObject>

/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressFeedAdDidLoad:(NSArray *)feedDataArray;

/**
 This method is called when video ad materia failed to load.
 */
- (void)nativeExpressFeedAdFailWithCode:(NSInteger)code TipStr:(NSString *)tipStr ErrorMessage:(NSString *)errorMessage;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)nativeExpressFeedAdViewRenderSuccess;

- (void)nativeExpressFeedAdViewExposure;

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressFeedAdDidClose:(id)feedAd;

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressFeedAdDidClick;

@end

@interface ExpressFeedAd : NSObject
@property(nonatomic,weak) id<ExpressFeedAdDelegate> delegate;
@property (nonatomic, assign) BOOL videoMuted;

- (instancetype)initWithSlotID:(NSString *)slotID Size:(CGSize)size;
- (void)loadAdWithCount:(NSInteger)count;
- (void)native_Selector:(SEL)selector
                      withOptions:(NSDictionary*)options
                       usingBlock:(id)block
                            error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END

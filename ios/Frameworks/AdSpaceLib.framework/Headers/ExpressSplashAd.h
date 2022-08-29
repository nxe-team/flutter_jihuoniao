//
//  ExpressSplashAd.h
//  AdSpaceLib
//
//  Created by ky on 2022/07/03.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ExpressSplashAdDelegate <NSObject>
/**
 This method is called when rendering a splash successed.
 */
- (void)nativeExpressSplashViewRenderSuccess;

/**
 This method is called when nativeExpressSplashAdView is clicked.
 */
- (void)nativeExpressSplashViewDidClick;

/**
 This method is called when nativeExpressSplashAdView closed.
 */
- (void)nativeExpressSplashViewDidClose;

/**
 This method is called when when video ad play completed or an error occurred.
 */
- (void)nativeExpressSplashViewFailWithError:(NSError *)error;

@end

@interface ExpressSplashAd : NSObject
@property(nonatomic,weak) id<ExpressSplashAdDelegate> delegate;
- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAd;
@property(nonatomic,strong) UIView *customBottomView;
- (void)native_Selector:(SEL)selector
                      withOptions:(NSDictionary*)options
                       usingBlock:(id)block
                            error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END

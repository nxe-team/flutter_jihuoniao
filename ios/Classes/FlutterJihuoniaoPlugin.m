#import "FlutterJihuoniaoPlugin.h"
#if __has_include(<flutter_jihuoniao/flutter_jihuoniao-Swift.h>)
#import <flutter_jihuoniao/flutter_jihuoniao-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_jihuoniao-Swift.h"
#endif

@implementation FlutterJihuoniaoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterJihuoniaoPlugin registerWithRegistrar:registrar];
}
@end

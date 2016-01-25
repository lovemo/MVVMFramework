//
//  BQMacros.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/23.
//  Copyright © 2016年 momo. All rights reserved.
//

#ifndef BQMacros_h
#define BQMacros_h

/** ************************************* k ******************************************* */
#pragma mark - k

#define kIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define kAboveIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define kAboveIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kAboveIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define kIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kProjectName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenFrame [UIScreen mainScreen].bounds

// iOS7 @"zh-Hans", @"zh-Hant", ...
// iOS8 @"zh-Hans", @"zh-Hant", @"zh-HK", ...
// iOS9 @"zh-Hans-CN", @"zh-Hant-CN", @"zh-HK", @"zh-TW", ...
#define kLanguage [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]
#define kHans [kLanguage hasPrefix:@"zh-Hans"]
#define kHant ([kLanguage rangeOfString:@"^(zh-Hant|zh-HK|zh-TW).*$" options:NSRegularExpressionSearch].location != NSNotFound)
#define kHansOrHant (kHans || kHant)

#define kPathOfDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define kPathOfCaches [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define kURLOfDocument [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

#define kPathOfTmp NSTemporaryDirectory()
#define kPathOfHome NSHomeDirectory()

#define kNilOrNull(__ref) (((__ref) == nil) || ([(__ref) isEqual:[NSNull null]]))

/** *************************************** g ***************************************** */
#pragma mark - g

// RGB颜色
#define gColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

// 随机色
#define gRandomColor gColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define gApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define gUserDefaults [NSUserDefaults standardUserDefaults]
#define gUserDefaultsBoolForKey(__key) [gUserDefaults boolForKey:__key]
#define gUserDefaultsObjForKey(__key) [gUserDefaults objectForKey:__key]
#define gUserDefaultsIntegerForKey(__key) [gUserDefaults integerForKey:__key]

#define gNotiCenter [NSNotificationCenter defaultCenter]
#define gNotiCenterPost(__notiName, __obj) [gNotiCenter postNotificationName:__notiName object:__obj]

#define gClassName(__obj) [NSString stringWithUTF8String:object_getClassName(__obj)]

#define gLocalString(__string) NSLocalizedString(__string, nil)
#define gLocalStringFromTable(__string, __fileName) NSLocalizedStringFromTable(__string, __fileName, nil)

#define gWindow ((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0])
#define gKeyWindow [UIApplication sharedApplication].keyWindow

#define gRandomInRange(__startIndex, __endIndex) (int)(arc4random_uniform((u_int32_t)(__endIndex-__startIndex+1)) + __startIndex) // __startIndex ~ __endIndex

#define gIndexPath(__row, __section) [NSIndexPath indexPathForRow:__row inSection:__section]

/** ************************************** u ****************************************** */
#pragma mark - u

#define uXCODE_COLORS_ESCAPE        @"\033["
#define uXCODE_COLORS_RESET         uXCODE_COLORS_ESCAPE  @";"

#define uLogError(__format, ...)    NSLog((uXCODE_COLORS_ESCAPE @"fg255,41,105;" @"\n## " __format uXCODE_COLORS_RESET), ##__VA_ARGS__);
#define uAssert(__condition, __desc, ...) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wformat-extra-args\"") \
if (!(__condition)) \
uLogError(__desc, ##__VA_ARGS__); \
_Pragma("clang diagnostic pop") \
} while (0);


#define uWeakSelf typeof(self) __weak weakSelf = self;
#define uStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

#define uWeak(__obj) typeof(__obj) __weak weak_##__obj = __obj;
#define uBlock(__obj) typeof(__obj) __block block_##__obj = __obj;

#define uTypeof(__TYPE, __PROPERTY) ({typeof(__TYPE *) __CLASS = __PROPERTY; __CLASS;})

#define uBorder(__view) __view.layer.borderColor=[gRandomColo CGColor];__view.layer.borderWidth=1;


#endif /* BQMacros_h */

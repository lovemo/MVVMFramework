//
//  SUIUtils.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#ifndef SUIUtils_h
#define SUIUtils_h


#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error SUIKitTool doesn't support Deployement Target version < 7.0
#endif


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Tool
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#import "SUIMacro.h"
#import "SUITool.h"
#import "SUITool+Delay.h"
#import "SUITool+Camera.h"
#import "SUITool+OpenURL.h"
#import "SUITool+FileManager.h"


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Categorie
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

// Foundation

#import "NSObject+SUIAdditions.h"
#import "NSString+SUIAdditions.h"
#import "NSString+SUICrypto.h"
#import "NSString+SUIRegex.h"
#import "NSData+SUIAdditions.h"
#import "NSDate+SUIAdditions.h"
#import "NSNumber+SUIAdditions.h"
#import "NSArray+SUIAdditions.h"
#import "NSArray+SUISafeAccess.h"
#import "NSDictionary+SUIAdditions.h"
#import "NSDictionary+SUISafeAccess.h"
#import "NSIndexPath+SUIAdditions.h"


// UIKit

#import "UIView+SUIAdditions.h"
#import "UIViewController+SUIAdditions.h"
#import "UINavigationController+SUIAdditions.h"
#import "UIButton+SUIAdditions.h"
#import "UIControl+SUIAdditions.h"
#import "UILabel+SUIAdditions.h"
#import "UITextView+SUIAdditions.h"
#import "UITextField+SUIAdditions.h"
#import "UIImage+SUIAdditions.h"
#import "UIScrollView+SUIAdditions.h"

#import "UIButton+SVVAdditions.h"
#import "UILabel+SVVAdditions.h"
#import "UIView+SVVAdditions.h"
#import "UIViewController+SVVAdditions.h"


#endif /* SUIUtils_h */

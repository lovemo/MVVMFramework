//
//  SUITool+Camera.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SUITool (Camera)


+ (BOOL)cameraAvailable;

+ (BOOL)cameraRearAvailable;

+ (BOOL)cameraFrontAvailable;

+ (BOOL)photoLibraryAvailable;


@end

NS_ASSUME_NONNULL_END

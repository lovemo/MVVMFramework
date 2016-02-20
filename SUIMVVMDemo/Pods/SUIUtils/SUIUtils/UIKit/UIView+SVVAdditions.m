//
//  UIView+SVVAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIView+SVVAdditions.h"

@implementation UIView (SVVAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Nib
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Nib

+ (UINib *)svv_loadNib
{
    return [self svv_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)svv_loadNibNamed:(NSString*)nibName
{
    return [self svv_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)svv_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)svv_loadInstanceFromNib
{
    return [self svv_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)svv_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self svv_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)svv_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self svv_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)svv_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Shake
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Shake

- (void)shake {
    [self _shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:completionHandler];
    }];
}

@end

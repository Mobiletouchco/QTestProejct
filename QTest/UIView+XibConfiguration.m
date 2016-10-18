//
//  UIView+XibConfiguration.m
//  ePharma
//
//  Created by TM Mac 01 on 6/13/16.
//  Copyright © 2016 shahnewaz. All rights reserved.
//

#import "UIView+XibConfiguration.h"

@implementation UIView (XibConfiguration)
@dynamic borderColor, borderWidth, cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}



@end

//
//  UIView+XibConfiguration.h
//  ePharma
//
//  Created by TM Mac 01 on 6/13/16.
//  Copyright © 2016 shahnewaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XibConfiguration)

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end


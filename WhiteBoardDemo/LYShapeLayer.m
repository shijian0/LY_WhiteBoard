//
//  LYShapeLayer.m
//  WhiteBoardDemo
//
//  Created by LiYong on 2018/5/7.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import "LYShapeLayer.h"
#import <UIKit/UIKit.h>

@implementation LYShapeLayer
- (instancetype)init{
    if (self = [super init]) {
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = [UIColor redColor].CGColor;
        self.lineWidth = 2;
    }
    return self;
}
@end

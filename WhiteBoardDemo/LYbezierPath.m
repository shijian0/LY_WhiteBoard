//
//  LYbezierPath.m
//  WhiteBoardDemo
//
//  Created by 勇 李 on 2018/3/12.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import "LYbezierPath.h"

@implementation LYbezierPath
- (instancetype)init{
    if (self = [super init]) {
        self.lineCapStyle = kCGLineCapRound;
        self.lineJoinStyle = kCGLineJoinRound;
        self.lineColor = [UIColor redColor];
        self.lineWidth = 2;
    }
    return self;
}
@end

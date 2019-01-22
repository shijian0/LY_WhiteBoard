//
//  LYbezierPath.h
//  WhiteBoardDemo
//
//  Created by 勇 李 on 2018/3/12.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYbezierPath : UIBezierPath
@property (nonatomic,assign) BOOL isErase;
@property (nonatomic,strong) UIColor* lineColor;
@end

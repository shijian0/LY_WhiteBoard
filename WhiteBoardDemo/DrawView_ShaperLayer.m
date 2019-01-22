//
//  DrawView_ShaperLayer.m
//  WhiteBoardDemo
//
//  Created by LiYong on 2018/5/7.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import "DrawView_ShaperLayer.h"
#import "LYbezierPath.h"
#import "LYShapeLayer.h"
@interface DrawView_ShaperLayer()
@property (nonatomic,strong)NSMutableArray * shapeLayers;
@property (nonatomic,strong)NSMutableArray * delLayers;

@property (nonatomic,strong)LYShapeLayer * lastLayer;
@property (nonatomic,strong)LYbezierPath * lastPath;
@end

@implementation DrawView_ShaperLayer

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)back{
    CAShapeLayer * layer = self.shapeLayers.lastObject;
    [self.delLayers addObject:layer];
    [layer removeFromSuperlayer];
    [self.shapeLayers removeLastObject];
}
- (void)clean{
    [self.shapeLayers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(CAShapeLayer*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
        [self.shapeLayers removeObject:obj];
    }];
}
- (void)reDo{
    CAShapeLayer * layer = self.delLayers.lastObject;
    [self.delLayers removeLastObject];
    [self.layer addSublayer:layer];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches  withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    LYbezierPath*path = [[LYbezierPath alloc]init];
    [path moveToPoint:p];
    self.lastPath = path;
    LYShapeLayer*shapeLayer = [[LYShapeLayer alloc]init];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    self.lastLayer = shapeLayer;
    [self.shapeLayers addObject:shapeLayer];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.lastPath addLineToPoint:p];
    self.lastLayer.path = self.lastPath.CGPath;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (NSMutableArray*)shapeLayers{
    if (!_shapeLayers) {
        _shapeLayers = [NSMutableArray array];
    }
    return _shapeLayers;
}
- (NSMutableArray*)delLayers{
    if (!_delLayers) {
        _delLayers = [NSMutableArray array];
    }
    return _delLayers;
}
@end

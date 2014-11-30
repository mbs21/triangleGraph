//
//  DrawTriangle.h
//  triangleGraph
//
//  Created by 田中 塁 on 12/17/13.
//  Copyright (c) 2013 Rui Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAGNIFICATION   20.0
@interface DrawTriangle : UIView{
    double IntersectionPoint_X;
    double IntersectionPoint_Y;
    char triangleType;
    double drawHeight;
    double drawWidth;
    double a;
    double b;
    double c;
}
@property (nonatomic) double _IntersectionPoint_X;
@property (nonatomic) double _IntersectionPoint_Y;
@property (nonatomic) char _triangleType;
@property (nonatomic) double _drawHeight;
@property (nonatomic) double _drawWidth;
@property (nonatomic) double _a;
@property (nonatomic) double _b;
@property (nonatomic) double _c;
@end

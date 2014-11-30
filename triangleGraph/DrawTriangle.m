#import "DrawTriangle.h"

@implementation DrawTriangle
@synthesize _IntersectionPoint_X = IntersectionPoint_X;
@synthesize _IntersectionPoint_Y = IntersectionPoint_Y;
@synthesize _triangleType = triangleType;
@synthesize _drawHeight = drawHeight;
@synthesize _drawWidth = drawWidth;
@synthesize _a = a;
@synthesize _b = b;
@synthesize _c = c;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *ruledLine = [UIBezierPath bezierPath];
    [ruledLine setLineWidth:0.5f];
    double firstPoint_X = 60.0;
    double firstPoint_Y;
    double tmp = drawHeight;
    
    for (double i=0.0; ; i += MAGNIFICATION) {
        if ( tmp <= MAGNIFICATION ) {
            break;
        }
        tmp -= MAGNIFICATION;
    }
    firstPoint_Y = drawHeight-tmp-100;
    
    for (float x =  0.0; x<= drawWidth; x += MAGNIFICATION) {
        [ruledLine moveToPoint:CGPointMake(x, 0.0)];
        [ruledLine addLineToPoint:CGPointMake(x, drawHeight)];
    }
    for (float y = 0.0; y<= drawHeight; y += MAGNIFICATION) {
        [ruledLine moveToPoint:CGPointMake(0.0, y)];
        [ruledLine addLineToPoint:CGPointMake(drawWidth, y)];
    }
    [ruledLine stroke];
    
    if (triangleType == 1) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 3.0);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
        CGContextAddLineToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
        CGContextStrokePath(context);
        
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
        CGContextMoveToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
        CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
        CGContextStrokePath(context);

        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
        CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
        CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
        CGContextStrokePath(context);
    }
    if (triangleType == 2 || triangleType == 4 || triangleType == 0) {
        if (a>=b && a>=c) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else if (b>=c && b>=a){
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
    }
    if (triangleType == 3) {
        if (a>=b && a>=c) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y-c*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y-c*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else if (b>=c && b>=a){
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y-a*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y-a*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else{
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y-b*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y-b*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
    }
    if (triangleType == 5) {
        if ( a==b ) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+c*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else if ( b==c ){
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+a*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
        else{
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 3.0);
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+b*MAGNIFICATION, firstPoint_Y);
            CGContextAddLineToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextMoveToPoint(context, firstPoint_X+IntersectionPoint_X*MAGNIFICATION, firstPoint_Y-IntersectionPoint_Y*MAGNIFICATION);
            CGContextAddLineToPoint(context, firstPoint_X, firstPoint_Y);
            CGContextStrokePath(context);
        }
    }   
}
@end

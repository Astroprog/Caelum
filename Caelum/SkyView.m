//
//  SkyView.m
//  Caelum
//
//  Created by Peter Rodenkirch on 02.05.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import "SkyView.h"
#import "Star.h"
#import "StarDataBase.h"
#import "DataTypes.h"

NSMutableArray *starArray;

@implementation SkyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, [self bounds]);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);

    for (Star *tempStar in starArray)
    {
        double phi = raDoubleToPhi(tempStar.ra);
        double theta = decDoubleToTheta(tempStar.dec);
        double tempX = cos(theta) * sin(phi);
        double tempY = sin(theta);
        double tempZ = cos(theta) * cos(phi);
        double x = 200 * tempX / (1 + tempZ) + 100;
        double y = 200 * tempY / (1 + tempZ) + 100;
        
        
        double size = 0.0;
        if (tempStar.mag < 0) {
            size = 9.0;
        } else if (tempStar.mag < 2) {
            size = 7.0;
        } else if (tempStar.mag < 5) {
            size = 5.0;
        } else if (tempStar.mag < 8) {
            size = 2.0;
        } else if (tempStar.mag < 10) {
            size = 1.0;
        } else {
            size = 0.5;
        }
        
        CGContextFillEllipseInRect(context, CGRectMake(x, y, size, size));
    }

}


@end

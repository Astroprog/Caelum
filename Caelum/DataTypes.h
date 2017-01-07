//
//  DataTypes.h
//  Skychart
//
//  Created by Peter Rodenkirch on 22.04.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTypes : NSObject

typedef struct RightAscension {
    int hours;
    int minutes;
    double seconds;
} RightAscension;

typedef struct Declination {
    int degrees;
    int minutes;
    double seconds;
} Declination;

RightAscension newRightAscension(int hours, int minutes, double seconds);
Declination newDeclination(int degrees, int minutes, double seconds);
double raToDouble(RightAscension ra);
double raToPhi(RightAscension ra);
double decToDouble(Declination dec);
double decToTheta(Declination dec);
double raDoubleToPhi(double ra);
double decDoubleToTheta(double dec);

@end

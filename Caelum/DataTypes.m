//
//  DataTypes.m
//  Skychart
//
//  Created by Peter Rodenkirch on 22.04.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import "DataTypes.h"

@implementation DataTypes

RightAscension newRightAscension(int hours, int minutes, double seconds)
{
    RightAscension temp;
    temp.hours = hours;
    temp.minutes = minutes;
    temp.seconds = seconds;
    return temp;
}

Declination newDeclination(int degrees, int minutes, double seconds)
{
    Declination temp;
    temp.degrees = degrees;
    temp.minutes = minutes;
    temp.seconds = seconds;
    return temp;
}

double raDoubleToPhi(double ra)
{
    double result = ra / 24.0 * 2 * M_PI;
    return result;
}

double decDoubleToTheta(double dec)
{
    double result = dec / 180 * M_PI;
    return result;
}

double raToDouble(RightAscension ra)
{
    double arcSecs = ra.minutes * 60 + ra.seconds;
    double result = ra.hours + arcSecs / 3600;
    return result;
}

double raToPhi(RightAscension ra)
{
    double tempRa = raToDouble(ra);
    double result = tempRa / 24.0 * 2 * M_PI;
    return result;
}

double decToDouble(Declination dec)
{
    double arcSecs = dec.minutes * 60 + dec.seconds;
    double result = dec.degrees + arcSecs / 3600;
    return result;
}

double decToTheta(Declination dec)
{
    double tempDec = decToDouble(dec);
    double result = tempDec / 180 * M_PI;
    return result;
}

@end

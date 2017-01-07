//
//  Star.h
//  Caelum
//
//  Created by Peter Rodenkirch on 02.05.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Star : NSObject

@property (readwrite) unsigned index;
@property (readwrite) double ra;
@property (readwrite) double dec;
@property (readwrite) float mag;
@end

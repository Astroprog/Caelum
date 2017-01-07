//
//  SkyView.h
//  Caelum
//
//  Created by Peter Rodenkirch on 02.05.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarDataBase;


@interface SkyView : UIView
{
    CGContextRef context;
    StarDataBase *dataBase;
}

@end

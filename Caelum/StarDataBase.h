//
//  StarDataBase.h
//  Skychart
//
//  Created by Peter Rodenkirch on 29.04.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class Star;

@interface StarDataBase : NSObject
{
    sqlite3 *_dataBase;
}

+ (StarDataBase *)dataBase;
- (void)openDataBase;
- (void)loadStars;
- (void)insertStar:(Star *)star;
- (NSString *)getWritablePath;
-(void)createEditableCopyOfDatabaseIfNeeded;
@end

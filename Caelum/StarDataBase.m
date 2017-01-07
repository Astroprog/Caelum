//
//  StarDataBase.m
//  Skychart
//
//  Created by Peter Rodenkirch on 29.04.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import "StarDataBase.h"
#import "Star.h"
#import "DataTypes.h"
#import "SkyView.h"

NSMutableArray *starArray;

@implementation StarDataBase

static StarDataBase *_dataBase;

+ (StarDataBase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [[StarDataBase alloc] init];
    }
    return _dataBase;
}

- (NSString *)getWritablePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Stars.sqlite3"];
    return dataPath;
}

-(void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Stars.sqlite3"];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
//    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Stars.sqlite3"];
    NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"Stars" ofType:@"sqlite3"];
    success = [fileManager copyItemAtPath:defaultDBPath
                                   toPath:writableDBPath
                                    error:&error];
    if(!success)
    {
        NSAssert1(0,@"Failed to create writable database file with Message : '%@'.",
                  [error localizedDescription]);
    }
}


static int loadTimesCallback(void *context, int count, char **values, char **columns)
{
    NSMutableArray *times = (__bridge NSMutableArray *)context;
    for (int i=0; i < count; i++) {
        const char *nameCString = values[i];
        [times addObject:[NSString stringWithUTF8String:nameCString]];
    }
    return SQLITE_OK;
}

- (void)openDataBase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *dataPath = [self getWritablePath];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Stars" ofType:@"sqlite3"];
    if ([fileManager fileExistsAtPath:dataPath])
    {
        _dataBase = NULL;
        if (sqlite3_open([dataPath UTF8String], &_dataBase) != SQLITE_OK) {
            NSLog(@"Failed to open star database");
        }
    }
}

- (void)emptyTable
{
    [self openDataBase];
    sqlite3_exec(_dataBase, "drop table Stars", NULL, NULL, NULL);
    sqlite3_close(_dataBase);
}

- (void)loadStars
{

    [self openDataBase];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    sqlite3_exec(_dataBase, "select * from Stars where mag < 7", loadTimesCallback, (__bridge void *)(tempArray), NULL);
    
    for (int i = 0; i < tempArray.count; i++) {
        if (i % 4 == 0) {
            Star *tempStar = [[Star alloc] init];
            tempStar.index = i;
            tempStar.ra = [[tempArray objectAtIndex:i+1] doubleValue];
            tempStar.dec = [[tempArray objectAtIndex:i+2] doubleValue];
            tempStar.mag = [[tempArray objectAtIndex:i+3] floatValue];
            [starArray addObject:tempStar];
        }
    }
        
    sqlite3_close(_dataBase);
}

- (void)insertStar:(Star *)star
{
    [self openDataBase];
    
    const char *sqlStatement = "insert into Stars (id,ra,dec,mag) VALUES (?,?,?,?)";
    sqlite3_stmt *compiledStatement;
    
    if (sqlite3_prepare_v2(_dataBase, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text( compiledStatement, 1,[[NSString stringWithFormat:@"%i", star.index] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text( compiledStatement, 2,[[NSString stringWithFormat:@"%f", star.ra] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text( compiledStatement, 3,[[NSString stringWithFormat:@"%f", star.dec] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text( compiledStatement, 4,[[NSString stringWithFormat:@"%f", star.mag] UTF8String], -1, SQLITE_TRANSIENT);
    }
    
    if (sqlite3_step(compiledStatement) != SQLITE_DONE )
    {
        NSLog( @"Save Error: %s", sqlite3_errmsg(_dataBase) );
    }
    
    sqlite3_finalize(compiledStatement);
    sqlite3_close(_dataBase);
}


- (id)init
{
    if (self = [super init]) {
        
//        char *err;
//        NSString *query = @"CREATE TABLE IF NOT EXISTS 'Stars' ('id' INTEGER PRIMARY KEY, 'ra' REAL, 'dec' REAL, 'mag' REAL)";
//        
//        if (sqlite3_exec(_dataBase, [query UTF8String], NULL, NULL, &err) != SQLITE_OK)
//        {
//            NSAssert(0, @"Table Failed to create.");
//        }
        
    }
    
    return self;
}

- (void)dealloc
{
    sqlite3_close(_dataBase);
}

@end

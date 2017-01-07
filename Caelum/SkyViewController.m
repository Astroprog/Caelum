//
//  ViewController.m
//  Caelum
//
//  Created by Peter Rodenkirch on 02.05.14.
//  Copyright (c) 2014 Peter Rodenkirch. All rights reserved.
//

#import "SkyViewController.h"
#import "SkyView.h"
#import "StarDataBase.h"

NSMutableArray *starArray;

@implementation SkyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setClipsToBounds:YES];
//    SkyView *skyView = [[SkyView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
//	self.view = skyView;
    
    starArray = [NSMutableArray new];
    StarDataBase *dataBase = [StarDataBase dataBase];
    [dataBase loadStars];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    self.view.frame = CGRectMake(0.0, 20.0, 320.0, 300.0);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

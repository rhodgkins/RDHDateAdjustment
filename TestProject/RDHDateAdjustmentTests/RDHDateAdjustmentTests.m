//
//  RDHDateAdjustmentTests.m
//  RDHDateAdjustmentTests
//
//  Created by Richard Hodgkins on 03/08/2013.
//  Copyright (c) 2013 Rich H. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface RDHDateAdjustmentTests : SenTestCase

@end

/// Tue, 01 Jan 2013 00:00:00 GMT
static NSTimeInterval const TIME_INTERVAL_BASE = 1356998400;
/// Tue, 01 Jan 2013 00:00:10 GMT
static NSTimeInterval const TIME_INTERVAL_10_SECS = 1356998410;
/// Tue, 01 Jan 2013 00:37:00 GMT
static NSTimeInterval const TIME_INTERVAL_37_MINS = 1357000620;
/// Tue, 01 Jan 2013 14:00:00 GMT
static NSTimeInterval const TIME_INTERVAL_14_HRS = 1357048800;
/// Tue, 01 Jan 2013 07:22:58 GMT
static NSTimeInterval const TIME_INTERVAL_7_HRS_22_MINS_58_SEC = 1357024978;
/// Thur, 17 Jan 2013 00:00:00 GMT
static NSTimeInterval const TIME_INTERVAL_17_DAYS = 1358380800;

#import "RDHDateAdjustment.h"

@implementation RDHDateAdjustmentTests

-(void)testDateAddition
{
    NSDate *baseDate = [NSDate dateWithTimeIntervalSince1970:TIME_INTERVAL_BASE];
}


@end

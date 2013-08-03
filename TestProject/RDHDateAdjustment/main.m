//
//  main.m
//  RDHDateAdjustment
//
//  Created by Richard Hodgkins on 03/08/2013.
//  Copyright (c) 2013 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RDHDateAdjustment.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *now = [NSDate date];
        NSDate *date = [now dateByUsingCurrentCalendarToAdjustCalendarUnit:NSYearCalendarUnit withValue:1];
        
        NSLog(@"%@ -> %@", now, date);
        
        date = [now dateByUsingCurrentCalendarToAddDateComponentsDictionary:@{
                @(NSYearCalendarUnit) : @(1),
                @(NSMonthCalendarUnit) : @(3)}];
        
        NSLog(@"%@ -> %@", now, date);
    }
    return 0;
}


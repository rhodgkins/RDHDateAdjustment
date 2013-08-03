//
//  RDHDateAdjustment.h
//  RDHDateAdjustment
//
//  Created by Richard Hodgkins on 03/08/2013.
//  Copyright (c) 2013 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RDHDateComponentsCreation)

+(instancetype)dateWithCalendar:(NSCalendar *)calendar fromDateComponentsDictionary:(NSDictionary *)dict;

+(instancetype)dateWithCurrentCalendarFromDateComponentsDictionary:(NSDictionary *)dict;

-(NSDateComponents *)dateComponentsWithCalendar:(NSCalendar *)calendar;

-(NSDateComponents *)dateComponentsWithCurrentCalendar;

@end

@interface NSDate (RDHDateAdjustment)

-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value;

-(instancetype)dateByUsingCurrentCalendarToAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value;

-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAddDateComponentsDictionary:(NSDictionary *)dict;

-(instancetype)dateByUsingCurrentCalendarToAddDateComponentsDictionary:(NSDictionary *)dict;

-(instancetype)dateOfStartOfDayUsingCalendar:(NSCalendar *)calendar;

-(instancetype)dateOfStartOfDayUsingCurrentCalendar;

@end

@interface NSDateComponents (RDHDictionaryRepresentation)

/**
 * Creates date components from a dictionary of `NSCalendarUnit`s and their allowed values.
 */
+(instancetype)dateComponentsWithDictionaryRepresentation:(NSDictionary *)dict;

/**
 * @return a dictionary of `NSCalendarUnit`s and the receivers components.
 */
-(NSDictionary *)dictionaryRepresentation;

@end
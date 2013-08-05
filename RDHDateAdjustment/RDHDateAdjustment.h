//
//  RDHDateAdjustment.h
//  RDHDateAdjustment
//
//  Created by Richard Hodgkins on 03/08/2013.
//  Copyright (c) 2013 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Simple category for creating dates and date components.
 */
@interface NSDate (RDHDateComponentsCreation)

/**
 * Creates a date with the specified calendar from a dictionary representation of NSDateComponents.
 * @param calendar the calender to use for creating a date.
 * @param dict the dictionary representation of the date components for the date you want to create.
 * @returns a date set to the specificed components.
 * @see -[NSDateComponents dictionaryRepresentation]
 */
+(instancetype)dateWithCalendar:(NSCalendar *)calendar fromDateComponentsDictionary:(NSDictionary *)dict;

/**
 * Creates a date with the `+[NSCalendar currentCalendar]` from a dictionary representation of NSDateComponents.
 * @see dateWithCalendar:fromDateComponentsDictionary:
 */
+(instancetype)dateWithCurrentCalendarFromDateComponentsDictionary:(NSDictionary *)dict;

/**
 * Useful for getting the current hour, minute, day, etc. of the receiver.
 * @returns the date components of the receiver using the specified calendar.
 */
-(NSDateComponents *)dateComponentsWithCalendar:(NSCalendar *)calendar;

/**
 * @returns the date components of the receiver using the `+[NSCalendar currentCalendar]`.
 * @see dateComponentsWithCalendar:
 */
-(NSDateComponents *)dateComponentsWithCurrentCalendar;

@end

/**
 * Allows for date maniplulation without having to deal directly with `NSDateComponents`.
 */
@interface NSDate (RDHDateAdjustment)

/**
 * Useful for obtaining another date offset from the receiver. If multiple units want to be adjusted at once use dateByUsingCalendar:toAddDateComponentsDictionary: instead.
 * @param calendar the calendar to use for the calculation.
 * @param unit a __single__ `NSCalendarUnit` to adjust.
 * @param value the value to adjust the unit by, this can be a negative value to decrement the unit.
 * @returns a date by adding the value of the component to the receiver.
 * @see dateByUsingCalendar:toAddDateComponentsDictionary:
 */
-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value;

/**
 * Uses the `+[NSCalendar currentCalendar]` for calculations.
 * @see dateByUsingCalendar:toAdjustCalendarUnit:withValue:
 */
-(instancetype)dateByUsingCurrentCalendarToAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value;

/**
 * Useful for obtaining another date by adjusting the receiver.
 * @param calendar the calendar to use for the calculation.
 * @param dict the dictionary representation of the date components for the adjustment. Negative values can also be specified.
 * @returns a date by adjusting the receiver by the specified components.
 */
-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAddDateComponentsDictionary:(NSDictionary *)dict;

/**
 * Uses the `+[NSCalendar currentCalendar]` for calculations.
 * @see dateByUsingCalendar:toAddDateComponentsDictionary:
 */
-(instancetype)dateByUsingCurrentCalendarToAddDateComponentsDictionary:(NSDictionary *)dict;

/**
 * E.g.:
 *      NSDate *date = [NSDate now];
 *      // date = Tue, 01 Jan 2013 07:22:58 GMT
 *      NSDate *dayDate = [date dateOfStartOfDayUsingCurrentCalendar];
 *      // dayDate = Tue, 01 Jan 2013 00:00:00 GMT
 * @param calendar the calendar to use for the calculation.
 * @returns the date for the start of the day for the receiver.
 */
-(instancetype)dateOfStartOfDayUsingCalendar:(NSCalendar *)calendar;

/**
 * Uses the `+[NSCalendar currentCalendar]` for calculations.
 * @see dateOfStartOfDayUsingCalendar:
 */
-(instancetype)dateOfStartOfDayUsingCurrentCalendar;

@end

/**
 * Provides a simpler way of defining `NSDateComponents`.
 */
@interface NSDateComponents (RDHDictionaryRepresentation)

/**
 * E.g.:
 *      @{@(NSYearCalendarUnit) : 1,
 *      @(NSMonthCalendarUnit) : 7,
 *      @(NSHourCalendarUnit) : 15,
 *      @(NSSecondCalendarUnit) : 36};
 * The keys for the dictionary should be boxed `NSCalendarUnit` enum values.
 * @param dict dictionary of `NSCalendarUnit`s to the component value.
 * @returns the date componets from the dictionary representation.
 * @see dictionaryRepresentation
 */
+(instancetype)dateComponentsWithDictionaryRepresentation:(NSDictionary *)dict;

/**
 * @return a dictionary of `NSCalendarUnit`s and the receivers components.
 * @see dateComponentsWithDictionaryRepresentation:
 */
-(NSDictionary *)dictionaryRepresentation;

@end
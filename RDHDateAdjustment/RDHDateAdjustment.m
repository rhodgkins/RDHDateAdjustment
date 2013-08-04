//
//  RDHDateAdjustment.m
//  RDHDateAdjustment
//
//  Created by Richard Hodgkins on 03/08/2013.
//  Copyright (c) 2013 Rich H. All rights reserved.
//

#import "RDHDateAdjustment.h"

static NSUInteger const RDH_CALENDAR_UNITS_COUNT = 16;
static NSCalendarUnit const RDH_CALENDAR_UNITS[] = {
    NSEraCalendarUnit,
    NSYearCalendarUnit,
    NSMonthCalendarUnit,
    NSDayCalendarUnit,
    NSHourCalendarUnit,
    NSMinuteCalendarUnit,
    NSSecondCalendarUnit,
    NSWeekCalendarUnit,
    NSWeekdayCalendarUnit,
    NSWeekdayOrdinalCalendarUnit,
    NSQuarterCalendarUnit,
    NSWeekOfMonthCalendarUnit,
    NSWeekOfYearCalendarUnit,
    NSYearForWeekOfYearCalendarUnit,
    NSCalendarCalendarUnit,
    NSTimeZoneCalendarUnit
};

/// All the `NSCalendarUnit` enums.
static NSCalendarUnit const RDHAllCalendarUnits = ~((NSCalendarUnit) 0);

#define RDHCurrentCalendar ([NSCalendar currentCalendar])

@implementation NSDate (RDHDateComponentsCreation)

+(instancetype)dateWithCalendar:(NSCalendar *)calendar fromDateComponentsDictionary:(NSDictionary *)dict
{
    NSDateComponents *comps = [NSDateComponents dateComponentsWithDictionaryRepresentation:dict];
    
    return [calendar dateFromComponents:comps];
}

+(instancetype)dateWithCurrentCalendarFromDateComponentsDictionary:(NSDictionary *)dict
{
    return [self dateWithCalendar:RDHCurrentCalendar fromDateComponentsDictionary:dict];
}

-(NSDateComponents *)dateComponentsWithCalendar:(NSCalendar *)calendar
{
    // All components
    return [calendar components:RDHAllCalendarUnits fromDate:self];
}

-(NSDateComponents *)dateComponentsWithCurrentCalendar
{
    return [self dateComponentsWithCalendar:RDHCurrentCalendar];
}

@end

@implementation NSDate (RDHDateAdjustment)

/// Checks to see if only one unit has been set
static BOOL RDHValidateSingleUnit(NSCalendarUnit unitToValidate)
{
    BOOL foundUnit = NO;
    for (NSUInteger i=0; i<RDH_CALENDAR_UNITS_COUNT; i++) {
        
        NSCalendarUnit unit = RDH_CALENDAR_UNITS[i];
        if (unitToValidate & unit) {
            if (foundUnit) {
                // We've already found a unit, so this isn't valid
                return NO;
            }
            // Mark found
            foundUnit = YES;
        }
    }
    // Returns if the unit has been found, if it hasn't it isn't valid
    return foundUnit;
}

-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value
{
    NSAssert(RDHValidateSingleUnit(unit), @"%@ can only be used with a single calendar unit, use %@ instead.", NSStringFromSelector(_cmd), NSStringFromSelector(@selector(dateByUsingCalendar:toAddDateComponentsDictionary:)));
    
    NSDictionary *dict = @{@(unit) : @(value)};
    
    return [self dateByUsingCalendar:calendar toAddDateComponentsDictionary:dict];
}

-(instancetype)dateByUsingCurrentCalendarToAdjustCalendarUnit:(NSCalendarUnit)unit withValue:(NSInteger)value
{
    return [self dateByUsingCalendar:RDHCurrentCalendar toAdjustCalendarUnit:unit withValue:value];
}

-(instancetype)dateByUsingCalendar:(NSCalendar *)calendar toAddDateComponentsDictionary:(NSDictionary *)dict
{
    NSDateComponents *comps = [NSDateComponents dateComponentsWithDictionaryRepresentation:dict];
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

-(instancetype)dateByUsingCurrentCalendarToAddDateComponentsDictionary:(NSDictionary *)dict
{
    return [self dateByUsingCalendar:RDHCurrentCalendar toAddDateComponentsDictionary:dict];
}

-(instancetype)dateOfStartOfDayUsingCalendar:(NSCalendar *)calendar
{
    // All components
    NSCalendarUnit units = RDHAllCalendarUnits;
    // Then unset hour, minute and second
    units ^= NSHourCalendarUnit;
    units ^= NSMinuteCalendarUnit;
    units ^= NSSecondCalendarUnit;
    return [calendar dateFromComponents:[calendar components:units fromDate:self]];
}

-(instancetype)dateOfStartOfDayUsingCurrentCalendar
{
    return [self dateOfStartOfDayUsingCalendar:RDHCurrentCalendar];
}

@end

@implementation NSDateComponents (RDHDictionaryRepresentation)

+(instancetype)dateComponentsWithDictionaryRepresentation:(NSDictionary *)dict
{
    NSDateComponents *c = [self new];
    
    for (NSNumber *boxedUnit in dict) {
        NSCalendarUnit unit = [boxedUnit unsignedIntegerValue];
        id value = dict[boxedUnit];
        
        if (value) {
            switch (unit) {
                case NSEraCalendarUnit:
                    [c setEra:[value integerValue]];
                    break;
                    
                case NSYearCalendarUnit:
                    [c setYear:[value integerValue]];
                    break;
                    
                case NSMonthCalendarUnit:
                    [c setMonth:[value integerValue]];
                    break;
                    
                case NSDayCalendarUnit:
                    [c setDay:[value integerValue]];
                    break;
                    
                case NSHourCalendarUnit:
                    [c setHour:[value integerValue]];
                    break;
                    
                case NSMinuteCalendarUnit:
                    [c setMinute:[value integerValue]];
                    break;
                    
                case NSSecondCalendarUnit:
                    [c setSecond:[value integerValue]];
                    break;
                    
                case NSWeekCalendarUnit:
                    [c setWeek:[value integerValue]];
                    break;
                    
                case NSWeekdayCalendarUnit:
                    [c setWeekday:[value integerValue]];
                    break;
                    
                case NSWeekdayOrdinalCalendarUnit:
                    [c setWeekdayOrdinal:[value integerValue]];
                    break;
                    
                case NSQuarterCalendarUnit:
                    [c setQuarter:[value integerValue]];
                    break;
                    
                case NSWeekOfMonthCalendarUnit:
                    [c setWeekOfMonth:[value integerValue]];
                    break;
                    
                case NSWeekOfYearCalendarUnit:
                    [c setWeekOfYear:[value integerValue]];
                    break;
                    
                case NSYearForWeekOfYearCalendarUnit:
                    [c setYearForWeekOfYear:[value integerValue]];
                    break;
                    
                case NSCalendarCalendarUnit:
                    [c setCalendar:value];
                    break;
                    
                case NSTimeZoneCalendarUnit:
                    [c setTimeZone:value];
                    break;
            }
        }
    }
    
    return c;
}

-(NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSUInteger i=0; i<RDH_CALENDAR_UNITS_COUNT; i++) {
        
        NSCalendarUnit unit = RDH_CALENDAR_UNITS[i];
        
        id value = nil;
        
        switch (unit) {
            case NSEraCalendarUnit:
                value = [self sanatizeValue:[self era]];
                break;
                
            case NSYearCalendarUnit:
                value = [self sanatizeValue:[self year]];
                break;
                
            case NSMonthCalendarUnit:
                value = [self sanatizeValue:[self month]];
                break;
                
            case NSDayCalendarUnit:
                value = [self sanatizeValue:[self day]];
                break;
                
            case NSHourCalendarUnit:
                value = [self sanatizeValue:[self hour]];
                break;
                
            case NSMinuteCalendarUnit:
                value = [self sanatizeValue:[self minute]];
                break;
                
            case NSSecondCalendarUnit:
                value = [self sanatizeValue:[self second]];
                break;
                
            case NSWeekCalendarUnit:
                value = [self sanatizeValue:[self week]];
                break;
                
            case NSWeekdayCalendarUnit:
                value = [self sanatizeValue:[self weekday]];
                break;
                
            case NSWeekdayOrdinalCalendarUnit:
                value = [self sanatizeValue:[self weekdayOrdinal]];
                break;
                
            case NSQuarterCalendarUnit:
                value = [self sanatizeValue:[self quarter]];
                break;
                
            case NSWeekOfMonthCalendarUnit:
                value = [self sanatizeValue:[self weekOfMonth]];
                break;
                
            case NSWeekOfYearCalendarUnit:
                value = [self sanatizeValue:[self weekOfYear]];
                break;
                
            case NSYearForWeekOfYearCalendarUnit:
                value = [self sanatizeValue:[self yearForWeekOfYear]];
                break;
                
            case NSCalendarCalendarUnit:
                value = [self calendar];
                break;
                
            case NSTimeZoneCalendarUnit:
                value = [self timeZone];
                break;
        }
        
        if (value) {
            dict[@(unit)] = value;
        }
    }
        
    return [dict copy];
}

/**
 * @returns the boxed value, or nil if the component is not set.
 */
-(NSNumber *)sanatizeValue:(NSInteger)value
{
    if (value == NSUndefinedDateComponent) {
        return nil;
    } else {
        return @(value);
    }
}

@end

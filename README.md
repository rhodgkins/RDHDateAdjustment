RDHDateAdjustment
=================

- Simplifies date manipulation by removing the need for direct use of `NSDateComponents`.
- `NSDateComponents` converted to a `NSDictionary` representation for quick use.
- A date can be 'zeroed' to the start of the day.

If you want to use a different calendar, other than `[NSCalendar currentCalendar]`, the methods all have a similar method where a `NSCalendar` can be passed in.

Documentation
-------------
[Online docs](http://cocoadocs.org/docsets/RDHDateAdjustment)

[Docset for xcode](http://cocoadocs.org/docsets/RDHDateAdjustment/xcode-docset.atom)

[Docset for Dash](dash-feed://http%3A%2F%2Fcocoadocs.org%2Fdocsets%2FRDHDateAdjustment%2FRDHDateAdjustment.xml)

Single component manipulation
-----------------------------
Instead of this:
``` objective-c
NSDate *now = [NSDate date];

// Create components to shift date by 5 years
NSDateComponents *comps = [NSDateComponents new];
[comps setYear:5];

NSDate *fiveYearsFromNow = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:now options:0];
````

Can be replaced by:
``` objective-c
NSDate *now = [NSDate date];
NSDate *fiveYearsFromNow = [now dateByUsingCurrentCalendarToAdjustCalendarUnit:NSYearCalendarUnit withValue:5];
````

Multiple component manipulation
-------------------------------
This also demos the use of the dictionary represenation for quickly creating date components.
Instead of this:
``` objective-c
NSDate *now = [NSDate date];

// Create components to shift date by 1 year, 7 months, 15 hours, 36 seconds
NSDateComponents *comps = [NSDateComponents new];
[comps setYear:1];
[comps setMonth:7];
[comps setHour:15];
[comps setSecond:36];

NSDate *adjustedDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:now options:0];
````

Can be replaced by:
``` objective-c
NSDate *now = [NSDate date];

// Create components to shift date by 1 year, 7 months, 15 hours, 36 seconds
NSDictionary *compsDict = @{@(NSYearCalendarUnit) : 1,
                            @(NSMonthCalendarUnit) : 7,
                            @(NSHourCalendarUnit) : 15,
                            @(NSSecondCalendarUnit) : 36};

NSDate *adjustedDate = [now dateByUsingCurrentCalendarToAddDateComponentsDictionary:compsDict];
````

Also creating components can be simplified:
``` objective-c
// To get a NSDateComonents object
NSDateComponents *comps = [NSDateComponents dateComponentsWithDictionaryRepresentation:@{@(NSYearCalendarUnit) : 1,
                                                                                         @(NSMonthCalendarUnit) : 7,
                                                                                         @(NSHourCalendarUnit) : 15,
                                                                                         @(NSSecondCalendarUnit) : 36}];
                                                                                                  
// To go from NSDateComponents
NSDictionary *compsDict = [comps dictionaryRepresentation];
````

Date from components
-----------------------------
Instead of this:
``` objective-c
// Components for 2001-01-01, UTC+2
NSDateComponents *comps = [NSDateComponents new];
[comps setYear:2001];
[comps setMonth:1];
[comps setDay:1];
[comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:2 * 3600]];

NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
````

Can be replaced by:
``` objective-c
NSDate *date = [NSDate dateWithCurrentCalendarFromDateComponentsDictionary:@{
                  @(NSYearCalendarUnit) : @2001,
                  @(NSMonthCalendarUnit) : 1,
                  @(NSDayCalendarUnit) : 1,
                  @(NSTimeZoneUnit) : [NSTimeZone timeZoneForSecondsFromGMT:2 * 3600]}];
`````

Date 'zeroing'
--------------
Instead of this:
``` objective-c
NSCalendar *cal = [NSCalendar currentCalendar];

// Remove time component
NSDateComponents *comps = [cal componentsFromDate:[NSDate date]];
[comps setHour:0];
[comps setMinute:0];
[comps setSecond:0];

NSDate *date = [cal dateFromComponents:comps];
````

Can be replaced by:
``` objective-c
NSDate *date = [[NSDate date] dateOfStartOfDayUsingCurrentCalendar];
`````

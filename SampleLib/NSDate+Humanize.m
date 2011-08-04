//  NSDate+Humanize.m
//  SampleLib
//
//  Created by Rodrigo Lima on 8/3/11.

#import "NSDate+Humanize.h"

typedef struct {
    NSTimeInterval interval;
    NSUInteger cap;
} HumanizedIntervalType;

#pragma mark -

@interface NSDate (HumanizePrivate)
+ (NSString *)humanizedDescriptionFromInterval:(NSTimeInterval)interval forType:(HumanizedIntervalType)type;
+ (NSString *)localizedHumanizedDescription:(NSUInteger)units forType:(HumanizedIntervalType)type;
@end

#pragma mark -

@implementation NSDate (Humanize)

#pragma mark Public Methods

- (BOOL)isOnTheSameDayAsDate:(NSDate *)date
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSCalendarUnit _units = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *_now = [_cal components:_units fromDate:self];
    NSDateComponents *_givenDate = [_cal components:_units fromDate:date];
    return (([_now day] == [_givenDate day]) && ([_now month] == [_givenDate month]) && ([_now year] == [_givenDate year]));
}

- (NSString *)humanizedDescription
{
    NSString *_humanized;
    if ([self isOnTheSameDayAsDate:[NSDate date]]) {
        NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        _humanized = [_formatter stringFromDate:self];
        [_formatter release];
    }
    else if ([self isOnTheSameDayAsDate:[NSDate dateWithTimeIntervalSinceNow:-DAY_IN_SECONDS]]) {
        _humanized = NSLocalizedString(@"Yesterday", nil);
    }
    else if ([self isOnTheSameDayAsDate:[NSDate dateWithTimeIntervalSinceNow:DAY_IN_SECONDS]]) {
        _humanized = NSLocalizedString(@"Tomorrow", nil);
    }
    else {
        NSTimeInterval _delta = -[self timeIntervalSinceNow];
        // handle future dates
        if (_delta < 0) {
            NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
            [_formatter setDateStyle:kCFDateFormatterMediumStyle];
            _humanized = [_formatter stringFromDate:self];
            [_formatter release];
        }
        else if (_delta < TWO_WEEKS_IN_SECONDS) {
            HumanizedIntervalType _day = {DAY_IN_SECONDS, 13};
            if (_delta < TWO_DAYS_IN_SECONDS) {
                _humanized = [NSDate localizedHumanizedDescription:2 forType:_day];
            }
            else{
                _humanized = [NSDate humanizedDescriptionFromInterval:_delta forType:_day];
            }
        }
        else if (_delta < MONTH_IN_SECONDS) {
            HumanizedIntervalType _week = {WEEK_IN_SECONDS, 4};
            _humanized = [NSDate humanizedDescriptionFromInterval:_delta forType:_week];
        }
        else if (_delta < YEAR_IN_SECONDS) {
            HumanizedIntervalType _month = {MONTH_IN_SECONDS, 11};
            _humanized = [NSDate humanizedDescriptionFromInterval:_delta forType:_month];
        }
        else if (_delta < DECADE_IN_SECONDS) {
            HumanizedIntervalType _year = {YEAR_IN_SECONDS, 9};
            _humanized = [NSDate humanizedDescriptionFromInterval:_delta forType:_year];
        }
        else {
            HumanizedIntervalType _decade = {DECADE_IN_SECONDS, 9};
            _humanized = [NSDate humanizedDescriptionFromInterval:_delta forType:_decade];
        }
    }
    return _humanized;
}

@end

#pragma mark -
#pragma Privates

@implementation NSDate (HumanizePrivate)

+ (NSString *)humanizedDescriptionFromInterval:(NSTimeInterval)interval forType:(HumanizedIntervalType)type
{
    NSInteger i = type.cap;
    while (i > 1.0) {
        if (interval < i * type.interval) i -= 1.0;
        else break;
    }
    return [NSDate localizedHumanizedDescription:i forType:type];
}

+ (NSString *)localizedHumanizedDescription:(NSUInteger)units forType:(HumanizedIntervalType)type
{
    NSString *_humanizedDesc = nil;
    if (type.interval == DAY_IN_SECONDS) {
        if (units == 1) _humanizedDesc = NSLocalizedString(@"1 day ago",nil);
        else _humanizedDesc = [NSString stringWithFormat:NSLocalizedString(@"%d days ago", "how many days ago. i.e. '3 days ago'"), units];
    }
    else if (type.interval == WEEK_IN_SECONDS) {
        if (units == 1) _humanizedDesc = NSLocalizedString(@"1 week ago",nil);
        else _humanizedDesc = [NSString stringWithFormat:NSLocalizedString(@"%d weeks ago", "how many weeks ago. i.e. '3 weeks ago'"), units];
    }
    else if (type.interval == MONTH_IN_SECONDS) {
        if (units == 1) _humanizedDesc = NSLocalizedString(@"1 month ago",nil);
        else _humanizedDesc = [NSString stringWithFormat:NSLocalizedString(@"%d months ago", "how many month ago. i.e. '3 month ago'"), units];
    }
    else if (type.interval == YEAR_IN_SECONDS) {
        if (units == 1) _humanizedDesc = NSLocalizedString(@"1 year ago",nil);
        else _humanizedDesc = [NSString stringWithFormat:NSLocalizedString(@"%d years ago", "how many years ago. i.e. '3 years ago'"), units];
    }
    else if (type.interval == DECADE_IN_SECONDS) {
        if (units == 1) _humanizedDesc = NSLocalizedString(@"1 decade ago",nil);
        else _humanizedDesc = [NSString stringWithFormat:NSLocalizedString(@"%d decades ago", "how many decades ago. i.e. '3 decades ago'"), units];
    }
    return _humanizedDesc;
}

@end

//  SampleLibTests.m
//  SampleLibTests
//
//  Created by Rodrigo Lima on 8/3/11.

#import "SampleLibTests.h"
#import "NSDate+Humanize.h"

@implementation SampleLibTests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    m_formatter = [[NSDateFormatter alloc] init];

}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
    [m_formatter release];
}

- (void)testToday
{
    NSDate* testDate = [NSDate date];
    NSString* _actual = [testDate humanizedDescription];

    [m_formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString* _expected = [m_formatter stringFromDate:testDate];

    NSLog(@"Testing - testToday [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testToday not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testTomorrow
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:DAY_IN_SECONDS];
    NSString* _actual = [testDate humanizedDescription];
    NSString* _expected = @"Tomorrow";
    
    NSLog(@"Testing - testTomorrow [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testTomorrow not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testYesterday
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:-DAY_IN_SECONDS];
    NSString* _actual = [testDate humanizedDescription];
    
    [m_formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString* _expected = @"Yesterday";
    
    NSLog(@"Testing - testYesterday [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testYesterday not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testDayAfterTomorrow
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:(DAY_IN_SECONDS*2)];
    NSString* _actual = [testDate humanizedDescription];
    
    [m_formatter setDateStyle:kCFDateFormatterMediumStyle];
    NSString* _expected = [m_formatter stringFromDate:testDate];
    
    NSLog(@"Testing - testDayAfterTomorrow [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testDayAfterTomorrow not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testDayLastWeek
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:-WEEK_IN_SECONDS];
    NSString* _actual = [testDate humanizedDescription];
    
    NSString* _expected = @"7 days ago";
    
    NSLog(@"Testing - testDayLastWeek [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testDayLastWeek not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testDayTwoWeeksAgo
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:-(WEEK_IN_SECONDS*2)];
    NSString* _actual = [testDate humanizedDescription];
    
    NSString* _expected = @"2 weeks ago";
    
    NSLog(@"Testing - testDayLastWeek [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testDayLastWeek not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

- (void)testDayLastMonth
{
    NSDate* testDate = [NSDate dateWithTimeIntervalSinceNow:-MONTH_IN_SECONDS];
    NSString* _actual = [testDate humanizedDescription];
    
    [m_formatter setDateStyle:kCFDateFormatterMediumStyle];
    NSString* _expected = [m_formatter stringFromDate:testDate];
    
    NSLog(@"Testing - testDayLastMonth [%@] - expected[%@]",_actual, _expected);
    STAssertEqualObjects(_actual, _expected, @"testDayLastMonth not match:\n--- Actual:\n%@\n--- Expected:\n%@", _actual, _expected);
}

@end

//  NSDate+Humanize.h
//  SampleLib
//
//  Created by Rodrigo Lima on 8/3/11.

#import <Foundation/Foundation.h>

#define DAY_IN_SECONDS 86400.0
#define TWO_DAYS_IN_SECONDS 172800.0
#define WEEK_IN_SECONDS 604800.0
#define TWO_WEEKS_IN_SECONDS 1209600.0
#define MONTH_IN_SECONDS 2592000.0
#define YEAR_IN_SECONDS 31536000.0
#define DECADE_IN_SECONDS 315360000.0

@interface NSDate (Humanize)

- (BOOL)isOnTheSameDayAsDate:(NSDate *)date;
- (NSString *)humanizedDescription;

@end

//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


- (NSString *)id_str {
    return [self.data valueOrNilForKeyPath:@"id_str"];
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)username {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"name"];
}

- (NSString *)handle {
    return [NSString stringWithFormat:@"@%@",[[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"]];
}

- (NSString *)tweetAge {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [df dateFromString:[self.data valueOrNilForKeyPath:@"created_at"]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:date];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    
    NSDate *currentData = [NSDate date];
    components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:currentData];
    NSInteger currentYear = [components year];
    NSInteger currentMonth = [components month];
    NSInteger curremtDay = [components day];
    NSInteger currentHour = [components hour];
    
    if (currentYear != year){
        NSInteger yearDifference = currentYear - year;
        return [NSString stringWithFormat:@"%dy",yearDifference];
    }
    
    if (currentMonth != month){
        NSInteger monthDifference = currentMonth - month;
        return [NSString stringWithFormat:@"%dm",monthDifference];
    }
    
    if (curremtDay != day){
        NSInteger dayDifference = curremtDay - day;
        return [NSString stringWithFormat:@"%dd",dayDifference];
    }
    
    if (currentHour != hour){
        NSInteger hourDifference = currentHour - hour;
        return [NSString stringWithFormat:@"%dh",hourDifference];
    }
    
    return @"";
}

- (NSString *)timestamp {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [df dateFromString:[self.data valueOrNilForKeyPath:@"created_at"]];
    
    [df setDateFormat:@"dd/MM/yy HH:mm"];
   
    return [df stringFromDate:date];
}

- (NSString *)profileImageUrl {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"profile_image_url"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end

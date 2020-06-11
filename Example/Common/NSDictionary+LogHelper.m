//
//  NSDictionary+LogHelper.m
//  iOS Example
//
//  Created by zhoushuai on 2020/6/11.
//

#import "NSDictionary+LogHelper.h"

@implementation NSDictionary (LogHelper)

- (NSString *)descriptionWithLocale:(id)locale {
    NSString *string;
    @try {
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
    } @catch (NSException *exception) {
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        string = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
    } @finally {
        
    }
    return string;
}

@end

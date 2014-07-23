#import "NSString+Helper.h"

@implementation NSString (Helper)

+ (NSString *)currentDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    return [formatter stringFromDate:[NSDate date]];
}

// base64编码
- (NSString *)base64Encode
{
    // 1. 将字符串转换成二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // 返回base64编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}

// base64解码
- (NSString *)base64Decode
{
    // 1. 使用base64编码的字符串创建二进制数据
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    // 2. 返回base64解码后的字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

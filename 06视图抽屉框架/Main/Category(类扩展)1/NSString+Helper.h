#import <Foundation/Foundation.h>

@interface NSString (Helper)

/** 当前日期时间字符串 */
+ (NSString *)currentDateTime;

/** base64编码 */
- (NSString *)base64Encode;

/** base64解码 */
- (NSString *)base64Decode;

@end

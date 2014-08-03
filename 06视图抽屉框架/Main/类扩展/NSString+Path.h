#import <Foundation/Foundation.h>

@interface NSString (Path)

/** 追加缓存路径 */
- (NSString *)appendCachePath;
/** 追加临时路径 */
- (NSString *)appendTmpDirPath;
/** 追加文档路径 */
- (NSString *)appendDocumentPath;
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

//
//  ZDInfoModel.h
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDInfoModel : NSObject
/** Cell图片名 */
@property (nonatomic,copy) NSString *imageName;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 详细 */
@property (nonatomic,copy) NSString *detail;
/** 发布时间 */
@property (nonatomic,copy) NSString *issuerDate;
/** 作者 */
@property (nonatomic,copy) NSString *issuer;
/** Cell高度(未使用) */
@property (nonatomic,assign) NSInteger detailCellH;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)infoWithDict:(NSDictionary *)dict;
+ (NSMutableArray *)infoModel;
@end

//
//  Singleton.h
//  05-单例
//
//  Created by apple on 14-7-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#define singleH(name)  +(instancetype)share##name

#if __has_feature(objc_arc) // ARC
#define singleM(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)share##name\
{\
return  _instance;\
}\
+ (void)initialize\
{\
_instance = [[self alloc] init];\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone;\
{\
return _instance;\
}

/********************华丽的分割线***********************/
#else // MRC
#define singleM(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)share##name\
{\
return  _instance;\
}\
+ (void)initialize\
{\
_instance = [[self alloc] init];\
}\
\
- (oneway void)release\
{}\
- (id)retain\
{\
return _instance;\
}\
\
- (NSUInteger)retainCount\
{\
return 1;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone;\
{\
return _instance;\
}

#endif


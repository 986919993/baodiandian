//
//  IWComposeViewController.m
//  传智微博
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDPostViewController.h"
#import "ZDTextView.h"

#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "ZDPostToolbar.h"
#import "ZDPostPhotosView.h"

#import <BmobSDK/Bmob.h>

#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>
#import "ZDAccountTool.h"
#import "ZDAccount.h"


@interface ZDPostViewController ()<UITextViewDelegate, IWComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  输入框
 */
@property (nonatomic, weak)  ZDTextView *textView;
/**
 *  工具条
 */
@property (nonatomic, weak) ZDPostToolbar *toolbar;
/**
 *  图片容器
 */
@property (nonatomic, weak) ZDPostPhotosView *photosView;
/**
 *  要发送的图片
 */
@property (nonatomic, weak) UIImage *image;
@property (nonatomic, weak) UIImage *image2;
@property (nonatomic, weak) UIImage *image3;
/**
 *  要发送的图片的路径
 */
@property (nonatomic, copy) NSString *ImageUrl;
@property (nonatomic, strong) ZDAccount *account;

@end

@implementation ZDPostViewController
int xuan = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.设置导航栏属性
    [self setupNavBar];
    
    // 2.添加输入框
    [self setupInputView];
   
//     3.添加工具条
    [self.photosView.button addTarget:self action:@selector(openPicture) forControlEvents:UIControlEventTouchUpInside];
    self.account = [ZDAccountTool account];
    xuan = 0;
}

// 打开相册
- (void)openPicture
{
    // 1.创建相册控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 设置数据源
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 设置代理, 监听用户选中的相片
    picker.delegate = self;
    // 2.弹出相册
    [self presentViewController:picker animated:YES completion:nil];

}
#pragma mark - UIImagePickerControllerDelegate
// 用户选中相片之后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // 1.关闭相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 2.取出用户选中的图片
    if (xuan == 0) {
        self.image = info[UIImagePickerControllerOriginalImage];
        [self.photosView addImage:self.image];
    }else if(xuan == 1){
        self.image2 = info[UIImagePickerControllerOriginalImage];
        [self.photosView addImage:self.image2];
    }else if(xuan == 2){
        self.image3 = info[UIImagePickerControllerOriginalImage];
        [self.photosView addImage:self.image3];
    }
    xuan +=1;
}
/**
 *  监听键盘的弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    
    // 1.获取键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.获取键盘的高度
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    // 3.让toolbar移动键盘的高度
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    }];
    
}

/**
 *  监听键盘的隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
//    IWLog(@"键盘的隐藏");
    // 1.获取键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 3.让toolbar移动键盘的高度
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}
/**
 *  添加输入框
 */
- (void)setupInputView
{
    // 1.添加可以接收输入事件的控件
    ZDTextView *textView = [[ZDTextView alloc] init];
    textView.width = self.view.width;
    textView.height = self.view.height;
    textView.placeholder = @"请输入要发表的内容...";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    // 设置输入框无论什么时候都可以滚动
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
    // 2.监听文本框改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.添加展示图片的容器
    ZDPostPhotosView *photosView = [[ZDPostPhotosView alloc] init];
    photosView.x = 0;
    photosView.y = 80;
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 3.显示键盘
    [self.textView becomeFirstResponder];
}
- (void)textChange
{
    // 判断是否有文本,
    if (self.textView.text.length) {
        // 有让发送按钮可以点击
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
#pragma mark - UITextViewDelegate
// 被拖拽的时候调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.title = @"发表";
}

/**
 *  取消
 */
- (void)cancel
{
     [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  分享一条信息
 */
- (void)send
{
    //在GameScore创建一条数据，如果当前没GameScore表，则会创建GameScore表
    BmobObject  *gameScore = [BmobObject objectWithClassName:@"ios_statusese"];
    //设置userName为小明
    BOOL bo = [self.account.gender isEqualToString:@"男"];
    [gameScore setObject:self.account.nickname forKey:@"title"];
    [gameScore setObject:[NSNumber numberWithBool:bo] forKey:@"man"];
    [gameScore setObject:self.account.city forKey:@"city"];
    [gameScore setObject:self.account.figureurl_qq_1 forKey:@"icon"];
    [gameScore setObject:@"0" forKey:@"zan"];
    [gameScore setObject:@"0" forKey:@"keng"];
    [gameScore setObject:@"0" forKey:@"ping"];
    [gameScore setObject:self.textView.text forKey:@"answer"];
    // 将相册的图片转化成2进制数据
    NSData *data = UIImageJPEGRepresentation(self.image,0.05);
    BmobFile *file1 = [[BmobFile alloc] initWithClassName:@"abc" withFileName:@"sdf" withFileData:data];
    
    NSData *data2 = UIImageJPEGRepresentation(self.image2,0.05);
    BmobFile *file2 = [[BmobFile alloc] initWithClassName:@"abc" withFileName:@"sdf" withFileData:data2];
    
    NSData *data3 = UIImageJPEGRepresentation(self.image3,0.05);
    BmobFile *file3 = [[BmobFile alloc] initWithClassName:@"abc" withFileName:@"sdf" withFileData:data3];

    [MBProgressHUD showMessage:@"正在发送..请耐心等待Sry.."];
    if (xuan == 0) {
        [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"发送成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"发送失败"];
                
            }
        }];
    }else if (xuan == 1){
        [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
            //如果文件保存成功，则把文件添加到filetype列
            if (isSuccessful) {
                [gameScore setObject:file1  forKey:@"imageName"];
                [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showSuccess:@"发送成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"发送失败"];
            }
        }];
    }else if (xuan == 2){
        [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
            //如果文件保存成功，则把文件添加到filetype列
            if (isSuccessful) {
                [gameScore setObject:file1  forKey:@"imageName"];
                [file2 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                    //如果文件保存成功，则把文件添加到filetype列
                    if (isSuccessful) {
                        [gameScore setObject:file2  forKey:@"imageName2"];
                        [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showSuccess:@"发送成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }else{
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showError:@"发送失败"];
                    }
                }];
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"发送失败"];
            }
        }];

    }else if (xuan == 3){
        [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
            //如果文件保存成功，则把文件添加到filetype列
            if (isSuccessful) {
                [gameScore setObject:file1  forKey:@"imageName"];
                [file2 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                    //如果文件保存成功，则把文件添加到filetype列
                    if (isSuccessful) {
                        [gameScore setObject:file2  forKey:@"imageName2"];
                        [file3 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                            //如果文件保存成功，则把文件添加到filetype列
                            if (isSuccessful) {
                                [gameScore setObject:file3  forKey:@"imageName3"];
                                [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                    [MBProgressHUD hideHUD];
                                    [MBProgressHUD showSuccess:@"发送成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
                            }else{
                                [MBProgressHUD hideHUD];
                                [MBProgressHUD showError:@"发送失败"];
                            }
                        }];
                    }else{
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showError:@"发送失败"];
                    }
                }];
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"发送失败"];
            }
        }];

    }
}
@end

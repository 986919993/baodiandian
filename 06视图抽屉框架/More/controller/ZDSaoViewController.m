//
//  ZDSaoViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-27.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDSaoViewController.h"

@interface ZDSaoViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
}
@property (strong, nonatomic) AVCaptureDevice * device;

@property (strong, nonatomic) AVCaptureSession * session;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer * layer;
//扫描线
@property (nonatomic, retain) UIImageView * line;
//扫描线计时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZDSaoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
	UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(100, 420, 120, 40);
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 290, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内,系统会自动识别.";
    [self.view addSubview:labIntroudction];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    
    [self.timer fire];
}

#pragma mark ACTion
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)animation
{
    if (upOrdown == NO) {
        num ++;
        self.line.frame = CGRectMake(50, 110+2 * num, 220, 2);
        if (2 * num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        self.line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupCamera];
    [self.session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupCamera
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc]init];
    
    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:input])
    {
        [_session addInput:input];
    }
    
    if ([_session canAddOutput:outPut])
    {
        [_session addOutput:outPut];
    }
    
    if (self.device != nil){
        outPut.metadataObjectTypes = [NSArray arrayWithObjects: AVMetadataObjectTypeQRCode,
                                                            AVMetadataObjectTypeCode39Code,
                                                            AVMetadataObjectTypeCode128Code,
                                                            AVMetadataObjectTypeCode39Mod43Code,
                                                            AVMetadataObjectTypeEAN13Code,
                                                            AVMetadataObjectTypeEAN8Code,
                                                            AVMetadataObjectTypeCode93Code,
                                                            nil];
    }else{
        [self.timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持扫描" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    // Preview
    self.layer =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layer.frame =CGRectMake(20,110,280,280);
    [self.view.layer insertSublayer:self.layer atIndex:0];
    
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue = nil;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [self.timer invalidate];

    NSString *str = [NSString stringWithFormat:@"扫到的二维码为：%@",stringValue];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"二维码" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark 懒加载
- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
        _line.image = [UIImage imageNamed:@"line.png"];
        [self.view addSubview:_line];
    }
    return _line;
}

@end

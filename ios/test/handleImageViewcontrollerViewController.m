//
//  handleImageViewcontrollerViewController.m
//  AwesomeProject
//
//  Created by 何志武 on 2023/12/4.
//

#import "handleImageViewcontrollerViewController.h"
#import <React/RCTRootView.h>
#import "ImageTool.h"

@interface handleImageViewcontrollerViewController ()

@property (nonatomic, strong)UIImageView *imageView1;
@property (nonatomic, strong)UIImageView *imageView2;
@property (nonatomic, strong)UIImageView *imageView3;

@end

@implementation handleImageViewcontrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setUI];
}

- (void)setUI {
  
  self.imageView1 = [[UIImageView alloc] init];
  self.imageView1.frame = CGRectMake(100, 50, 200, 100);
  self.imageView1.image = [UIImage imageNamed:@"origin"];
  [self.view addSubview:self.imageView1];
  
  self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
  self.imageView2.image = [UIImage imageNamed:@"mask"];
  [self.view addSubview:self.imageView2];
  
  self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 500, 200, 100)];
  // 原生测试效果
  self.imageView3 .image = [ImageTool getImageOfRGBAWithImage:[UIImage imageNamed:@"origin"] targetImage:[UIImage imageNamed:@"mask"]];
  [self.view addSubview:self.imageView3];
}

@end

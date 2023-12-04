//
//  Module.m
//  test
//
//  Created by 何志武 on 2023/12/4.
//
#import "Module.h"
#import "ImageTool.h"
#import <React/RCTConvert.h>


@implementation Module

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

// RN获取抠图后的结果 返回图片的路径
RCT_EXPORT_METHOD(getResultImagePath:(id)image1Path
                  targetImagePath:(id)image2Path
                  callback:(RCTResponseSenderBlock)cb) {
  // 将RN返回的路径加载为图片
  UIImage *image1 = [RCTConvert UIImage:image1Path];
  UIImage *image2 = [RCTConvert UIImage:image2Path];
  // 生成效果图
  UIImage *resultImage = [ImageTool getImageOfRGBAWithImage:image1 targetImage:image2];
  
  // 将效果图写入沙盒
  NSString *path_sandox = NSHomeDirectory();
  NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/test.png"];
  if ([UIImagePNGRepresentation(resultImage) writeToFile:imagePath atomically:YES]) {
    // 图片写入成功
    NSString *doucmentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [doucmentsPath stringByAppendingString:@"/test"];
    // 将效果图路径回调给RN
    cb(@[filePath]);
  }
}

@end

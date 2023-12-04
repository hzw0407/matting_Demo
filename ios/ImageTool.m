//
//  ImageTool.m
//  test
//
//  Created by 何志武 on 2023/12/4.
//

#import "ImageTool.h"

@implementation ImageTool

+ (UIImage *)getImageOfRGBAWithImage:(UIImage *)image1 targetImage:(UIImage *)image2 {
  // 分配内存
  const int imageWidth = image1.size.width;
  const int imageHeight = image1.size.height;
  size_t bytesPerRow = imageWidth * 4;
  uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
  
  // 创建context
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
  CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image1.CGImage);
  
  // 处理图片2
  NSMutableArray *restultArray = [NSMutableArray array];
  // 分配内存
  const int imageWidth2 = image2.size.width;
  const int imageHeight2 = image2.size.height;
  size_t bytesPerRow2 = imageWidth2 * 4;
  uint32_t* rgbImageBuf2 = (uint32_t*)malloc(bytesPerRow2 * imageHeight2);
  
  // 创建context
  CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
  CGContextRef context2 = CGBitmapContextCreate(rgbImageBuf2, imageWidth2, imageHeight2, 8, bytesPerRow2, colorSpace2,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
  CGContextDrawImage(context2, CGRectMake(0, 0, imageWidth2, imageHeight2), image2.CGImage);
  // 遍历像素
  int pixelNum2 = imageWidth2 * imageHeight2;
  uint32_t* pCurPtr2 = rgbImageBuf2;
  
  for (int i = 0; i < pixelNum2; i++, pCurPtr2++) {
    uint8_t* ptr2 = (uint8_t*)pCurPtr2;
    int B2 = ptr2[1];
    int G2 = ptr2[2];
    int R2 = ptr2[3];
    int A2 = ptr2[0];
    if (R2 == 255 && G2 == 255 && B2 == 255 && A2 == 255) {
      // 如果蒙版的色值是白色 则保存index值 用于后面的抠图赋值
      [restultArray addObject:[NSNumber numberWithInt:i]];
    } else {
      // 如果不是白色 则将本来的颜色改为白色
      ptr2[0] = 255;
      ptr2[1] = 255;
      ptr2[2] = 255;
      ptr2[3] = 255;
    }
  }
  //  NSLog(@"11111 = %d",restultArray.count);
  
  // 遍历目标图标的白色区域色值 将原图片对应位置的色值赋值给目标图片
  for (int j = 0; j <restultArray.count; j++) {
    int index = [restultArray[j] intValue];
    uint32_t* pCurPtrs = &rgbImageBuf[index];
    uint8_t* ptrs = (uint8_t*)pCurPtrs;
    uint32_t* pCurPtrs2 = &rgbImageBuf2[index];
    uint8_t* ptrs2 = (uint8_t*)pCurPtrs2;
    ptrs2[0] = ptrs[0];
    ptrs2[1] = ptrs[1];
    ptrs2[2] = ptrs[2];
    ptrs2[3] = ptrs[3];
  }
  
  // 将内存转成image
  CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf2, bytesPerRow2 * imageHeight2,NULL);
  CGImageRef imageRef = CGImageCreate(imageWidth2, imageHeight2, 8, 32, bytesPerRow2, colorSpace2,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
  
  CGDataProviderRelease(dataProvider);
  UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef scale:image2.scale orientation:image2.imageOrientation];
  // 释放
  CGImageRelease(imageRef);
  CGContextRelease(context);
  CGColorSpaceRelease(colorSpace);
  
  return resultUIImage;
}

@end

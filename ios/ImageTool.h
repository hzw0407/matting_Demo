//
//  ImageTool.h
//  test
//
//  Created by 何志武 on 2023/12/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTool : NSObject

+ (UIImage *)getImageOfRGBAWithImage:(UIImage *)image1 targetImage:(UIImage *)image2;

@end

NS_ASSUME_NONNULL_END

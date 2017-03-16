//
//  ImageUtils.m
//  315Learning
//
//  Created by 薛俊友 on 2017/3/15.
//  Copyright © 2017年 薛俊友. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+(UIImage *)imageWhitening:(UIImage *)imageSrc {
    //初始化图片
    CGImageRef imageRef = [imageSrc CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    //创建颜色空间
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    //创建图片上下文
    UInt32 *inputPixels = (UInt32 *)calloc(width * height, sizeof(UInt32));
    CGContextRef contextRef = CGBitmapContextCreate(inputPixels,
                                                    width,
                                                    height,
                                                    8,
                                                    width * 4,
                                                    colorSpaceRef, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    
    //美白处理
    int lumi = 10;
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j ++) {
            UInt32 *currentPixels  = inputPixels + (i * width) + j;
            UInt32 thisR, thisG, thisB, thisA;
            
            thisR = *currentPixels / (256*256*256);
            thisR = thisR + lumi;
            thisR = thisR > 255 ? 255 : thisR;
            
            thisG = *currentPixels % (256*256*256) / (256*256);
            thisG = thisG + lumi;
            thisG = thisG > 255 ? 255 : thisG;
            
            thisB = *currentPixels % (256*256*256) % (256 * 256) / 256;
            thisB = thisB + lumi;
            thisB = thisB > 255 ? 255 : thisB;
            
            thisA = *currentPixels % (256*256*256) % (256 * 256) % 256;
            thisA = thisA + lumi;
            thisA = thisA > 255 ? 255 : thisA;
//            NSLog(@"%d,%d,%d,%d",thisR,thisG,thisB,thisA);
            //更新ARGB的值
            *currentPixels = thisR * (256 * 256 * 256) + thisG * (256 * 256) + thisB * 256 + thisA;
            
        }
    }
    //创建UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
//    CGImageRelease(newImageRef);
    free(inputPixels);
    
    return newImage;
}

@end

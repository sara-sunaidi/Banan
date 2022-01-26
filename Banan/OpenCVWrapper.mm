//
//  OpenCVWrapper.m
//  Banan
//
//  Created by Sara Alsunaidi on 25/01/2022.
//

#import <opencv2/opencv.hpp>

#import "OpenCVWrapper.h"
#import <UIKit/UIKit.h>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

+ (BOOL)isWallPixel:(UIImage *)image xCoordinate:(int)x yCoordinate:(int)y {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
    
    //UInt8 red = data[pixelInfo];         // If you need this info, enable it
    //UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    //UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
    CFRelease(pixelData);
    
    //UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
    
    if (alpha) return YES;
    else return NO;
    
}

//error - Mat
+ (UIImage *)detectEdgesInRGBImage:(UIImage *)image
{
    
    //    cv::Mat mat;
    //    UIImageToMat(image, mat);
    //    if(mat.channels()==1){
    return image;
    //    }
    //    cv::Mat gray;
    //    cv::cvtColor(mat, gray, cv::COLOR_BGRA2GRAY);
    //    return MatToUIImage(gray);
    
}

@end

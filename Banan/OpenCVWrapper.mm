//
//  OpenCVWrapper.m
//  Banan
//
//  Created by Sara Alsunaidi on 25/01/2022.
//
#import <opencv2/opencv.hpp>

#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+ (NSString *)openCVVersionString {
return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

@end

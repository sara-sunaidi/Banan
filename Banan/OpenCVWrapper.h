//
//  OpenCVWrapper.h
//  Banan
//
//  Created by Sara Alsunaidi on 25/01/2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (NSString *)openCVVersionString;
+ (NSString *)checkCorners:(UIImage *)image;
+ (NSString *)detectRedShapesInImage:(UIImage *)image;
+ (NSString *)getCoordinatesStatus;
+ (UIImage *)detectFourCorners:(UIImage *)image;
+ (NSString *)detectRedShapessInImage:(UIImage *)image;
+ (UIImage *)detectFourCornerss:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END

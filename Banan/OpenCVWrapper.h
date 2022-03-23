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
+ (UIImage *)detectRedShapesInImage:(UIImage *)image;
+ (UIImage *)detectFourCorner:(UIImage *)image;

//+ (BOOL)isWallPixel:(UIImage *)image xCoordinate:(int)x yCoordinate:(int)y;


@end

NS_ASSUME_NONNULL_END

//
//  OpenCVWrapper.m
//  OpenCVTest
//
//  Created by Timothy Poulsen on 11/27/18.
//  Copyright © 2018 Timothy Poulsen. All rights reserved.
//
#include <iostream>
#include <bitset>
#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import <opencv2/imgcodecs/ios.h>
#import <UIKit/UIKit.h>
#define HASH_H



using namespace std;
using namespace cv;


typedef struct _braille{
    _braille() : rect(), value(0), index(0){}
    virtual ~_braille(){}
    cv::Rect rect;
    int value;  // decimal
    int index;
}braille;

// crop state flag
bool cropStatus = true;
//define hash table
//std::hash<int>;
string word = "";
 const int s = 3;
int i = 0;
struct item{
    int key;
    string value;
};
item* ht[s];


@implementation OpenCVWrapper

//typedef NS_ENUM(NSUInteger, )
//COLOR_BGR2GRAY     = 6, //!< convert between RGB/BGR and grayscale, @ref color_convert_rgb_gray "color conversions"
//COLOR_RGB2GRAY     = 7,

//add item to hash table
void addItem(int k, string v){
    cout << " ### inside AddItem" << endl;
    ht[i]= new item;
    ht[i]->key= k;
    ht[i]->value= v;

    i= i+1;
}

void addKv(){
    cout << " ### inside addKv" << endl;
        addItem(48,"ب");
        addItem(46,"ن");
        addItem(32,"ا");
        addItem(8, "ء");
        addItem(12, "أ");
        addItem(31, "ط");
        addItem(35, "ح");
        addItem(42, "ى");
        addItem(59, "ع");
        addItem(38, "د");
        addItem(63, "ظ");
        addItem(53, "ض");
        addItem(52, "ف");
        addItem(62, "ق");
        addItem(49, "غ");
        addItem(50, "ه");
        addItem(22, "ج");
        addItem(40, "ك");
        addItem(45, "خ");
        addItem(56, "ل");
        addItem(44, "م");
        addItem(58, "ر");
        addItem(61, "ص");
        addItem(28, "س");
        addItem(37, "ش");
        addItem(30, "ت");
        addItem(39, "ث");
        addItem(29, "ذ");
        addItem(33, "ة");
        addItem(23, "و");
        addItem(20, "ي");
        addItem(43, "ز");

}

//search
void searchK(int k){
    cout << " ### inside searchK" << endl;
    for(int j=0 ; j<s ; j++){
        if(ht[j]->key == k)
            word= word+ht[j]->value;
    }
}

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

+ (UIImage *)convertToGrayscale:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    UIImage *grayscale = MatToUIImage(gray);
    return grayscale;
}

+ (UIImage *)detectEdgesInRGBImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    //    cv::Laplacian(gray, gray, gray.depth());
    cv::Sobel(gray, gray, gray.depth(), 1, 0);
    UIImage *grayscale = MatToUIImage(gray);
    return grayscale;
}

+ (UIImage *)blur:(UIImage *)image radius:(double)radius {
    cv::Mat mat;
    UIImageToMat(image, mat);
    cv::GaussianBlur(mat, mat, cv::Size(NULL, NULL), radius);
    UIImage *blurredImage = MatToUIImage(mat);
    return blurredImage;
}

+ (UIImage *)getChannel:(UIImage *)image channel:(NSString *)channel {
    cv::Mat mat;
    UIImageToMat(image, mat);
    cv::Mat baseImage = cv::Mat::zeros(mat.size(), CV_8UC3);
    // UIImage is RGB, so our default here is blue
    int ch = 2;
    if ([channel isEqual: @"r"] || [channel isEqual: @"R"]) {
        ch = 0;
    } else if ([channel isEqual: @"g"] || [channel isEqual: @"G"]) {
        ch = 1;
    }
    int from_to[] = { ch,ch };
    cv::mixChannels(&mat, 1, &baseImage, 1, from_to, 1);
    UIImage *retImage = MatToUIImage(baseImage);
    return retImage;
}

// Braille Detection Code :D v

+ (NSString *)detectRedShapesInImage:(UIImage *)image{
    // set up hash table
     addKv();

    cout << "crop Status is " << cropStatus<< endl;

    if (cropStatus == true) {

        // resetting value
        word = "";

    cv::Mat mat;
    UIImageToMat(image, mat);

    //  0) Preprossesing:


    // Flipping the image to get mirror effect
    cv::flip(mat, mat, 1);

    // Filter the input image to reduce noise
    cv::medianBlur(mat, mat, 3);

    // Convert input image to HSV
    cv::Mat hsv_image;
    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);

    // 1) Threshold the HSV image, keep only the red pixels
    cv::Mat lower_red_hue_range;
    cv::Mat upper_red_hue_range;
    // BGR  == RGB
    cv::inRange(hsv_image, cv::Scalar(38, 38, 128), cv::Scalar(48, 255, 255), lower_red_hue_range);
    cv::inRange(hsv_image, cv::Scalar(113, 128, 38), cv::Scalar(123, 255, 255), upper_red_hue_range);

//  Sara's Scales :
//    cv::inRange(hsv_image, cv::Scalar(32, 22, 0), cv::Scalar(42, 255, 255), lower_red_hue_range);
//    cv::inRange(hsv_image, cv::Scalar(103,142, 160), cv::Scalar(113,255,255), upper_red_hue_range);

    //        cv::inRange(hsv_image, cv::Scalar(0, 100, 100), cv::Scalar(10, 255, 255), lower_red_hue_range);
    //        cv::inRange(hsv_image, cv::Scalar(160, 100, 100), cv::Scalar(179, 255, 255), upper_red_hue_range);

    // Combine the above two range images
    cv::Mat red_hue_image;
    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);

    // 2) Blur to remove noise:
    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2);

    // 3) Detect blobs:

    // Detect full blobs regrardless of color to set the initial braille coordinate lines
    cv::SimpleBlobDetector::Params initParams;
    initParams.filterByArea = true;
    initParams.minArea =  800.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
    initParams.maxArea =  19000.0f; //50.0f * 50.0f; //20.0f * 20.0f;


    cv::Ptr<cv::SimpleBlobDetector> initBlobDetector = cv::SimpleBlobDetector::create(initParams);
    std::vector<cv::KeyPoint> initKeypoints;
    initBlobDetector->detect(mat, initKeypoints);

     // Check keypoints existance & draw keypoints for displaying
        if(initKeypoints.empty()){
            cout << "there is no braille existance condition" << endl;
           // return 1;
        }
    cv::Mat detectedCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
    drawKeypoints(mat, initKeypoints, detectedCoordinatesImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

     // Detect red blobs only
        cv::SimpleBlobDetector::Params params;
            params.filterByArea = true;
            params.minArea =  800.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
            params.maxArea =  19000.0f; //50.0f * 50.0f; //20.0f * 20.0f;

     // The following two statements to detect white instead of black (default color)
            params.filterByColor = true;
            params.blobColor = 255;

        cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
        std::vector<cv::KeyPoint> keypoints;
            blobDetector->detect(red_hue_image, keypoints);

        // check keypoints existance & draw keypoints for displaying
            if(keypoints.empty()){
                cout << "there is no braille existance condition" << endl;
               // return 1;
            }
        cv::Mat detectedImg = cv::Mat(red_hue_image.size(), CV_8UC3);
        drawKeypoints(red_hue_image, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

    // 4) normalize keypoints to coordinate line set
            float blobSize = 0.0f;
            for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
                blobSize += initKeypoints[i].size;
               // blobSize -= (blobSize/5);
            }

            blobSize /= initKeypoints.size();
            cout << "mean of the blob sizes : " << blobSize << endl;
            vector<int> coordinateX;
            vector<int> coordinateY;

            for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
                bool isNew = true;
                for (vector<int>::iterator iter = coordinateX.begin(); iter < coordinateX.end(); ++iter) {
                    if(abs(*iter - initKeypoints[i].pt.x) < blobSize){
                        isNew = false;
                        break;
                    }
                }
                if(isNew){
                    coordinateX.push_back((int)initKeypoints[i].pt.x);
                }

                isNew = true;
                for (vector<int>::iterator iter = coordinateY.begin(); iter < coordinateY.end(); ++iter) {
                    if(abs(*iter - initKeypoints[i].pt.y) < blobSize){
                        isNew = false;
                        break;
                    }
                }

                if(isNew){
                            coordinateY.push_back((int)initKeypoints[i].pt.y);
                        }
                    }
                    sort(coordinateX.begin(), coordinateX.end());
                    sort(coordinateY.begin(), coordinateY.end());

    // draw coordinate lines for displaying
        cv::Mat coordinateImg = detectedImg.clone();
           for (int i = 0; i < static_cast<int>(coordinateX.size()); ++i) {
               line(coordinateImg, cv::Point(coordinateX[i], 0), cv::Point(coordinateX[i], coordinateImg.rows), cvScalar(255, 0, 0));
           }
           for (int i = 0; i < static_cast<int>(coordinateY.size()); ++i) {
               line(coordinateImg, cv::Point(0, coordinateY[i]), cv::Point(coordinateImg.cols, coordinateY[i]), cvScalar(255, 0, 0));
           }

    // 5) move keypoints to the nearest coordinate point
            for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
                int ditanceX = detectedCoordinatesImg.cols / 2;
                int ditanceY = detectedCoordinatesImg.rows / 2;
                int tempX = 0;
                int tempY = 0;
                for (int j = 0; j < static_cast<int>(coordinateX.size()); ++j) {
                    if(ditanceX > abs(keypoints[i].pt.x - coordinateX[j])){
                        ditanceX = abs(keypoints[i].pt.x - coordinateX[j]);
                        tempX = coordinateX[j];
                    }
                }
                keypoints[i].pt.x = tempX;

                for (int j = 0; j < static_cast<int>(coordinateY.size()); ++j) {
                    if(ditanceY > abs(keypoints[i].pt.y - coordinateY[j])){
                        ditanceY = abs(keypoints[i].pt.y - coordinateY[j]);
                        tempY = coordinateY[j];
                    }
                }
                keypoints[i].pt.y = tempY;
            }

    // make image from the edited keypoint set(draw line for display)
            Mat editedImg = Mat(detectedImg.size(), CV_8UC1); //here
            editedImg.setTo(255);
            for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
                circle(editedImg, cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(0), -1, LINE_AA);
            }
    //
    //    // optional
        Mat editedwithLineImg = editedImg.clone();
          for (int i = 0; i < static_cast<int>(coordinateX.size()); ++i) {
              line(editedwithLineImg, cv::Point(coordinateX[i], 0), cv::Point(coordinateX[i], editedwithLineImg.rows), Scalar(0));
          }
          for (int i = 0; i < static_cast<int>(coordinateY.size()); ++i) {
              line(editedwithLineImg, cv::Point(0, coordinateY[i]), cv::Point(editedwithLineImg.cols, coordinateY[i]), Scalar(0));
          }

    // 6) segmentation braille rectangle
            int startXPos = 0;
            int index = 0;
            vector<braille> brailleSet;
            Mat segmentationImg = Mat(editedImg.size(), CV_8UC3);
            cvtColor(editedImg, segmentationImg, COLOR_GRAY2BGR);
            if((coordinateX[1] - coordinateX[0]) > (coordinateX[2] - coordinateX[1])){
                startXPos = 1;
            }
            for(int i = 0; i < static_cast<int>(coordinateY.size()) - 2; i += 3){
                for(int j = startXPos; j < static_cast<int>(coordinateX.size()) - 1; j += 2){
                    braille tempBraille;
                    cv::Rect rect = cv::Rect(cv::Point(coordinateX[j] - blobSize / 2, coordinateY[i] - blobSize / 2),
                                     cv::Point(coordinateX[j + 1] + blobSize / 2, coordinateY[i + 2] + blobSize / 2));
                    int value = 0;
                    rectangle(segmentationImg, rect, Scalar(0, 0, 255));

                    // set the braille value(2x3 matrix)
                    for(int k = 0; k < 2; ++k){
                        for(int l = 0; l < 3; ++l){
                            if(editedImg.at<uchar>(cv::Point((int)coordinateX[j + k] , (int)coordinateY[i + l])) == 0){
                                value++;
                            }
                            value = value << 1;
                        }
                    }
                    value = value >> 1;
                    tempBraille.rect = rect;
                    tempBraille.index = index++;
                    tempBraille.value = value;
                    brailleSet.push_back(tempBraille);
                }
            }
            if(brailleSet.empty()){
                cout << "there is no braille set !!" << endl;
               // return 1;
            }

    // Missing Optional


//     7) make result image
           Mat resultImg = Mat(cv::Size(segmentationImg.size()), CV_8UC3);
           resultImg.setTo(255);
           addWeighted(resultImg, 0.8, segmentationImg, 0.2, 0.0,  resultImg);

           int intFontFace = FONT_HERSHEY_SIMPLEX;
           double dblFontScale = brailleSet[0].rect.size().width / 60.0;
           int intFontThickness = (int)std::round(dblFontScale * 2);

           for(int i = 0; i < static_cast<int>(brailleSet.size()); ++i){
               cv::Point center, bottomLeft;
               center = (brailleSet[i].rect.tl() + brailleSet[i].rect.br()) / 2;
               center.x -= getTextSize(to_string(brailleSet[i].value), intFontFace, dblFontScale, intFontThickness, 0).width / 2;
               center.y += getTextSize(to_string(brailleSet[i].value), intFontFace, dblFontScale, intFontThickness, 0).height / 2;

               bottomLeft = cv::Point(brailleSet[i].rect.tl().x, brailleSet[i].rect.br().y);
               bottomLeft.x -= blobSize / 2;
               bottomLeft.y += getTextSize(bitset<6>(brailleSet[i].value).to_string(), intFontFace, dblFontScale * 0.7, intFontThickness * 0.7, 0).height / 2 + blobSize / 2;

               searchK(brailleSet[i].value);

               putText(resultImg, to_string(brailleSet[i].value), center, intFontFace, dblFontScale, Scalar(255,0,0), intFontThickness);
               putText(resultImg, bitset<6>(brailleSet[i].value).to_string(), bottomLeft, intFontFace, dblFontScale * 0.7, Scalar(0,0,0), intFontThickness * 0.7);

               cout << "Blocks values" << endl;
               cout <<i<< " - " << brailleSet[i].value << endl;
           }
    cout << "$$ there final string is " <<word<< endl;

    UIImage *maskedShapesImg = MatToUIImage(red_hue_image); //detectedCoordinatesImg

        return [NSString stringWithUTF8String:word.c_str()];


    }else {
        return @"UnDetermined";
    }


}

+ (UIImage *)detectFourCorner:(UIImage *)image{

    // updating status just in case
    cropStatus = true;

    cv::Mat mat;
    UIImageToMat(image, mat);
    cv::medianBlur(mat, mat, 3);

    // Blob based Detection: to detect base 4 corner
    cv::SimpleBlobDetector::Params Params;
    Params.filterByArea = true;
    Params.minArea =  100.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
    Params.maxArea =  200.0f; //50.0f * 50.0f; //20.0f * 20.0f;


    cv::Ptr<cv::SimpleBlobDetector> BlobDetector = cv::SimpleBlobDetector::create(Params);
    std::vector<cv::KeyPoint> keypoints;
    BlobDetector->detect(mat, keypoints);

     // Check keypoints existance
        if(keypoints.empty()){
            cout << "@Error: there is no corner existance condition" << endl;
           // return 1;
        }

    // Check keypoints existance
       if(keypoints.size() != 4){
           cout << "@Error: number of corners found is " << keypoints.size() << endl;
           cropStatus = false;
          // return 1;
       }
    float blobSize = 0.0f;
        for (int i = 0; i < keypoints.size(); ++i) {
            blobSize += keypoints[i].size;
        }
    blobSize /= keypoints.size();

    cv::Mat detectedCornersImg = cv::Mat(mat.size(), CV_8UC3);
    detectedCornersImg.setTo(0);
    for (int i = 0; i < keypoints.size(); ++i) {
           circle(detectedCornersImg,cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(255, 255 , 255), -1, LINE_AA);
       }

//    drawKeypoints(mat, Keypoints, detectedCornersImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

//    // Color based detection
//    // Convert input image to HSV
//    cv::Mat hsv_image;
//    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//
//    // Threshold the HSV image, keep only the red pixels
//    cv::Mat lower_red_hue_range;
//    cv::Mat upper_red_hue_range;
//
//    cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_red_hue_range);
//    cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_red_hue_range);
//
//    // Combine the above two images
//    cv::Mat red_hue_image;
//    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);
//    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2);
//
    Mat canny_output;
    vector<vector<cv::Point> > contours;
    vector<Vec4i> hierarchy;

//     detect edges using canny
    Canny( detectedCornersImg, canny_output, 50, 150, 3 );

    // find contours
    findContours( canny_output, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );

    // get the moments
    vector<Moments> mu(contours.size());
    for( int i = 0; i<contours.size(); i++ )
    {
        mu[i] = moments( contours[i], false ); }

    // get the centroid of figures.
    vector<Point2f> mc(contours.size());
    for( int i = 0; i<contours.size(); i++)
    {
        mc[i] = Point2f( mu[i].m10/mu[i].m00 , mu[i].m01/mu[i].m00 ); }


//    draw contours
//        Mat drawing(canny_output.size(), CV_8UC3, Scalar(255,255,255));
//        for( int i = 0; i<contours.size(); i++ )
//        {
//            Scalar color = Scalar(167,151,0); // B G R values
//            drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, cv::Point());
//            circle( drawing, mc[i], 4, color, -1, 8, 0 );
//        }

    int x1 = static_cast<int>(mc[0].x);
    int y1 = static_cast<int>(mc[0].y);

    int x2 = static_cast<int>(mc[2].x);
    int y2 = static_cast<int>(mc[2].y);

    int x3 = static_cast<int>(mc[4].x);
    int y3 = static_cast<int>(mc[4].y);

    int x4 = static_cast<int>(mc[6].x);
    int y4 = static_cast<int>(mc[6].y);


    int notSort [4][2] = { {x1, y1}, {x2, y2}, {x3,y3}, {x4,y4} };

    if (mc.size() != 8){

        cout <<"@Error: size is not 8"<< endl;
        cout << mc.size() << endl;

    }

    cout <<"0. mc size is ==="<<mc.size()<< endl;

    int lowerIndex = 0;
    int higherIndex = 0;


    for( int i = 0; i<4; i++ ){
        for( int j = i+1; j<4; j++){

            if (notSort[j][0] < notSort[i][0]){
                higherIndex = i;
                lowerIndex = j;
                //{higherIndex , ... , lowerIndex}
                // output: { lowerIndex, ..., higherIndex}

                // store var of higherIndex values
                int temp1 = notSort[i][0];
                int temp2 = notSort[i][1];

                //higherIndex equal lowerIndex
                notSort[higherIndex][0] = notSort[lowerIndex][0];
                notSort[higherIndex][1] = notSort[lowerIndex][1];

                // lower equals higher
                notSort[lowerIndex][0] = temp1;
                notSort[lowerIndex][1] = temp2;

            }
        }
    }

    int dis12 = sqrt(pow(notSort[1][0] - notSort[2][0], 2) +
                     pow(notSort[1][1] - notSort[2][1], 2));

    int dis13 = sqrt(pow(notSort[1][0] - notSort[3][0], 2) +
                     pow(notSort[1][1] - notSort[3][1], 2));


    if( dis12 > dis13 ){
        int temp1 = notSort[2][0];
        int temp2 = notSort[2][1];

        //higherIndex equal lowerIndex
        notSort[2][0] = notSort[3][0];
        notSort[2][1] = notSort[3][1];

        // lower equals higher
        notSort[3][0] = temp1;
        notSort[3][1] = temp2;
    }


    UIBezierPath* p = [UIBezierPath bezierPath];

     [p moveToPoint:CGPointMake(notSort[0][0], notSort[0][1])];

     [p addLineToPoint:CGPointMake(notSort[1][0], notSort[1][1])];

     [p addLineToPoint:CGPointMake(notSort[2][0], notSort[2][1])];

     [p addLineToPoint:CGPointMake(notSort[3][0], notSort[3][1])];

//    UIImage* i1 = [self cropImage:image withPath:p sortedArray:notSort];
//    UIImage *maskedShapesImg = MatToUIImage(detectedCornersImg);

//    Sara's
    cv::Mat src;
         UIImageToMat(image, src);
        vector<cv::Point> not_a_rect_shape;
        not_a_rect_shape.push_back(cv::Point(notSort[0][0],notSort[0][1]));
        not_a_rect_shape.push_back(cv::Point(notSort[1][0],notSort[1][1]));
        not_a_rect_shape.push_back(cv::Point(notSort[2][0],notSort[2][1]));
        not_a_rect_shape.push_back(cv::Point(notSort[3][0],notSort[3][1]));


    // For debugging purposes, draw green lines connecting those points
      // and save it on disk
      const cv::Point* point = &not_a_rect_shape[0];
      int n = (int)not_a_rect_shape.size();
      Mat draw = src.clone();
      polylines(draw, &point, &n, 1, true, Scalar(0, 255, 0), 3, CV_AA);
      imwrite("draw.jpg", draw);

      // Assemble a rotated rectangle out of that info
      RotatedRect box = minAreaRect(cv::Mat(not_a_rect_shape));
      std::cout << "Rotated box set to (" << box.boundingRect().x << "," << box.boundingRect().y << ") " << box.size.width << "x" << box.size.height << std::endl;

      Point2f pts[4];

      box.points(pts);


               // Does the order of the points matter? I assume they do NOT.
               // But if it does, is there an easy way to identify and order
               // them as topLeft, topRight, bottomRight, bottomLeft?

               cv::Point2f src_vertices[3];
               src_vertices[0] = pts[0];
               src_vertices[1] = pts[1];
               src_vertices[2] = pts[3];
               //src_vertices[3] = not_a_rect_shape[3];

            Point2f dst_vertices[3];
//                  dst_vertices[0] = cv::Point(0, 0);
              if(box.size.width > box.size.height){
                  dst_vertices[1] = cv::Point(0, 0);
                  dst_vertices[0] = cv::Point(0, box.boundingRect().height-1);
                  dst_vertices[2] = cv::Point(box.boundingRect().width-1, box.boundingRect().height-1);
                  cout << "In CASE ONE" << endl;
              } else{
                  dst_vertices[0] = cv::Point(0, 0);
                  dst_vertices[1] = cv::Point(box.boundingRect().width-1, 0);
                  dst_vertices[2] = cv::Point(0, box.boundingRect().height-1);
                  cout << "In CASE TWO" << endl;
              }


              /* Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);

               cv::Mat rotated;
               cv::Size size(box.boundingRect().width, box.boundingRect().height);
               warpPerspective(src, rotated, warpMatrix, size, INTER_LINEAR, BORDER_CONSTANT);*/
               Mat warpAffineMatrix = getAffineTransform(src_vertices, dst_vertices);

               cv::Mat rotated;
               cv::Size size(box.boundingRect().width, box.boundingRect().height);
               warpAffine(src, rotated, warpAffineMatrix, size, INTER_LINEAR, BORDER_CONSTANT);

    return MatToUIImage(rotated);
//    return i1;
//    return maskedShapesImg;


}

+(UIImage*) cropImage:(UIImage*)image withPath:(UIBezierPath*)path sortedArray:(int[4][2])points { // where the UIBezierPath is defined in the UIKit coordinate system (0,0) is top left
    points[1][1] = {(static_cast<void>(1),1)};
    CGRect r = CGPathGetBoundingBox(path.CGPath); // the rect to draw our image in (minimum rect that the path occupies).

    UIGraphicsBeginImageContextWithOptions(r.size, NO, image.scale); // begin image context, with transparency & the scale of the image.
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextTranslateCTM(ctx, -r.origin.x, -r.origin.y); // translate context so that when we add the path, it starts at (0,0).

    CGContextAddPath(ctx, path.CGPath); // add path.
    CGContextClip(ctx); // clip any future drawing to the path region.

    [image drawInRect:(CGRect){CGPointZero, image.size}]; // draw image

    UIImage* i = UIGraphicsGetImageFromCurrentImageContext(); // get image from context
    UIGraphicsEndImageContext(); // clean up and finish context

    // Perspective fix code
//    cv::Mat img;
//    UIImageToMat(i, img);
//
//    vector<cv::Point> not_a_rect_shape;
//    not_a_rect_shape.push_back(cv::Point(points[1][0], points[1][1]));
//    not_a_rect_shape.push_back(cv::Point(points[3][0], points[3][1]));
//    not_a_rect_shape.push_back(cv::Point(points[0][0], points[0][1]));
//    not_a_rect_shape.push_back(cv::Point(points[2][0], points[2][1]));
//
//    std::cout << "array values 1) " << points[0][0]<< "," << points[0][1]<< ", 2) " << points[1][0]<< "," << points[1][1]<< ", 3) " << points[2][0] << "," << points[2][1] << ", 4) " <<points[3][0]<< "," <<  points[3][1] << std::endl;
//
//    RotatedRect box = minAreaRect(cv::Mat(not_a_rect_shape));
//    std::cout << "Rotated box set to (" << box.boundingRect().x << "," << box.boundingRect().y << ") " << box.size.width << "x" << box.size.height << std::endl;
//
//    //Point2f pts[4];
//
////    box.points(pts);
//
//    // Identify right order ? as topLeft, topRight, bottomRight, bottomLeft
////    std::cout << "pts values 1) " << pts[0]<< ", 2) " << pts[1]<< ", 3) " << pts[2] << ", 4) " << pts[3] << std::endl;
//////    pts values 1) [-4.53931, 415.486], 2) [116, 0.999977], 3) [970.539, 249.514], 4) [850, 664]
////    pts values 1) [-4.48245, 415.819], 2) [116, 1.00002], 3) [970.482, 249.181], 4) [850, 664]
////    pts values 1) [-3.00824, 467.133], 2) [126, 1], 3) [971.008, 234.866], 4) [842, 701]
//
//    cv::Point2f src_vertices[4];
//        src_vertices[0] = not_a_rect_shape[0];
//        src_vertices[1] = not_a_rect_shape[1];
//        src_vertices[2] = not_a_rect_shape[2];
//        src_vertices[3] = not_a_rect_shape[3];
//
////    0,1,2,3  extended line
////    1,0,2,3  extra extended line
////    2,0,1,3  black
////    0,2,1,3  black
////    1,2,0,3  extra extended line
////    2,1,0,3  extra extended line
////    3,1,0,2  extended line
////    1,3,0,2  extra extended vertical line
////    0,3,1,2  black
////    3,0,1,2  black
////    1,0,3,2  extra extended line
////    0,1,3,2  extended line
////    0,2,3,1  black
////    2,0,3,1  black
////    3,0,2,1  black
////    0,3,2,1  black
////    2,3,0,1  black
////    3,2,0,1  black
////    3,2,1,0  black
////    2,3,1,0  black
////    1,3,2,0  extra extended vertical line
////    3,1,2,0  extended line
////    2,1,3,0  extra extended line
////    1,2,3,0  extra extended line
//
//    Point2f dst_vertices[4];
////            dst_vertices[0] = cv::Point(0, 0);
////            dst_vertices[1] = cv::Point(960,0);
////            dst_vertices[2] = cv::Point(0,540);
////            dst_vertices[3] = cv::Point(960,540);
//        dst_vertices[0] =  cv::Point(0, 0);
////    cv::Point(0, box.boundingRect().height);
//    dst_vertices[1] = cv::Point(box.boundingRect().width, 0);
//        dst_vertices[2] = cv::Point(0, box.boundingRect().height);
//        dst_vertices[3] = cv::Point(box.boundingRect().width-1, box.boundingRect().height-1);
//
//     Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);
//
//        cv::Mat rotated;
//        cv::Size size(box.boundingRect().width, box.boundingRect().height);
//        cv::warpPerspective(img, rotated, warpMatrix, size, INTER_LINEAR, BORDER_CONSTANT);
//
////    Mat warpAffineMatrix = getAffineTransform(src_vertices, dst_vertices);
////
////    cv::Mat rotated;
////        cv::Size size(box.boundingRect().width, box.boundingRect().height);
////        warpAffine(img, rotated, warpAffineMatrix, size, INTER_LINEAR, BORDER_CONSTANT);
//    Sara's
//    cv::Mat src;
//            UIImageToMat(image, src);
//           vector<cv::Point> not_a_rect_shape;
//           not_a_rect_shape.push_back(cv::Point(points[0][0],points[0][1]));
//           not_a_rect_shape.push_back(cv::Point(points[1][0],points[1][1]));
//           not_a_rect_shape.push_back(cv::Point(points[2][0],points[2][1]));
//           not_a_rect_shape.push_back(cv::Point(points[3][0],points[3][1]));
//
//
//            // For debugging purposes, draw green lines connecting those points
//            // and save it on disk
//            const cv::Point* point = &not_a_rect_shape[0];
//            int n = (int)not_a_rect_shape.size();
//            Mat draw = src.clone();
//            polylines(draw, &point, &n, 1, true, Scalar(0, 255, 0), 3, CV_AA);
//            imwrite("draw.jpg", draw);
//
//            // Assemble a rotated rectangle out of that info
//            RotatedRect box = minAreaRect(cv::Mat(not_a_rect_shape));
//            std::cout << "Rotated box set to (" << box.boundingRect().x << "," << box.boundingRect().y << ") " << box.size.width << "x" << box.size.height << std::endl;
//
//            Point2f pts[4];
//
//            box.points(pts);
//
//            // Does the order of the points matter? I assume they do NOT.
//            // But if it does, is there an easy way to identify and order
//            // them as topLeft, topRight, bottomRight, bottomLeft?
//
//            cv::Point2f src_vertices[3];
//            src_vertices[0] = pts[0];
//            src_vertices[1] = pts[1];
//            src_vertices[2] = pts[3];
//            //src_vertices[3] = not_a_rect_shape[3];
//
//            Point2f dst_vertices[3];
//            dst_vertices[0] = cv::Point(0, 0);
//            dst_vertices[1] = cv::Point(box.boundingRect().width-1, 0);
//            dst_vertices[2] = cv::Point(0, box.boundingRect().height-1);
//
//           /* Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);
//
//            cv::Mat rotated;
//            cv::Size size(box.boundingRect().width, box.boundingRect().height);
//            warpPerspective(src, rotated, warpMatrix, size, INTER_LINEAR, BORDER_CONSTANT);*/
//            Mat warpAffineMatrix = getAffineTransform(src_vertices, dst_vertices);
//
//            cv::Mat rotated;
//            cv::Size size(box.boundingRect().width, box.boundingRect().height);
//            warpAffine(src, rotated, warpAffineMatrix, size, INTER_LINEAR, BORDER_CONSTANT);
//
//
//        return deskew(i1, computeSkew(i1));
    return i;
//
//        return MatToUIImage(draw);

//    UIImage *rotatedImg = MatToUIImage(rotated);

//    return rotatedImg; // return image

}


@end

// Circles code

//    // Use the Hough transform to detect circles in the combined threshold image ( parameters 6 and 7 need to be tuned)
//        std::vector<cv::Vec3f> circles;
//        cv::HoughCircles(red_hue_image, circles, CV_HOUGH_GRADIENT, 1, red_hue_image.rows/10, 110, 30, 0, 0);
//
//    // Loop over all detected circles and outline them on the original image
//        if(circles.size() == 0) std::exit(-1);
//        for(size_t current_circle = 0; current_circle < circles.size(); ++current_circle) {
//            cv::Point center(std::round(circles[current_circle][0]), std::round(circles[current_circle][1]));
//            int radius = std::round(circles[current_circle][2]);
//
//            cv::circle(red_hue_image, center, radius, cv::Scalar(0, 255, 0), 5);
//        }

// Sarah's code :

//+ (UIImage *)detectRedShapesInImage:(UIImage *)image{
//    cv::Mat mat;
//    UIImageToMat(image, mat);
//    cv::medianBlur(mat, mat, 3);
//
//    // Convert input image to HSV
//    cv::Mat hsv_image;
//    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//
//    // Threshold the HSV image, keep only the red pixels
//    // it wil detect blue objects not red :)
//    cv::Mat lower_red_hue_range;
//    cv::Mat upper_red_hue_range;
//    cv::inRange(hsv_image, cv::Scalar(0, 100, 100), cv::Scalar(10, 255, 255), lower_red_hue_range);
//    cv::inRange(hsv_image, cv::Scalar(160, 100, 100), cv::Scalar(179, 255, 255), upper_red_hue_range);
//
//    // Combine the above two images
//    cv::Mat red_hue_image;
//    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);
//    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2);
//
//
//    // detect circules, for now it doesnot take all circles
//    std::vector<cv::Vec4f> circles;
//    cv::HoughCircles(red_hue_image, circles, cv::HOUGH_GRADIENT, 1.0, 20,  150, 40, 0, 0);
//
//    // Loop over all detected circles and outline them on the original image
//    if(circles.size() == 0) std::exit(-1);
//    for(size_t current_circle = 0; current_circle < circles.size(); ++current_circle) {
//        cv::Point center(std::round(circles[current_circle][0]), std::round(circles[current_circle][1]));
//        int radius = std::round(circles[current_circle][2]);
//
//        cv::circle(red_hue_image, center, radius, cv::Scalar(0, 255, 0), 5);
//
//    }
//
//
//    UIImage *maskedShapesImg = MatToUIImage(red_hue_image);
//
//    return maskedShapesImg;

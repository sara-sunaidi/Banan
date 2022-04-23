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
bool coordinatesStatus = true;

// define hash table
string word = "";
const int s = 32;
int ii = 0;
struct item{
    int key;
    string value;
};
item* ht[s];


@implementation OpenCVWrapper

//add item to hash table
void addItem(int k, string v){
    cout << " ### inside AddItem" << endl;
    ht[ii]= new item;
    ht[ii]->key= k;
    ht[ii]->value= v;
    
    ii = ii+1;
}

void addKv(){
    ii = 0;
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
        if(ht[j]->key == k){
            cout << " ### inside searchK if statement" << endl;
            word= word+ht[j]->value;}
    }
}

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

// Braille Detection Code :D v

//+ (NSString *)checkCorners:(UIImage *)image{
//
//    cv::Mat mat;
//    UIImageToMat(image, mat);
//    cv::medianBlur(mat, mat, 3);
//
//
//
//    // Convert input image to HSV
//    cv::Mat hsv_image;
//    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//
//    vector<Mat> channels;
//    split(hsv_image,channels);
//
//    equalizeHist(channels[0], channels[0]); // HSV
//
//
//    merge(channels,hsv_image);
//
//    // Threshold the HSV image, keep only the blue pixels
//    cv::Mat lower_blue_hue_range;
//    cv::Mat upper_blue_hue_range;
//
//    cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_blue_hue_range);
//    cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_blue_hue_range);
//
//    // Combine the above two images
//    cv::Mat blue_hue_image;
//    cv::addWeighted(lower_blue_hue_range, 1.0, upper_blue_hue_range, 1.0, 0.0, blue_hue_image);
//    cv::GaussianBlur(blue_hue_image, blue_hue_image, cv::Size(9, 9), 2, 2);
//
//    // Switch Black&White
//    cv::bitwise_not(blue_hue_image, blue_hue_image);
//
//    // Detect blue blobs only
//    cv::SimpleBlobDetector::Params params;
//    params.filterByArea = true;
//    params.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//
//    params.filterByCircularity = true;
//    //        params.maxCircularity = 0.8;
//    params.minCircularity = 0.75;// squares are 0.785
//
//    cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
//    std::vector<cv::KeyPoint> keypoints;
//    blobDetector->detect(blue_hue_image, keypoints); //red_hue_image
//
//    cout << "- detected corners number is " << keypoints.size() <<endl;
//    bool exist = true;
//
//    if(keypoints.size() != 4){
//        cout << "- missing corners condition" << endl;
//        exist = false;
//        // return 1;
//    }
//
//
//    if(exist){
//        return [NSString stringWithFormat:@"true",  CV_VERSION];
//    }
//    return [NSString stringWithFormat:@"false",  CV_VERSION];
//}
//
//+ (NSString *)detectRedShapesInImage:(UIImage *)image{
//
//    // reset variables
//    coordinatesStatus = true;
//    word = "";
//
//    // set up hash table
//    addKv();
//
//    cv::Mat mat;
//    UIImageToMat(image, mat);
//
//    //  0) Preprossesing:
//
//    // Flipping the image to get mirror effect
//    cv::flip(mat, mat, 1);
//
//    // Filter the input image to reduce noise
//    cv::medianBlur(mat, mat, 3);
//
//    cv::Mat hsv_image;
//
////    // shallow circles
////    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2RGB);
////    cv::cvtColor(mat, hsv_image, cv::COLOR_RGB2HSV);
//
//    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//
////    vector<Mat> channels;
////    split(hsv_image,channels);
////
////    equalizeHist(channels[0], channels[0]); // HSV
////
////    merge(channels,hsv_image);
//
//
//
//
//    // 1) Threshold the HSV image, keep only the red pixels
//    cv::Mat lower_red_hue_range;
//    cv::Mat upper_red_hue_range;
//    // BGR  == RGB
//    cv::inRange(hsv_image, cv::Scalar(38, 38, 128), cv::Scalar(48, 255, 255), lower_red_hue_range);
//    cv::inRange(hsv_image, cv::Scalar(113, 128, 38), cv::Scalar(123, 255, 255), upper_red_hue_range);
//
//    //  Sara's Scales :
////        cv::inRange(hsv_image, cv::Scalar(32, 22, 0), cv::Scalar(42, 255, 255), lower_red_hue_range);
////        cv::inRange(hsv_image, cv::Scalar(103,142, 160), cv::Scalar(113,255,255), upper_red_hue_range);
////
////            cv::inRange(hsv_image, cv::Scalar(0, 125, 0), cv::Scalar(255, 130, 255), lower_red_hue_range);
////            cv::inRange(hsv_image, cv::Scalar(0, 100, 0), cv::Scalar(255, 105, 255), upper_red_hue_range);
//
////    // somehow green
////    cv::inRange(hsv_image, cv::Scalar(0, 180, 0), cv::Scalar(105, 255, 255), lower_red_hue_range);
////    cv::inRange(hsv_image, cv::Scalar(0, 100, 0), cv::Scalar(65, 255, 255), upper_red_hue_range);
//
//    // shallow circles
////    cv::inRange(hsv_image, Scalar(0, 70, 50), Scalar(10, 255, 255), lower_red_hue_range);
////    cv::inRange(hsv_image, Scalar(0, 70, 50), Scalar(10, 255, 255), upper_red_hue_range);
//
//    // blue
////    cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_red_hue_range);
////    cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_red_hue_range);
//
////    cv::inRange(hsv_image, Scalar (75, 150, 105), Scalar(80, 255, 255), lower_red_hue_range);
////    cv::inRange(hsv_image, Scalar (90, 165, 120), Scalar(95, 255, 255), upper_red_hue_range);
//
////    cv::Mat black = cv::Mat(mat.rows, mat.cols, mat.type(), Scalar(38, 38, 128)); // RGB
////    double beta = (1.0 - 0.2); // The lower the alpha value is, the darker the image.
////    cv::Mat colored;
////    cv::addWeighted(mat, 0.2, black, beta, 0.0, colored);
//
//    // Combine the above two range images
//    cv::Mat red_hue_image;
//    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);
//
//   // Switch Black&White
//    cv::bitwise_not(red_hue_image, red_hue_image);
//
//    // 2) Blur to remove noise:
//    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2); // try increasing
//
//    // Pre-prosseing
//
//    //              -- هنا فيه حوسة شوي لاننا قاعدين نجرب عدة طرق لتحسين الديتيكشن للاحمر --                //
//
//    // 1st Method
//
//    //adaptiveThreshold(red_hue_image, red_hue_image, 255, CV_ADAPTIVE_THRESH_MEAN_C, CV_THRESH_BINARY, 21, 10);
//    //    Mat morphologyElement3x3 = getStructuringElement(MORPH_RECT, cv::Size(1, 1));
//    //    GaussianBlur(red_hue_image, red_hue_image, cv::Size(1, 1), 0);
//    //
//    //    erode(red_hue_image, red_hue_image, morphologyElement3x3);
//
//    //threshold(red_hue_image, red_hue_image, 21, 255, CV_THRESH_BINARY);
//
////    cv::Mat b = cv::Mat(red_hue_image.rows, red_hue_image.cols, red_hue_image.type(), 0.0);
//   //       double betaa = (1.0 - 0.3); // The lower the alpha value is, the darker the image.
//   //       cv::Mat blackenedd;
//   //       cv::addWeighted(red_hue_image, 0.3, b, betaa, 0.0, red_hue_image);
//   //     Define the structuring elements
//
//
//
//
//
//
////
//    // 3nd method
//
////    int morph_size = 0;
////    Mat element = getStructuringElement(
////                                        MORPH_RECT, cv::Size(2 * morph_size + 1,
////                                                             2 * morph_size + 1),
////                                        cv::Point(morph_size, morph_size));
////
////    GaussianBlur(red_hue_image, red_hue_image, cv::Size(1, 1), 0);
////
////    erode(red_hue_image, red_hue_image, element, cv::Point(-1, -1), 20);
//
//
//    // 3) Detect blobs:
//
//    Mat canny_output;
//    vector<vector<cv::Point> > contours;
//    vector<Vec4i> hierarchy;
//
//    // detect edges using canny
//    Canny( red_hue_image, canny_output, 50, 150, 3 );
//
//    // find contours
//    findContours( canny_output, contours, hierarchy, CV_RETR_TREE, CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
////    findContours( canny_output, contours, hierarchy, Imgproc.RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
//    double MaxAreaContour = 2500;
//    double MinAreaContour = 25;
//
//    Mat drawing = cv::Mat(red_hue_image.rows, red_hue_image.cols, red_hue_image.type(), 0.0);
//    //Mat::zeros( canny_output.size(), CV_8UC3 );
//
//
//    // remove child contours
////    for( int i = 0; i< contours.size(); i=hierarchy[i][0] ) // iterate through each contour.
////         {
////
////           if(hierarchy[i][2]<0){
////               drawContours(drawing, contours, i, Scalar(0, 255, 0), CV_FILLED);
//////               rectangle(src,Point(r.x,r.y), Point(r.x+r.width,r.y+r.height), Scalar(0,0,255),3,8,0);
//////               count++;
////           }
////         }
//       RNG rng(12345);
//
//       vector<vector<cv::Point> > contours_poly( contours.size() );
//       vector<cv::Rect> boundRect( contours.size() );
//       vector<Point2f>centers( contours.size() );
//       vector<float>radius( contours.size() );
//       for( size_t i = 0; i < contours.size(); i++ )
//       {
//           approxPolyDP( contours[i], contours_poly[i], 0.3, true );
//           boundRect[i] = boundingRect( contours_poly[i] );
//           minEnclosingCircle( contours_poly[i], centers[i], radius[i] );
//       }
//    for( size_t i = 0; i< contours.size(); i++ )
//        {
//            double AreaContour=cv::contourArea(contours[i]);
//            if( AreaContour > MinAreaContour ){
////                if (hierarchy[i][3] != -1 ) {
//                drawContours( drawing, contours_poly, (int)i, Scalar(255, 255, 255) );
//                circle( drawing, centers[i], (int)radius[i], Scalar(255, 255, 255),CV_FILLED );
////                }
//
//            }
//        }
//
//    // Switch Black&White
//     cv::bitwise_not(drawing, drawing);
//
////    for(int i=0;i<contours.size();i++)
////    {
////        double AreaContour=cv::contourArea(contours[i]);
////        if( AreaContour > MinAreaContour && AreaContour< MaxAreaContour){
////            drawContours(red_hue_image, contours, i, Scalar(0, 255, 255),10, CV_FILLED);
////            circle( red_hue_image, centers[i], (int)radius[i], Scalar(0, 255, 255), CV_FILLED );
//////            if (hierarchy[i][2] == -1 ) {
////           ////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
//////                       drawContours(drawing, contours, i, Scalar(255, 0, 0), CV_FILLED, 8, hierarchy,2);   // fill BLUE
//////                               }
////        }
////    }
//
//    // 2nd method
////
////    Mat element = getStructuringElement(MORPH_RECT, cv::Size(3, 3));
////   //
////       erode(red_hue_image, red_hue_image, element, cv::Point(-1, -1), 1);
//   //    dilate(binarized, binarized, element, cv::Point(-1, -1), 4);
////    Erode(red_hue_image, red_hue_image, 0, 1);
//
////    Mat se1 = getStructuringElement(MORPH_RECT, cv::Size(19, 19)); // 23
//////    Mat se2 = getStructuringElement(MORPH_RECT, cv::Size(3, 3)); // 3
//////// Perform closing then opening
//////
////   morphologyEx(red_hue_image, red_hue_image, MORPH_CLOSE, se1);
////   morphologyEx(red_hue_image, red_hue_image, MORPH_OPEN, se2);
//
//
////            Mat se1 = getStructuringElement(MORPH_RECT, cv::Size(17, 17)); // 23
////            Mat se2 = getStructuringElement(MORPH_RECT, cv::Size(2, 2)); // 3
////        // Perform closing then opening
////           Mat mask;
////           morphologyEx(red_hue_image, red_hue_image, MORPH_CLOSE, se1);
////           morphologyEx(red_hue_image, red_hue_image, MORPH_OPEN, se2);
////
////            Mat se3 = getStructuringElement(MORPH_RECT, cv::Size(10 ,10)); // 23
////            Mat se4 = getStructuringElement(MORPH_RECT, cv::Size(10, 10));
//
////            morphologyEx(red_hue_image, red_hue_image, MORPH_CLOSE, se3);
////            morphologyEx(red_hue_image, red_hue_image, MORPH_OPEN, se4);
//
//
//
//
//    // Combine the above two range images
//
////    cv::Mat b = cv::Mat(red_hue_image.rows, red_hue_image.cols, red_hue_image.type(), 0.0);
////    double betaa = (1.0 - 0.7); // The lower the alpha value is, the darker the image.
////    cv::Mat blackenedd;
////    cv::addWeighted(red_hue_image, 0.3, b, betaa, 0.0, red_hue_image);
////    cv::Mat merged;
////    cv::addWeighted(red_hue_image, 0.7, drawing, betaa, 255, merged);
//
////    merge(drawing,red_hue_image);
//
////    for(int i=0;i<contours.size();i++)
////        {
////          double AreaContour=cv::contourArea(contours[i]);
//////            cout << "@  "<< i <<" - AreaContour  " << AreaContour << endl;
////            if( AreaContour>MinAreaContour){
////                cout << " - AreaContour in IF " << endl;
//////                if ( hierarchy[i][0] != -1 ) {
////                if (hierarchy[i][3] != -1 ) {
////                    cout << " - AreaContour out IF " << endl;
////                    drawContours(drawing, contours, i, Scalar(0, 255, 0), CV_FILLED, 8, hierarchy, 2);
////                }
////                    if (hierarchy[i][3] == -1 ) {
//////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
////            drawContours(drawing, contours, i, Scalar(255, 0, 0), CV_FILLED, 8, hierarchy,2);   // fill BLUE
////                    }
////
////                if (hierarchy[1][i] == -1 ) {
//////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
////        drawContours(drawing, contours, i, Scalar(0, 0, 255), CV_FILLED, 8, hierarchy,2);   // fill BLUE
////                }
////
////                if (hierarchy[i][1] == -1 ) {
//////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
////        drawContours(drawing, contours, i, Scalar(255, 255, 255), CV_FILLED, 8, hierarchy,2);   // fill BLUE
////                }
////                if (hierarchy[i][0] == -1 ) {
//////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
////        drawContours(drawing, contours, i, Scalar(255, 140, 255), CV_FILLED, 8, hierarchy,2);   // fill BLUE
////                }
////
//////                if (hierarchy[i][0] != -1 ) {
////////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
//////        drawContours(drawing, contours, i, Scalar(255, 140, 255), CV_FILLED, 8, hierarchy);   // fill BLUE
//////                }
//////
//////                if (hierarchy[i][1] != -1 ) {
////////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
//////        drawContours(drawing, contours, i, Scalar(255, 140, 255), CV_FILLED, 8, hierarchy);   // fill BLUE
//////                }
//////                if (hierarchy[i][2] != -1 ) {
////////            drawContours(Result,contours,i,Scalar(255, 0, 0),Thickness,LineType,cv::noArray(),2147483647,cv::Point(DrawOffset_x,DrawOffset_y));
//////        drawContours(drawing, contours, i, Scalar(255, 140, 255), CV_FILLED, 8, hierarchy);   // fill BLUE
//////                }
//////drawContours(drawing, contours, i, Scalar(255, 140, 255), CV_FILLED, 8, hierarchy);
//////                }
////
////            }
////        }
//
////    // 2nd round
////    Canny( drawing, canny_output, 50, 150, 3 );
////
////    findContours( canny_output, contours, hierarchy, CV_RETR_EXTERNAL, CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
////
////    Mat secondDrawing = Mat::zeros( canny_output.size(), CV_8UC3 );
////
////       vector<cv::Point> approxShape;
////       for(int i=0; i < contours.size(); i++){
//////           approxPolyDP(contours[i], approxShape, arcLength(Mat(contours[i]), true)*0.04, true);
////           drawContours(secondDrawing, contours, i, Scalar(255, 0, 0), CV_FILLED);   // fill BLUE
////       }
//
//
//    // draw contours
////        Mat drawing(canny_output.size(), CV_8UC3, Scalar(255,255,255));
////        for( int i = 0; i<contours.size(); i++ )
////        {
////            Scalar color = Scalar(167,151,0); // B G R values
////            drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, cv::Point());
//////            circle( drawing,cv::Point(),4, Scalar(255,0,0), CV_FILLED, 8, 0 );
////        }
////    circle( drawing,  i, 4, Scalar(255,0,0), CV_FILLED, 8, 0 );
////    circle(drawing, cv::Point(50,50),50, Scalar(255,0,0),CV_FILLED, 8,0);
//
//
////    cv::Mat b = cv::Mat(red_hue_image.rows, red_hue_image.cols, red_hue_image.type(), 0.0);
////    double betaa = (1.0 - 0.3); // The lower the alpha value is, the darker the image.
////    cv::Mat blackenedd;
////    cv::addWeighted(red_hue_image, 0.3, b, betaa, 0.0, red_hue_image);
//
//    // Detect red blobs only
//    cv::SimpleBlobDetector::Params params;
//    params.filterByArea = true;
//    params.minArea =  600.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//    params.maxArea = 10000.0f;
//    // random params
////    params.minThreshold = 0;
//////    params.filterByColor = false;
//////    params.blobColor = 0;
////    params.filterByArea = true;
////    params.minArea = 500;
//////    params.maxArea = 5000;
////    params.filterByCircularity = true;
////    params.minCircularity =.4;
////    params.maxCircularity = 1;
//
//
//    //            params.maxArea =  20000.0f; //50.0f * 50.0f; //20.0f * 20.0f;
//    //            params.minDistBetweenBlobs = 1;
//
//    //            params.filterByCircularity = true;
//    //            params.minCircularity = 0;
//    //            params.maxCircularity = 3.4028234663852886e+38;
//
//    // The following two statements to detect white instead of black (default color)
//    //            params.filterByColor = true;
//    //            params.blobColor = 255;
//
//    cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
//    std::vector<cv::KeyPoint> keypoints;
//    blobDetector->detect(drawing, keypoints); //red_hue_image
//
//    bool exist = true;
//
//    // check keypoints existance & draw keypoints for displaying
//    if(keypoints.empty()){
//        cout << "- there is no braille keypoints condition" << endl;
//        exist = false;
//        // return 1;
//    }
//    cout << "- keypoints size " << keypoints.size() << endl;
//    // red blobs are detected
//    if (exist){
//
//        cv::Mat detectedImg = cv::Mat(drawing.size(), CV_8UC3);
//        drawKeypoints(drawing, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
////        addItem(MatToUIImage(detectedImg),0);
////        images[0] = detectedImg;
//
//        // Detect Black blobs
//
//            cv::Mat black = cv::Mat(mat.rows, mat.cols, mat.type(), 0.0);
//            double beta = (1.0 - 0.5); // The lower the alpha value is, the darker the image.
//            cv::Mat blackened;
//            cv::addWeighted(mat, 0.5, black, beta, 0.0, blackened);
//
//        // 1) Threshold the HSV image, keep only the black pixels
//        cv::Mat black_hue_range;
//
//        // Convert input image to HSV
//        cv::Mat black_hsv_image;
//        cv::cvtColor(blackened, black_hsv_image, cv::COLOR_BGR2HSV);
//
//        // BGR  == RGB
//        cv::inRange(black_hsv_image, cv::Scalar(0, 0, 0, 0), cv::Scalar(180, 255, 30, 0), black_hue_range);
//
//        // Switch Black&White
//        cv::bitwise_not(black_hue_range, black_hue_range);
//
//        cv::GaussianBlur(black_hue_range, black_hue_range, cv::Size(9, 9), 2, 2);
//      // enhancing black circles
////        Mat se1 = getStructuringElement(MORPH_RECT, cv::Size(1, 1));
////        Mat se2 = getStructuringElement(MORPH_RECT, cv::Size(15, 15));
////    // Perform closing then opening
////
////       morphologyEx(black_hue_range, black_hue_range, MORPH_CLOSE, se1);
////       morphologyEx(black_hue_range, black_hue_range, MORPH_OPEN, se2);
//
//        cv::SimpleBlobDetector::Params initParams;
////        initParams.filterByCircularity = true;
////        initParams.minCircularity = 0.84;
//
//        initParams.filterByArea = true;
//        initParams.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
////        initParams.maxArea =  1900.0f; //50.0f * 50.0f; //20.0f * 20.0f;
//
//        cv::Ptr<cv::SimpleBlobDetector> initBlobDetector = cv::SimpleBlobDetector::create(initParams);
//        std::vector<cv::KeyPoint> initKeypoints;
//        initBlobDetector->detect(black_hue_range, initKeypoints);
//
//        // Check keypoints existance & draw keypoints for displaying
//        if(initKeypoints.empty()){
//            cout << "- there is no braille initKeypoints condition" << endl;
//            // return 1;
//        }
//
//        cout << "- initKeypoints size " << initKeypoints.size() << endl;
//
//        cv::Mat blackCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
//        drawKeypoints(mat, initKeypoints, blackCoordinatesImg, cvScalar(94,206,165,255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//        // Union initKeypoints + keypoints
//        for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
////            cout << "@ loop" << i << endl;
//            initKeypoints.push_back(keypoints[i]);
//        }
//
//        cv::Mat detectedCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
//        drawKeypoints(mat, initKeypoints, detectedCoordinatesImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//
//
//        // 4) normalize keypoints to coordinate line set
//        float blobSize = 0.0f;
//        for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
//            blobSize += initKeypoints[i].size;
//        }
//
//        blobSize /= initKeypoints.size();
//        cout << "mean of the blob sizes : " << blobSize << endl;
//        vector<int> coordinateX;
//        vector<int> coordinateY;
//
//        for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
//            bool isNew = true;
//            for (vector<int>::iterator iter = coordinateX.begin(); iter < coordinateX.end(); ++iter) {
//                if(abs(*iter - initKeypoints[i].pt.x) < blobSize){
//                    isNew = false;
//                    break;
//                }
//            }
//            if(isNew){
//                coordinateX.push_back((int)initKeypoints[i].pt.x);
//            }
//
//            isNew = true;
//            for (vector<int>::iterator iter = coordinateY.begin(); iter < coordinateY.end(); ++iter) {
//                if(abs(*iter - initKeypoints[i].pt.y) < blobSize){
//                    isNew = false;
//                    break;
//                }
//            }
//
//            if(isNew){
//                coordinateY.push_back((int)initKeypoints[i].pt.y);
//            }
//        }
//        sort(coordinateX.begin(), coordinateX.end());
//        sort(coordinateY.begin(), coordinateY.end());
//
//        // draw coordinate lines for displaying
//        int cc = 0;
//        int rr = 0;
//        cout << "- coordinateX.size() " << coordinateX.size() << endl;
//        cout << "- coordinateY.size() " << coordinateY.size() << endl;
//
//        if(coordinateX.size()%2 != 0){ // cc%2 != 0
//            cout << "- removing odd column..." << endl;
//            coordinateX.pop_back();
//        }
//        cv::Mat coordinateImg = detectedImg.clone();
//        for (int i = 0; i < static_cast<int>(coordinateX.size()); ++i) {
//            line(coordinateImg, cv::Point(coordinateX[i], 0), cv::Point(coordinateX[i], coordinateImg.rows), cvScalar(255, 0, 0));
//            cc++;
//
//        }
//        for (int i = 0; i < static_cast<int>(coordinateY.size()); ++i) {
//            line(coordinateImg, cv::Point(0, coordinateY[i]), cv::Point(coordinateImg.cols, coordinateY[i]), cvScalar(255, 0, 0));
//            rr++;
//        }
//        cout << "- total c" << cc << endl;
//        cout << "- total r" << rr << endl;
//        // Check total Columns / Rowa
//        // Check total Columns / Rowa
//        if(rr != 3){ // cc%2 != 0
//            cout << "- image is skewed !! " << endl;
//            coordinatesStatus = false;
//        }
////        addItem(MatToUIImage(coordinateImg),1);
////        images[1] = coordinateImg;
//        if (coordinatesStatus) {
//        // 5) move keypoints to the nearest coordinate point
//        for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
//            int ditanceX = detectedCoordinatesImg.cols / 2;
//            int ditanceY = detectedCoordinatesImg.rows / 2;
//            int tempX = 0;
//            int tempY = 0;
//            for (int j = 0; j < static_cast<int>(coordinateX.size()); ++j) {
//                if(ditanceX > abs(keypoints[i].pt.x - coordinateX[j])){
//                    ditanceX = abs(keypoints[i].pt.x - coordinateX[j]);
//                    tempX = coordinateX[j];
//                }
//            }
//            keypoints[i].pt.x = tempX;
//
//            for (int j = 0; j < static_cast<int>(coordinateY.size()); ++j) {
//                if(ditanceY > abs(keypoints[i].pt.y - coordinateY[j])){
//                    ditanceY = abs(keypoints[i].pt.y - coordinateY[j]);
//                    tempY = coordinateY[j];
//                }
//            }
//            keypoints[i].pt.y = tempY;
//        }
//
//        // make image from the edited keypoint set(draw line for display)
//        Mat editedImg = Mat(detectedImg.size(), CV_8UC1); //here
//        editedImg.setTo(255);
//        for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
//            circle(editedImg, cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(0), -1, LINE_AA);
//        }
//
//        // optional
//        Mat editedwithLineImg = editedImg.clone();
//        for (int i = 0; i < static_cast<int>(coordinateX.size()); ++i) {
//            line(editedwithLineImg, cv::Point(coordinateX[i], 0), cv::Point(coordinateX[i], editedwithLineImg.rows), Scalar(0));
//        }
//        for (int i = 0; i < static_cast<int>(coordinateY.size()); ++i) {
//            line(editedwithLineImg, cv::Point(0, coordinateY[i]), cv::Point(editedwithLineImg.cols, coordinateY[i]), Scalar(0));
//        }
////        addItem(MatToUIImage(editedwithLineImg),2);
////        images[2] = editedwithLineImg;
//
//        // 6) segmentation braille rectangle
//        int startXPos = 0;
//        int index = 0;
//        vector<braille> brailleSet;
//        Mat segmentationImg = Mat(editedImg.size(), CV_8UC3);
//        cvtColor(editedImg, segmentationImg, COLOR_GRAY2BGR);
////        if((coordinateX[1] - coordinateX[0]) > (coordinateX[2] - coordinateX[1])){
////            startXPos = 1;
////        }
//        for(int i = 0; i < static_cast<int>(coordinateY.size()) - 2; i += 3){
//            cout << "inside segments for loop Y" << endl;
//            cout << "inside segments for loop Y | Y coordinate -> " << coordinateY[i] <<endl;
//            cout << "inside segments for loop Y | X coordinate -> " << coordinateX[i] <<endl;
//            cout << "inside segments for loop Y | Start X Pos -> " << startXPos <<endl;
//            cout << "inside segments for loop Y | Coordinates X size -> " << coordinateX.size() <<endl;
//            for(int j = startXPos; j < static_cast<int>(coordinateX.size()) - 1; j += 2){
//                cout << "inside segments for loop X" << endl;
//                braille tempBraille;
//                cv::Rect rect = cv::Rect(cv::Point(coordinateX[j] - blobSize / 2, coordinateY[i] - blobSize / 2),
//                                         cv::Point(coordinateX[j + 1] + blobSize / 2, coordinateY[i + 2] + blobSize / 2));
//                int value = 0;
//                rectangle(segmentationImg, rect, Scalar(0, 0, 255));
//
//                // set the braille value(2x3 matrix)
//                for(int k = 0; k < 2; ++k){
//                    for(int l = 0; l < 3; ++l){
//                        if(editedImg.at<uchar>(cv::Point((int)coordinateX[j + k] , (int)coordinateY[i + l])) == 0){
//                            value++;
//                        }
//                        value = value << 1;
//                    }
//                }
//                value = value >> 1;
//                tempBraille.rect = rect;
//                tempBraille.index = index++;
//                tempBraille.value = value;
//                brailleSet.push_back(tempBraille);
//            }
//        }
//        if(brailleSet.empty()){
//            cout << "there is no braille segments !!" << endl;
//            // return 1;
//        }
//
//        // Missing Optional
//
//        //
//        //     7) make result image
//        cout << "inside step seven 1" << endl;
//        Mat resultImg = Mat(cv::Size(segmentationImg.size()), CV_8UC3);
//        resultImg.setTo(255);
//        addWeighted(resultImg, 0.8, segmentationImg, 0.2, 0.0,  resultImg);
//
//        int intFontFace = FONT_HERSHEY_SIMPLEX;
//        double dblFontScale = brailleSet[0].rect.size().width / 60.0;
//        int intFontThickness = (int)std::round(dblFontScale * 2);
//
//        for(int i = 0; i < static_cast<int>(brailleSet.size()); ++i){
//            cout << "inside step seven 2" << endl;
//            cv::Point center, bottomLeft;
//            center = (brailleSet[i].rect.tl() + brailleSet[i].rect.br()) / 2;
//            center.x -= getTextSize(to_string(brailleSet[i].value), intFontFace, dblFontScale, intFontThickness, 0).width / 2;
//            center.y += getTextSize(to_string(brailleSet[i].value), intFontFace, dblFontScale, intFontThickness, 0).height / 2;
//
//            bottomLeft = cv::Point(brailleSet[i].rect.tl().x, brailleSet[i].rect.br().y);
//            bottomLeft.x -= blobSize / 2;
//            bottomLeft.y += getTextSize(bitset<6>(brailleSet[i].value).to_string(), intFontFace, dblFontScale * 0.7, intFontThickness * 0.7, 0).height / 2 + blobSize / 2;
//
//            searchK(brailleSet[i].value);
//
//            putText(resultImg, to_string(brailleSet[i].value), center, intFontFace, dblFontScale, Scalar(255,0,0), intFontThickness);
//            putText(resultImg, bitset<6>(brailleSet[i].value).to_string(), bottomLeft, intFontFace, dblFontScale * 0.7, Scalar(0,0,0), intFontThickness * 0.7);
//
//            cout << "Blocks values" << endl;
//            cout <<i<< " - " << brailleSet[i].value << endl;
//        }
//        cout << "$$ the final string is " <<word<< endl;
//
//            return [NSString stringWithUTF8String:word.c_str()];
//        }
//        // IF invalid coordinates
//        return [NSString stringWithFormat:@"failed",  CV_VERSION];
//    }
//    // IF red blobs are not existing
//    return [NSString stringWithFormat:@"failed",  CV_VERSION];
//}
//
//+ (NSString *)getCoordinatesStatus{
//    if(coordinatesStatus){
//        return [NSString stringWithFormat:@"true",  CV_VERSION];
//    }
//    return [NSString stringWithFormat:@"false",  CV_VERSION];
//}
//
//+ (UIImage *)detectFourCorner:(UIImage *)image{
//
//    cv::Mat mat;
//    UIImageToMat(image, mat);
//    cv::medianBlur(mat, mat, 3);
//
//    // Color based detection
//        cv::Mat hsv_image;
//        // Convert input image to HSV
//        cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//
//        vector<Mat> channels;
//        split(hsv_image,channels);
//
//        equalizeHist(channels[0], channels[0]); // HSV
//
//
//        merge(channels,hsv_image);
//
//        // Threshold the HSV image, keep only the blue pixels
//        cv::Mat lower_blue_hue_range;
//        cv::Mat upper_blue_hue_range;
//
//        cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_blue_hue_range);
//        cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_blue_hue_range);
//
//        // Combine the above two images
//        cv::Mat blue_hue_image;
//        cv::addWeighted(lower_blue_hue_range, 1.0, upper_blue_hue_range, 1.0, 0.0, blue_hue_image);
//        cv::GaussianBlur(blue_hue_image, blue_hue_image, cv::Size(9, 9), 2, 2);
//
//        // Switch Black&White
//        cv::bitwise_not(blue_hue_image, blue_hue_image);
//
//        // Detect blue blobs only
//        cv::SimpleBlobDetector::Params params;
//        params.filterByArea = true;
//        params.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//
//        params.filterByCircularity = true;
//    //        params.maxCircularity = 0.8;
//        params.minCircularity = 0.75;// squares are 0.785
//
//        cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
//        std::vector<cv::KeyPoint> keypoints;
//        blobDetector->detect(blue_hue_image, keypoints);
//
////    // Blob based Detection: to detect base 4 corner
////    cv::SimpleBlobDetector::Params Params;
////    Params.filterByArea = true;
////    Params.minArea =  50.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
////    Params.maxArea =  600.0f; //50.0f * 50.0f; //20.0f * 20.0f;
////
//
////    cv::Ptr<cv::SimpleBlobDetector> BlobDetector = cv::SimpleBlobDetector::create(Params);
////    std::vector<cv::KeyPoint> keypoints;
////    BlobDetector->detect(mat, keypoints);
//
////    // Check keypoints existance
////    if(keypoints.empty()){
////        cout << "there is no corner existance condition" << endl;
////        // return 1;
////    }
//    float blobSize = 0.0f;
//    for (int i = 0; i < keypoints.size(); ++i) {
//        blobSize += keypoints[i].size;
//    }
//    blobSize /= keypoints.size();
//
//    cv::Mat detectedCornersImg = cv::Mat(mat.size(), CV_8UC3);
//    detectedCornersImg.setTo(0);
//    for (int i = 0; i < keypoints.size(); ++i) {
//        circle(detectedCornersImg,cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(255, 255 , 255), -1, LINE_AA);
//    }
//
//    //    drawKeypoints(mat, Keypoints, detectedCornersImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//    //    // Color based detection
//    //    // Convert input image to HSV
//    //    cv::Mat hsv_image;
//    //    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
//    //
//    //    // Threshold the HSV image, keep only the red pixels
//    //    cv::Mat lower_red_hue_range;
//    //    cv::Mat upper_red_hue_range;
//    //
//    //    cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_red_hue_range);
//    //    cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_red_hue_range);
//    //
//    //    // Combine the above two images
//    //    cv::Mat red_hue_image;
//    //    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);
//    //    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2);
//    //
//    Mat canny_output;
//    vector<vector<cv::Point> > contours;
//    vector<Vec4i> hierarchy;
//
//    //     detect edges using canny
//    Canny( detectedCornersImg, canny_output, 50, 150, 3 );
//
//    // find contours
//    findContours( canny_output, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
//
//    // get the moments
//    vector<Moments> mu(contours.size());
//    for( int i = 0; i<contours.size(); i++ )
//    {
//        mu[i] = moments( contours[i], false ); }
//
//    // get the centroid of figures.
//    vector<Point2f> mc(contours.size());
//    for( int i = 0; i<contours.size(); i++)
//    {
//        mc[i] = Point2f( mu[i].m10/mu[i].m00 , mu[i].m01/mu[i].m00 ); }
//
//
//    // draw contours
//    //    Mat drawing(canny_output.size(), CV_8UC3, Scalar(255,255,255));
//    //    for( int i = 0; i<contours.size(); i++ )
//    //    {
//    //        Scalar color = Scalar(167,151,0); // B G R values
//    //        drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, cv::Point());
//    //        circle( drawing, mc[i], 4, color, -1, 8, 0 );
//    //    }
//
//    int x1 = static_cast<int>(mc[0].x);
//    int y1 = static_cast<int>(mc[0].y);
//
//    int x2 = static_cast<int>(mc[2].x);
//    int y2 = static_cast<int>(mc[2].y);
//
//    int x3 = static_cast<int>(mc[4].x);
//    int y3 = static_cast<int>(mc[4].y);
//
//    int x4 = static_cast<int>(mc[6].x);
//    int y4 = static_cast<int>(mc[6].y);
//
//
//    int notSort [4][2] = { {x1, y1}, {x2, y2}, {x3,y3}, {x4,y4} };
//
//    if (mc.size() != 8){
//
//        cout <<"oh there is a problem! size is not 8"<< endl;
//        cout << mc.size() << endl;
//
//    }
//
//    cout <<"0. mc size is == "<<mc.size()<< endl;
//
//    int lowerIndex = 0;
//    int higherIndex = 0;
//
//
//    for( int i = 0; i<4; i++ ){
//        for( int j = i+1; j<4; j++){
//
//            if (notSort[j][0] < notSort[i][0]){
//                higherIndex = i;
//                lowerIndex = j;
//                //{higherIndex , ... , lowerIndex}
//                // output: { lowerIndex, ..., higherIndex}
//
//                // store var of higherIndex values
//                int temp1 = notSort[i][0];
//                int temp2 = notSort[i][1];
//
//                //higherIndex equal lowerIndex
//                notSort[higherIndex][0] = notSort[lowerIndex][0];
//                notSort[higherIndex][1] = notSort[lowerIndex][1];
//
//                // lower equals higher
//                notSort[lowerIndex][0] = temp1;
//                notSort[lowerIndex][1] = temp2;
//
//            }
//        }
//    }
//
//    int dis12 = sqrt(pow(notSort[1][0] - notSort[2][0], 2) +
//                     pow(notSort[1][1] - notSort[2][1], 2));
//
//    int dis13 = sqrt(pow(notSort[1][0] - notSort[3][0], 2) +
//                     pow(notSort[1][1] - notSort[3][1], 2));
//
//
//    if( dis12 > dis13 ){
//        int temp1 = notSort[2][0];
//        int temp2 = notSort[2][1];
//
//        //higherIndex equal lowerIndex
//        notSort[2][0] = notSort[3][0];
//        notSort[2][1] = notSort[3][1];
//
//        // lower equals higher
//        notSort[3][0] = temp1;
//        notSort[3][1] = temp2;
//    }
//
//
//    UIBezierPath* p = [UIBezierPath bezierPath];
//
//    [p moveToPoint:CGPointMake(notSort[0][0], notSort[0][1])];
//
//    [p addLineToPoint:CGPointMake(notSort[1][0], notSort[1][1])];
//
//    [p addLineToPoint:CGPointMake(notSort[2][0], notSort[2][1])];
//
//    [p addLineToPoint:CGPointMake(notSort[3][0], notSort[3][1])];
//
//    //    UIImage* i1 = [self cropImage:image withPath:p sortedArray:notSort];
//    //    UIImage *maskedShapesImg = MatToUIImage(detectedCornersImg);
//
//    //    Sara's
//    cv::Mat src;
//    UIImageToMat(image, src);
//    vector<cv::Point> not_a_rect_shape;
//    not_a_rect_shape.push_back(cv::Point(notSort[0][0],notSort[0][1]));
//    not_a_rect_shape.push_back(cv::Point(notSort[1][0],notSort[1][1]));
//    not_a_rect_shape.push_back(cv::Point(notSort[2][0],notSort[2][1]));
//    not_a_rect_shape.push_back(cv::Point(notSort[3][0],notSort[3][1]));
//
//
//    // For debugging purposes, draw green lines connecting those points
//    // and save it on disk
//    const cv::Point* point = &not_a_rect_shape[0];
//    int n = (int)not_a_rect_shape.size();
//    Mat draw = src.clone();
//    polylines(draw, &point, &n, 1, true, Scalar(0, 255, 0), 3, CV_AA);
//    imwrite("draw.jpg", draw);
//
//    // Assemble a rotated rectangle out of that info
//    RotatedRect box = minAreaRect(cv::Mat(not_a_rect_shape));
//    std::cout << "Rotated box set to (" << box.boundingRect().x << "," << box.boundingRect().y << ") " << box.size.width << "x" << box.size.height << std::endl;
//
//    Point2f pts[4];
//
//    box.points(pts);
//
//
//    // Does the order of the points matter? I assume they do NOT.
//    // But if it does, is there an easy way to identify and order
//    // them as topLeft, topRight, bottomRight, bottomLeft?
//
//    cv::Point2f src_vertices[3];
//    src_vertices[0] = pts[0];
//    src_vertices[1] = pts[1];
//    src_vertices[2] = pts[3];
//    //src_vertices[3] = not_a_rect_shape[3];
//
//    Point2f dst_vertices[3];
//    //                  dst_vertices[0] = cv::Point(0, 0);
//    if(box.size.width > box.size.height){
//        dst_vertices[1] = cv::Point(0, 0);
//        dst_vertices[0] = cv::Point(0, box.boundingRect().height-1);
//        dst_vertices[2] = cv::Point(box.boundingRect().width-1, box.boundingRect().height-1);
//        cout << "In CASE ONE" << endl;
//    } else{
//        dst_vertices[0] = cv::Point(0, 0);
//        dst_vertices[1] = cv::Point(box.boundingRect().width-1, 0);
//        dst_vertices[2] = cv::Point(0, box.boundingRect().height-1);
//        cout << "In CASE TWO" << endl;
//    }
//
//
//    /* Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);
//
//     cv::Mat rotated;
//     cv::Size size(box.boundingRect().width, box.boundingRect().height);
//     warpPerspective(src, rotated, warpMatrix, size, INTER_LINEAR, BORDER_CONSTANT);*/
//    Mat warpAffineMatrix = getAffineTransform(src_vertices, dst_vertices);
//
//    cv::Mat rotated;
//    cv::Size size(box.boundingRect().width, box.boundingRect().height);
//    warpAffine(src, rotated, warpAffineMatrix, size, INTER_LINEAR, BORDER_CONSTANT);
//
//    return MatToUIImage(rotated);
//}
//
//+(UIImage*) cropImage:(UIImage*)image withPath:(UIBezierPath*)path sortedArray:(int[4][2])points { // where the UIBezierPath is defined in the UIKit coordinate system (0,0) is top left
//    points[1][1] = {(static_cast<void>(1),1)};
//    CGRect r = CGPathGetBoundingBox(path.CGPath); // the rect to draw our image in (minimum rect that the path occupies).
//
//    UIGraphicsBeginImageContextWithOptions(r.size, NO, image.scale); // begin image context, with transparency & the scale of the image.
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    CGContextTranslateCTM(ctx, -r.origin.x, -r.origin.y); // translate context so that when we add the path, it starts at (0,0).
//
//    CGContextAddPath(ctx, path.CGPath); // add path.
//    CGContextClip(ctx); // clip any future drawing to the path region.
//
//    [image drawInRect:(CGRect){CGPointZero, image.size}]; // draw image
//
//    UIImage* i = UIGraphicsGetImageFromCurrentImageContext(); // get image from context
//    UIGraphicsEndImageContext(); // clean up and finish context
//
//    return i;
//
//}


@end

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
//    cout << " ### inside AddItem" << endl;
    ht[ii]= new item;
    ht[ii]->key= k;
    ht[ii]->value= v;
    
    ii = ii+1;
}

void addKv(){
    ii = 0;
//    cout << " ### inside addKv" << endl;
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
//    cout << " ### inside searchK" << endl;
    for(int j=0 ; j<s ; j++){
        if(ht[j]->key == k){
//            cout << " ### inside searchK if statement" << endl;
            word= word+ht[j]->value;}
    }
}

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

// Braille Detection Code :D v

// Method that returns String regarding crop status
+ (NSString *)checkCorners:(UIImage *)image{
    
    cv::Mat mat;
    UIImageToMat(image, mat);

    // Convert input image to HSV
    cv::Mat bgr_image;
    cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
    
    
    // Convert input image to HSV
    cv::Mat hsv_image;
    cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
    
    cv::Mat mask;
    cv::Mat mask1;
    cv::Mat mask2;

    
    // original
    cv::inRange( hsv_image, cv::Scalar(100,150,0), cv::Scalar(140,255,255), mask1);
    cv::inRange( hsv_image, cv::Scalar(100,105,0), cv::Scalar(140,255,255), mask2);

    // Combine the above two images
    cv::bitwise_or(mask1,mask2,mask);
    
    cv::Mat result_blue;
    cv::bitwise_and(mat,mat,result_blue,mask);

    cv::Mat pic_blue;
    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);

    vector<vector<cv::Point> > contours;
    vector< cv::Vec4i > hierarchy;
    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);

//    cout << "Total Contours Detected: " << contours.size() << endl;
    
    Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(0,0,0));
    
    int min_x= 0, min_y=0,max_x=0,max_y=0,w_add=0,h_add=0;
      vector<int> sortIdx(contours.size());
      vector<float> areas(contours.size());
      for( int n = 0; n < (int)contours.size(); n++ ) {
        sortIdx[n] = n;
        areas[n] = contourArea(contours[n], false);

      }


    int num_corner = 0;
      for( int n = 0; n < contours.size() ; n++ ) {
          int idx = sortIdx[n];
          int ar = areas[idx];


          if(ar > 400 && ar < 2000){

       cv::drawContours(
        emptyImg, contours, idx,
          cv::Scalar(255,255,255), FILLED, 8, hierarchy,0 // Try different values of max_level, and see what happens
        );
//              cout << "area : " << ar << endl;

              cv::Rect rect = boundingRect(contours[idx]);
              if (num_corner == 0)
              {
                  min_x = rect.x;
                  min_y = rect.y;
              }
              if (max_x < rect.x)
                  max_x = rect.x;
              if (max_y < rect.y)
                  max_y = rect.y;
              if (min_x >= rect.x){
                  min_x = rect.x;
                  w_add = rect.width;
              }
              if (min_y >= rect.y)
              { min_y = rect.y;
                  h_add = rect.height;
              }


              num_corner++;
          }

      }
//
    cout << "num_corner : " << num_corner << endl;
    bool exist = true;
    
    if(num_corner != 4){
        cout << "- missing corners condition" << endl;
        exist = false;
    }
    
    if(exist){
        return [NSString stringWithFormat:@"true",  CV_VERSION];
    }
    return [NSString stringWithFormat:@"false",  CV_VERSION];
}

+ (UIImage *)detectFourCorners:(UIImage *)image{
    
    cv::Mat mat;
    UIImageToMat(image, mat);

    // Convert input image to HSV
    cv::Mat bgr_image;
    cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
    
    
    // Convert input image to HSV
    cv::Mat hsv_image;
    cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
    
    cv::Mat mask;
    cv::Mat mask1;
    cv::Mat mask2;

    
    // original
    cv::inRange( hsv_image, cv::Scalar(100,150,0), cv::Scalar(140,255,255), mask1);
    cv::inRange( hsv_image, cv::Scalar(100,105,0), cv::Scalar(140,255,255), mask2);

    // Combine the above two images
    cv::bitwise_or(mask1,mask2,mask);
    
    cv::Mat result_blue;
    cv::bitwise_and(mat,mat,result_blue,mask);

    cv::Mat pic_blue;
    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);

    vector<vector<cv::Point> > contours;
    vector< cv::Vec4i > hierarchy;
    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);

//    cout << "Total Contours Detected: " << contours.size() << endl;
    
    Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(0,0,0));
    
    int min_x= 0, min_y=0,max_x=0,max_y=0,w_add=0,h_add=0;
      vector<int> sortIdx(contours.size());
      vector<float> areas(contours.size());
      for( int n = 0; n < (int)contours.size(); n++ ) {
        sortIdx[n] = n;
        areas[n] = contourArea(contours[n], false);

      }

    int num_corner = 0;
      for( int n = 0; n < contours.size() ; n++ ) {
          int idx = sortIdx[n];
          int ar = areas[idx];


          if(ar > 400 && ar < 2000){

       cv::drawContours(
        emptyImg, contours, idx,
          cv::Scalar(255,255,255), FILLED, 8, hierarchy,0 // Try different values of max_level, and see what happens
        );
//              cout << "area : " << ar << endl;

              cv::Rect rect = boundingRect(contours[idx]);
              if (num_corner == 0)
              {
                  min_x = rect.x;
                  min_y = rect.y;
              }
              if (max_x < rect.x)
                  max_x = rect.x;
              if (max_y < rect.y)
                  max_y = rect.y;
              if (min_x >= rect.x){
                  min_x = rect.x;
                  w_add = rect.width;
              }
              if (min_y >= rect.y)
              { min_y = rect.y;
                  h_add = rect.height;
              }


              num_corner++;
          }

      }

//    cv::Mat crop_image = mat(Range(min_y,max_y+w_add),Range(min_x,max_x+h_add));
    cv::Mat crop_image = mat(Range(min_y,max_y),Range(min_x,max_x));
    return MatToUIImage(crop_image); //mat
}

+ (NSString *)detectRedShapesInImage:(UIImage *)image{

    // reset variables
    coordinatesStatus = true;
    word = "";

    // set up hash table
    addKv();

    cv::Mat mat;
    UIImageToMat(image, mat);
    
    // Flipping the image to get mirror effect
    cv::flip(mat, mat, 1);
    
    // Convert input image to HSV
       cv::Mat bgr_image;
       cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
       
       // Convert input image to HSV
       cv::Mat hsv_image;
       cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
      
       cv::Mat mask;
       cv::Mat mask1;
       cv::Mat mask2;

    // Threshold the HSV image, keep only the red pixels
        cv::inRange(hsv_image, cv::Scalar(0, 100, 50), cv::Scalar(4, 255, 255), mask1);
        cv::inRange(hsv_image, cv::Scalar(150, 70, 100), cv::Scalar(180, 255, 255), mask2);
       
       // Combine the above two images
       cv::bitwise_or(mask1,mask2,mask);
       
       cv::Mat result_red;
       cv::bitwise_and(mat,mat,result_red,mask);
    
        // dilation
        Mat morphologyElementOne = getStructuringElement(MORPH_RECT, cv::Size(12, 12));
        Mat morphologyElementTwo = getStructuringElement(MORPH_RECT, cv::Size(5, 5));

    //       dilate(result_red, result_red, morphologyElementOne); // كل ما زاد الالمنت كل ما صغّر زيادة
           erode(result_red, result_red, morphologyElementTwo); // كل ما زاد الالمنت كل ما كبّر زيادة
    
       
       cv::Mat pic_red;
       cv::cvtColor(result_red, pic_red, cv::COLOR_BGR2GRAY);

       vector<vector<cv::Point> > contours;
       vector< cv::Vec4i > hierarchy;
       cv::findContours(pic_red, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);


        vector<Point2f>centers( contours.size() );
        vector<float>radius( contours.size() );
       vector<float> areas(contours.size());

        for( size_t i = 0; i < contours.size(); i++ )
        {
            minEnclosingCircle( contours[i], centers[i], radius[i] );
            areas[i] = contourArea(contours[i], false);

        }
         
       Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(255,255,255));
       
       int num=0;
         for( int n = 0; n < (int)contours.size() ; n++ ) {
             int ar = areas[n];
             if(ar > 100){
                 num++;
                
                 circle( emptyImg, centers[n], (int)radius[n], cv::Scalar(0,0,0),CV_FILLED, 2 );

             }
             
         }

       cout << "num_red_circle : " << num << endl;
       
       // Detect red blobs
       cv::SimpleBlobDetector::Params params;
       params.filterByArea = true;
       params.minArea =  200.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
       params.maxArea = 10000.0f;
       
       cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
       std::vector<cv::KeyPoint> keypoints;
       blobDetector->detect(emptyImg, keypoints); //red_hue_image drawing
       
       bool exist = true;
       
       // Check keypoints existance & draw keypoints for displaying
       if(keypoints.empty()){
           cout << "- There is no braille red keypoints condition" << endl;
           exist = false;
       }
       cout << "- Keypoints size " << keypoints.size() << endl;
      
       if (exist){
           // red blobs are detected
           cv::Mat detectedImg = cv::Mat(emptyImg.size(), CV_8UC3);
           drawKeypoints(emptyImg, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

           // Detect Black blobs
           
           cv::Mat black = cv::Mat(mat.rows, mat.cols, mat.type(), 0.0);
           double beta = (1.0 - 0.7); // The lower the alpha value is, the darker the image.
           cv::Mat blackened;
           cv::addWeighted(mat, 0.7, black, beta, 0.0, blackened);

           // 1) Threshold the HSV image, keep only the black pixels
           cv::Mat black_hue_range;

           // Convert input image to HSV
           cv::Mat black_hsv_image;
           cv::cvtColor(blackened, black_hsv_image, cv::COLOR_BGR2HSV);

           // BGR  == RGB
           cv::inRange(black_hsv_image, cv::Scalar(0, 0, 0, 0), cv::Scalar(180, 255, 30, 0), black_hue_range);

           // Switch Black&White
           cv::bitwise_not(black_hue_range, black_hue_range);

           cv::GaussianBlur(black_hue_range, black_hue_range, cv::Size(9, 9), 2, 2);

           cv::SimpleBlobDetector::Params initParams;
           initParams.filterByArea = true;
           initParams.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159

           cv::Ptr<cv::SimpleBlobDetector> initBlobDetector = cv::SimpleBlobDetector::create(initParams);
           std::vector<cv::KeyPoint> initKeypoints;
           initBlobDetector->detect(black_hue_range, initKeypoints);

           // Check keypoints existance & draw keypoints for displaying
           if(initKeypoints.empty()){
               cout << "- There is no braille black initKeypoints condition" << endl;
           }

           cout << "- initKeypoints size " << initKeypoints.size() << endl;

           cv::Mat blackCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
           drawKeypoints(mat, initKeypoints, blackCoordinatesImg, cvScalar(94,206,165,255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

           // Union initKeypoints + keypoints
           for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
               initKeypoints.push_back(keypoints[i]);
           }

           cv::Mat detectedCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
           drawKeypoints(emptyImg, initKeypoints, detectedCoordinatesImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

        // 4) normalize keypoints to coordinate line set
        float blobSize = 0.0f;
        for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
            blobSize += initKeypoints[i].size;
        }

        blobSize /= initKeypoints.size();
//        cout << "mean of the blob sizes : " << blobSize << endl;
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
        int cc = 0;
        int rr = 0;
        cout << "- colomns number " << coordinateX.size() << endl;
        cout << "- rows number " << coordinateY.size() << endl;

        if(coordinateX.size()%2 != 0){ // cc%2 != 0
            cout << "- removing odd column..." << endl;
            coordinateX.pop_back();
        }
        cv::Mat coordinateImg = detectedImg.clone();
        for (int i = 0; i < static_cast<int>(coordinateX.size()); ++i) {
            line(coordinateImg, cv::Point(coordinateX[i], 0), cv::Point(coordinateX[i], coordinateImg.rows), cvScalar(255, 0, 0));
            cc++;

        }
        for (int i = 0; i < static_cast<int>(coordinateY.size()); ++i) {
            line(coordinateImg, cv::Point(0, coordinateY[i]), cv::Point(coordinateImg.cols, coordinateY[i]), cvScalar(255, 0, 0));
            rr++;
        }
//        cout << "- total c" << cc << endl;
//        cout << "- total r" << rr << endl;
 
        if(rr != 3){ // cc%2 != 0
            cout << "- image is skewed !! " << endl;
            coordinatesStatus = false;
        }

        if (coordinatesStatus) {
            
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

        // optional
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
//        if((coordinateX[1] - coordinateX[0]) > (coordinateX[2] - coordinateX[1])){
//            startXPos = 1;
//        }
        for(int i = 0; i < static_cast<int>(coordinateY.size()) - 2; i += 3){
//            cout << "inside segments for loop Y" << endl;
//            cout << "inside segments for loop Y | Y coordinate -> " << coordinateY[i] <<endl;
//            cout << "inside segments for loop Y | X coordinate -> " << coordinateX[i] <<endl;
//            cout << "inside segments for loop Y | Start X Pos -> " << startXPos <<endl;
//            cout << "inside segments for loop Y | Coordinates X size -> " << coordinateX.size() <<endl;
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
            cout << "- There is no braille segments !!" << endl;
            // return 1;
        }

        // 7) make result image
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
        cout << "$$ the final string is " <<word<< endl;

            return [NSString stringWithUTF8String:word.c_str()];
        }
        // IF invalid coordinates
        return [NSString stringWithFormat:@"failed",  CV_VERSION];
    }
    // IF red blobs are not existing
    return [NSString stringWithFormat:@"failed",  CV_VERSION];
}

+ (NSString *)getCoordinatesStatus{
    if(coordinatesStatus){
        return [NSString stringWithFormat:@"true",  CV_VERSION];
    }
    return [NSString stringWithFormat:@"false",  CV_VERSION];
}

// new
//void fillEdgeImage(cv::Mat edgesIn, cv::Mat& filledEdgesOut)
//{
//    cv::Mat edgesNeg = edgesIn.clone();
//
//    // Convert input image to HSV
//    cv::Mat bgr_image;
//    cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
//
//
//    // Convert input image to HSV
//    cv::Mat hsv_image;
//    cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
//
//    cv::Mat mask;
//    cv::Mat mask1;
//    cv::Mat mask2;
//
//
//    // original
//    cv::inRange( hsv_image, cv::Scalar(100,150,0), cv::Scalar(140,255,255), mask1);
//    cv::inRange( hsv_image, cv::Scalar(100,90,0), cv::Scalar(140,255,255), mask2);
//
//    // Combine the above two images
//    cv::bitwise_or(mask1,mask2,mask);
//
//    cv::Mat result_blue;
//    cv::bitwise_and(mat,mat,result_blue,mask);
//
//    cv::Mat pic_blue;
//    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);
//
//    vector<vector<cv::Point> > contours;
//    vector< cv::Vec4i > hierarchy;
//    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
//
////    cout << "Total Contours Detected: " << contours.size() << endl;
//
//    Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(0,0,0));
//
//    int min_x= 0, min_y=0,max_x=0,max_y=0,w_add=0,h_add=0;
//      vector<int> sortIdx(contours.size());
//      vector<float> areas(contours.size());
//      for( int n = 0; n < (int)contours.size(); n++ ) {
//        sortIdx[n] = n;
//        areas[n] = contourArea(contours[n], false);
//
//      }
//
//
//    int num_corner = 0;
//      for( int n = 0; n < contours.size() ; n++ ) {
//          int idx = sortIdx[n];
//          int ar = areas[idx];
//
//
//          if(ar > 300 && ar < 5000){
//
//       cv::drawContours(
//        emptyImg, contours, idx,
//          cv::Scalar(255,255,255), FILLED, 8, hierarchy,0 // Try different values of max_level, and see what happens
//        );
////              cout << "area : " << ar << endl;
//
//              cv::Rect rect = boundingRect(contours[idx]);
//              if (num_corner == 0)
//              {
//                  min_x = rect.x;
//                  min_y = rect.y;
//              }
//              if (max_x < rect.x)
//                  max_x = rect.x;
//              if (max_y < rect.y)
//                  max_y = rect.y;
//              if (min_x >= rect.x){
//                  min_x = rect.x;
//                  w_add = rect.width;
//              }
//              if (min_y >= rect.y)
//              { min_y = rect.y;
//                  h_add = rect.height;
//              }
//
//
//              num_corner++;
//          }
//
//      }
////
//    cout << "num_corner : " << num_corner << endl;
//    bool exist = true;
//
//    if(num_corner != 4){
//        cout << "- missing corners condition" << endl;
//        exist = false;
//    }
//
//    if(exist){
//        return [NSString stringWithFormat:@"true",  CV_VERSION];
//    }
//    return [NSString stringWithFormat:@"false",  CV_VERSION];
//}
//
//+ (UIImage *)detectFourCorners:(UIImage *)image{
//
//    cv::Mat mat;
//    UIImageToMat(image, mat);
//
//    // Convert input image to HSV
//    cv::Mat bgr_image;
//    cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
//
//
//    // Convert input image to HSV
//    cv::Mat hsv_image;
//    cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
//
//    cv::Mat mask;
//    cv::Mat mask1;
//    cv::Mat mask2;
//
//
//    // original
//    cv::inRange( hsv_image, cv::Scalar(100,150,0), cv::Scalar(140,255,255), mask1);
//    cv::inRange( hsv_image, cv::Scalar(100,90,0), cv::Scalar(140,255,255), mask2);
//
//    // Combine the above two images
//    cv::bitwise_or(mask1,mask2,mask);
//
//    cv::Mat result_blue;
//    cv::bitwise_and(mat,mat,result_blue,mask);
//
//    cv::Mat pic_blue;
//    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);
//
//    vector<vector<cv::Point> > contours;
//    vector< cv::Vec4i > hierarchy;
//    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
//
////    cout << "Total Contours Detected: " << contours.size() << endl;
//
//    Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(0,0,0));
//
//    int min_x= 0, min_y=0,max_x=0,max_y=0,w_add=0,h_add=0;
//      vector<int> sortIdx(contours.size());
//      vector<float> areas(contours.size());
//      for( int n = 0; n < (int)contours.size(); n++ ) {
//        sortIdx[n] = n;
//        areas[n] = contourArea(contours[n], false);
//
//      }
//
//    int num_corner = 0;
//      for( int n = 0; n < contours.size() ; n++ ) {
//          int idx = sortIdx[n];
//          int ar = areas[idx];
//
//
//          if(ar > 300 && ar < 5000){
//
//       cv::drawContours(
//        emptyImg, contours, idx,
//          cv::Scalar(255,255,255), FILLED, 8, hierarchy,0 // Try different values of max_level, and see what happens
//        );
////              cout << "area : " << ar << endl;
//
//              cv::Rect rect = boundingRect(contours[idx]);
//              if (num_corner == 0)
//              {
//                  min_x = rect.x;
//                  min_y = rect.y;
//              }
//              if (max_x < rect.x)
//                  max_x = rect.x;
//              if (max_y < rect.y)
//                  max_y = rect.y;
//              if (min_x >= rect.x){
//                  min_x = rect.x;
//                  w_add = rect.width;
//              }
//              if (min_y >= rect.y)
//              { min_y = rect.y;
//                  h_add = rect.height;
//              }
//
//
//              num_corner++;
//          }
//
//      }
//
//    cv::Mat crop_image = mat(Range(min_y,max_y+w_add),Range(min_x,max_x+h_add));
//    return MatToUIImage(crop_image); //mat
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
//    // Flipping the image to get mirror effect
//    cv::flip(mat, mat, 1);
//
//    // Convert input image to HSV
//       cv::Mat bgr_image;
//       cv::cvtColor(mat, bgr_image, cv::COLOR_RGB2BGR);
//
//       // Convert input image to HSV
//       cv::Mat hsv_image;
//       cv::cvtColor(bgr_image, hsv_image, cv::COLOR_BGR2HSV);
//
//       cv::Mat mask;
//       cv::Mat mask1;
//       cv::Mat mask2;
//
//    // Threshold the HSV image, keep only the red pixels
//       cv::inRange(hsv_image, cv::Scalar(0, 100, 50), cv::Scalar(4, 255, 255), mask1);
//       cv::inRange(hsv_image, cv::Scalar(150, 70, 100), cv::Scalar(180, 255, 255), mask2);
//
//       // Combine the above two images
//       cv::bitwise_or(mask1,mask2,mask);
//
//       cv::Mat result_red;
//       cv::bitwise_and(mat,mat,result_red,mask);
//
//       cv::Mat pic_red;
//       cv::cvtColor(result_red, pic_red, cv::COLOR_BGR2GRAY);
//
//       vector<vector<cv::Point> > contours;
//       vector< cv::Vec4i > hierarchy;
//       cv::findContours(pic_red, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
//
//
//        vector<Point2f>centers( contours.size() );
//        vector<float>radius( contours.size() );
//       vector<float> areas(contours.size());
//
//        for( size_t i = 0; i < contours.size(); i++ )
//        {
//            minEnclosingCircle( contours[i], centers[i], radius[i] );
//            areas[i] = contourArea(contours[i], false);
//
//        }
//
//       Mat emptyImg(mat.rows, mat.cols, CV_8UC1, Scalar(255,255,255));
//
//       int num=0;
//         for( int n = 0; n < (int)contours.size() ; n++ ) {
//             int ar = areas[n];
//             if(ar > 100){
//                 num++;
//
//                 circle( emptyImg, centers[n], (int)radius[n], cv::Scalar(0,0,0),CV_FILLED, 2 );
//
//             }
//
//         }
//
//       cout << "num_red_circle : " << num << endl;
//
//       // Detect red blobs
//       cv::SimpleBlobDetector::Params params;
//       params.filterByArea = true;
//       params.minArea =  200.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//       params.maxArea = 10000.0f;
//
//       cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
//       std::vector<cv::KeyPoint> keypoints;
//       blobDetector->detect(emptyImg, keypoints); //red_hue_image drawing
//
//       bool exist = true;
//
//       // Check keypoints existance & draw keypoints for displaying
//       if(keypoints.empty()){
//           cout << "- There is no braille red keypoints condition" << endl;
//           exist = false;
//       }
//       cout << "- Keypoints size " << keypoints.size() << endl;
//
//       if (exist){
//           // red blobs are detected
//           cv::Mat detectedImg = cv::Mat(emptyImg.size(), CV_8UC3);
//           drawKeypoints(emptyImg, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//           // Detect Black blobs
//
//           cv::Mat black = cv::Mat(mat.rows, mat.cols, mat.type(), 0.0);
//           double beta = (1.0 - 0.7); // The lower the alpha value is, the darker the image.
//           cv::Mat blackened;
//           cv::addWeighted(mat, 0.7, black, beta, 0.0, blackened);
//
//           // 1) Threshold the HSV image, keep only the black pixels
//           cv::Mat black_hue_range;
//
//           // Convert input image to HSV
//           cv::Mat black_hsv_image;
//           cv::cvtColor(blackened, black_hsv_image, cv::COLOR_BGR2HSV);
//
//           // BGR  == RGB
//           cv::inRange(black_hsv_image, cv::Scalar(0, 0, 0, 0), cv::Scalar(180, 255, 30, 0), black_hue_range);
//
//           // Switch Black&White
//           cv::bitwise_not(black_hue_range, black_hue_range);
//
//           cv::GaussianBlur(black_hue_range, black_hue_range, cv::Size(9, 9), 2, 2);
//
//           cv::SimpleBlobDetector::Params initParams;
//           initParams.filterByArea = true;
//           initParams.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//
//           cv::Ptr<cv::SimpleBlobDetector> initBlobDetector = cv::SimpleBlobDetector::create(initParams);
//           std::vector<cv::KeyPoint> initKeypoints;
//           initBlobDetector->detect(black_hue_range, initKeypoints);
//
//           // Check keypoints existance & draw keypoints for displaying
//           if(initKeypoints.empty()){
//               cout << "- There is no braille black initKeypoints condition" << endl;
//           }
//
//           cout << "- initKeypoints size " << initKeypoints.size() << endl;
//
//           cv::Mat blackCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
//           drawKeypoints(mat, initKeypoints, blackCoordinatesImg, cvScalar(94,206,165,255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//           // Union initKeypoints + keypoints
//           for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
//               initKeypoints.push_back(keypoints[i]);
//           }
//
//           cv::Mat detectedCoordinatesImg = cv::Mat(mat.size(), CV_8UC3);
//           drawKeypoints(emptyImg, initKeypoints, detectedCoordinatesImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
//
//        // 4) normalize keypoints to coordinate line set
//        float blobSize = 0.0f;
//        for (int i = 0; i < static_cast<int>(initKeypoints.size()); ++i) {
//            blobSize += initKeypoints[i].size;
//        }
//
//        blobSize /= initKeypoints.size();
////        cout << "mean of the blob sizes : " << blobSize << endl;
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
//        cout << "- colomns number " << coordinateX.size() << endl;
//        cout << "- rows number " << coordinateY.size() << endl;
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
////        cout << "- total c" << cc << endl;
////        cout << "- total r" << rr << endl;
//
//        if(rr != 3){ // cc%2 != 0
//            cout << "- image is skewed !! " << endl;
//            coordinatesStatus = false;
//        }
//
//        if (coordinatesStatus) {
//
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
////            cout << "inside segments for loop Y" << endl;
////            cout << "inside segments for loop Y | Y coordinate -> " << coordinateY[i] <<endl;
////            cout << "inside segments for loop Y | X coordinate -> " << coordinateX[i] <<endl;
////            cout << "inside segments for loop Y | Start X Pos -> " << startXPos <<endl;
////            cout << "inside segments for loop Y | Coordinates X size -> " << coordinateX.size() <<endl;
//            for(int j = startXPos; j < static_cast<int>(coordinateX.size()) - 1; j += 2){
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
//            cout << "- There is no braille segments !!" << endl;
//            // return 1;
//        }
//
//        // 7) make result image
//        Mat resultImg = Mat(cv::Size(segmentationImg.size()), CV_8UC3);
//        resultImg.setTo(255);
//        addWeighted(resultImg, 0.8, segmentationImg, 0.2, 0.0,  resultImg);
//
//        int intFontFace = FONT_HERSHEY_SIMPLEX;
//        double dblFontScale = brailleSet[0].rect.size().width / 60.0;
//        int intFontThickness = (int)std::round(dblFontScale * 2);
//
//        for(int i = 0; i < static_cast<int>(brailleSet.size()); ++i){
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
//// new
////void fillEdgeImage(cv::Mat edgesIn, cv::Mat& filledEdgesOut)
////{
////    cv::Mat edgesNeg = edgesIn.clone();
////
////    cv::floodFill(edgesNeg, cv::Point(0,0), CV_RGB(255,255,255));
////    bitwise_not(edgesNeg, edgesNeg);
////    filledEdgesOut = (edgesNeg | edgesIn);
////
////    return;
////}
//
////+ (UIImage *)detectFourCorner:(UIImage *)image{
////
////    cv::Mat mat;
////    UIImageToMat(image, mat);
////    cv::medianBlur(mat, mat, 3);
////
////    // Color based detection
////        cv::Mat hsv_image;
////        // Convert input image to HSV
////        cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
////
////        vector<Mat> channels;
////        split(hsv_image,channels);
////
////        equalizeHist(channels[0], channels[0]); // HSV
////
////
////        merge(channels,hsv_image);
////
////        // Threshold the HSV image, keep only the blue pixels
////        cv::Mat lower_blue_hue_range;
////        cv::Mat upper_blue_hue_range;
////
////        cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_blue_hue_range);
////        cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_blue_hue_range);
////
////        // Combine the above two images
////        cv::Mat blue_hue_image;
////        cv::addWeighted(lower_blue_hue_range, 1.0, upper_blue_hue_range, 1.0, 0.0, blue_hue_image);
////        cv::GaussianBlur(blue_hue_image, blue_hue_image, cv::Size(9, 9), 2, 2);
////
////        // Switch Black&White
////        cv::bitwise_not(blue_hue_image, blue_hue_image);
////
////        // Detect blue blobs only
////        cv::SimpleBlobDetector::Params params;
////        params.filterByArea = true;
////        params.minArea =  500.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
////
////        params.filterByCircularity = true;
////    //        params.maxCircularity = 0.8;
////        params.minCircularity = 0.75;// squares are 0.785
////
////        cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
////        std::vector<cv::KeyPoint> keypoints;
////        blobDetector->detect(blue_hue_image, keypoints);
////
//////    // Blob based Detection: to detect base 4 corner
//////    cv::SimpleBlobDetector::Params Params;
//////    Params.filterByArea = true;
//////    Params.minArea =  50.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
//////    Params.maxArea =  600.0f; //50.0f * 50.0f; //20.0f * 20.0f;
//////
////
//////    cv::Ptr<cv::SimpleBlobDetector> BlobDetector = cv::SimpleBlobDetector::create(Params);
//////    std::vector<cv::KeyPoint> keypoints;
//////    BlobDetector->detect(mat, keypoints);
////
//////    // Check keypoints existance
//////    if(keypoints.empty()){
//////        cout << "there is no corner existance condition" << endl;
//////        // return 1;
//////    }
////    float blobSize = 0.0f;
////    for (int i = 0; i < keypoints.size(); ++i) {
////        blobSize += keypoints[i].size;
////    }
////    blobSize /= keypoints.size();
////
////    cv::Mat detectedCornersImg = cv::Mat(mat.size(), CV_8UC3);
////    detectedCornersImg.setTo(0);
////    for (int i = 0; i < keypoints.size(); ++i) {
////        circle(detectedCornersImg,cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(255, 255 , 255), -1, LINE_AA);
////    }
////
////    //    drawKeypoints(mat, Keypoints, detectedCornersImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
////
////    //    // Color based detection
////    //    // Convert input image to HSV
////    //    cv::Mat hsv_image;
////    //    cv::cvtColor(mat, hsv_image, cv::COLOR_BGR2HSV);
////    //
////    //    // Threshold the HSV image, keep only the red pixels
////    //    cv::Mat lower_red_hue_range;
////    //    cv::Mat upper_red_hue_range;
////    //
////    //    cv::inRange(hsv_image, cv::Scalar(0, 50, 50), cv::Scalar(10, 255, 255), lower_red_hue_range);
////    //    cv::inRange(hsv_image, cv::Scalar(170, 50, 50), cv::Scalar(180, 255, 255), upper_red_hue_range);
////    //
////    //    // Combine the above two images
////    //    cv::Mat red_hue_image;
////    //    cv::addWeighted(lower_red_hue_range, 1.0, upper_red_hue_range, 1.0, 0.0, red_hue_image);
////    //    cv::GaussianBlur(red_hue_image, red_hue_image, cv::Size(9, 9), 2, 2);
////    //
////    Mat canny_output;
////    vector<vector<cv::Point> > contours;
////    vector<Vec4i> hierarchy;
////
////    //     detect edges using canny
////    Canny( detectedCornersImg, canny_output, 50, 150, 3 );
////
////    // find contours
////    findContours( canny_output, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
////
////    // get the moments
////    vector<Moments> mu(contours.size());
////    for( int i = 0; i<contours.size(); i++ )
////    {
////        mu[i] = moments( contours[i], false ); }
////
////    // get the centroid of figures.
////    vector<Point2f> mc(contours.size());
////    for( int i = 0; i<contours.size(); i++)
////    {
////        mc[i] = Point2f( mu[i].m10/mu[i].m00 , mu[i].m01/mu[i].m00 ); }
////
////
////    // draw contours
////    //    Mat drawing(canny_output.size(), CV_8UC3, Scalar(255,255,255));
////    //    for( int i = 0; i<contours.size(); i++ )
////    //    {
////    //        Scalar color = Scalar(167,151,0); // B G R values
////    //        drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, cv::Point());
////    //        circle( drawing, mc[i], 4, color, -1, 8, 0 );
////    //    }
////
////    int x1 = static_cast<int>(mc[0].x);
////    int y1 = static_cast<int>(mc[0].y);
////
////    int x2 = static_cast<int>(mc[2].x);
////    int y2 = static_cast<int>(mc[2].y);
////
////    int x3 = static_cast<int>(mc[4].x);
////    int y3 = static_cast<int>(mc[4].y);
////
////    int x4 = static_cast<int>(mc[6].x);
////    int y4 = static_cast<int>(mc[6].y);
////
////
////    int notSort [4][2] = { {x1, y1}, {x2, y2}, {x3,y3}, {x4,y4} };
////
////    if (mc.size() != 8){
////
////        cout <<"oh there is a problem! size is not 8"<< endl;
////        cout << mc.size() << endl;
////
////    }
////
////    cout <<"0. mc size is == "<<mc.size()<< endl;
////
////    int lowerIndex = 0;
////    int higherIndex = 0;
////
////
////    for( int i = 0; i<4; i++ ){
////        for( int j = i+1; j<4; j++){
////
////            if (notSort[j][0] < notSort[i][0]){
////                higherIndex = i;
////                lowerIndex = j;
////                //{higherIndex , ... , lowerIndex}
////                // output: { lowerIndex, ..., higherIndex}
////
////                // store var of higherIndex values
////                int temp1 = notSort[i][0];
////                int temp2 = notSort[i][1];
////
////                //higherIndex equal lowerIndex
////                notSort[higherIndex][0] = notSort[lowerIndex][0];
////                notSort[higherIndex][1] = notSort[lowerIndex][1];
////
////                // lower equals higher
////                notSort[lowerIndex][0] = temp1;
////                notSort[lowerIndex][1] = temp2;
////
////            }
////        }
////    }
////
////    int dis12 = sqrt(pow(notSort[1][0] - notSort[2][0], 2) +
////                     pow(notSort[1][1] - notSort[2][1], 2));
////
////    int dis13 = sqrt(pow(notSort[1][0] - notSort[3][0], 2) +
////                     pow(notSort[1][1] - notSort[3][1], 2));
////
////
////    if( dis12 > dis13 ){
////        int temp1 = notSort[2][0];
////        int temp2 = notSort[2][1];
////
////        //higherIndex equal lowerIndex
////        notSort[2][0] = notSort[3][0];
////        notSort[2][1] = notSort[3][1];
////
////        // lower equals higher
////        notSort[3][0] = temp1;
////        notSort[3][1] = temp2;
////    }
////
////
////    UIBezierPath* p = [UIBezierPath bezierPath];
////
////    [p moveToPoint:CGPointMake(notSort[0][0], notSort[0][1])];
////
////    [p addLineToPoint:CGPointMake(notSort[1][0], notSort[1][1])];
////
////    [p addLineToPoint:CGPointMake(notSort[2][0], notSort[2][1])];
////
////    [p addLineToPoint:CGPointMake(notSort[3][0], notSort[3][1])];
////
////    //    UIImage* i1 = [self cropImage:image withPath:p sortedArray:notSort];
////    //    UIImage *maskedShapesImg = MatToUIImage(detectedCornersImg);
////
////    //    Sara's
////    cv::Mat src;
////    UIImageToMat(image, src);
////    vector<cv::Point> not_a_rect_shape;
////    not_a_rect_shape.push_back(cv::Point(notSort[0][0],notSort[0][1]));
////    not_a_rect_shape.push_back(cv::Point(notSort[1][0],notSort[1][1]));
////    not_a_rect_shape.push_back(cv::Point(notSort[2][0],notSort[2][1]));
////    not_a_rect_shape.push_back(cv::Point(notSort[3][0],notSort[3][1]));
////
////
////    // For debugging purposes, draw green lines connecting those points
////    // and save it on disk
////    const cv::Point* point = &not_a_rect_shape[0];
////    int n = (int)not_a_rect_shape.size();
////    Mat draw = src.clone();
////    polylines(draw, &point, &n, 1, true, Scalar(0, 255, 0), 3, CV_AA);
////    imwrite("draw.jpg", draw);
////
////    // Assemble a rotated rectangle out of that info
////    RotatedRect box = minAreaRect(cv::Mat(not_a_rect_shape));
////    std::cout << "Rotated box set to (" << box.boundingRect().x << "," << box.boundingRect().y << ") " << box.size.width << "x" << box.size.height << std::endl;
////
////    Point2f pts[4];
////
////    box.points(pts);
////
////
////    // Does the order of the points matter? I assume they do NOT.
////    // But if it does, is there an easy way to identify and order
////    // them as topLeft, topRight, bottomRight, bottomLeft?
////
////    cv::Point2f src_vertices[3];
////    src_vertices[0] = pts[0];
////    src_vertices[1] = pts[1];
////    src_vertices[2] = pts[3];
////    //src_vertices[3] = not_a_rect_shape[3];
////
////    Point2f dst_vertices[3];
////    //                  dst_vertices[0] = cv::Point(0, 0);
////    if(box.size.width > box.size.height){
////        dst_vertices[1] = cv::Point(0, 0);
////        dst_vertices[0] = cv::Point(0, box.boundingRect().height-1);
////        dst_vertices[2] = cv::Point(box.boundingRect().width-1, box.boundingRect().height-1);
////        cout << "In CASE ONE" << endl;
////    } else{
////        dst_vertices[0] = cv::Point(0, 0);
////        dst_vertices[1] = cv::Point(box.boundingRect().width-1, 0);
////        dst_vertices[2] = cv::Point(0, box.boundingRect().height-1);
////        cout << "In CASE TWO" << endl;
////    }
////
////
////    /* Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);
////
////     cv::Mat rotated;
////     cv::Size size(box.boundingRect().width, box.boundingRect().height);
////     warpPerspective(src, rotated, warpMatrix, size, INTER_LINEAR, BORDER_CONSTANT);*/
////    Mat warpAffineMatrix = getAffineTransform(src_vertices, dst_vertices);
////
////    cv::Mat rotated;
////    cv::Size size(box.boundingRect().width, box.boundingRect().height);
////    warpAffine(src, rotated, warpAffineMatrix, size, INTER_LINEAR, BORDER_CONSTANT);
////
////    return MatToUIImage(rotated);
////}
//



@end

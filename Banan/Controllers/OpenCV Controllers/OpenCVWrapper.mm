

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
    cv::inRange( hsv_image, cv::Scalar(100,100,0), cv::Scalar(140,255,255), mask2);
    
    // Combine the above two images
    cv::bitwise_or(mask1,mask2,mask);
    
    // Blob detector code ___________________________
    // Remove noise
    cv::SimpleBlobDetector::Params params;
    params.filterByArea = true;
    params.minArea =  250.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159
    
    // Filter by Inertia
    //        params.filterByInertia = true;
    params.minInertiaRatio = 0.4;
    
    params.filterByConvexity = true;
    params.minConvexity = 0.87;
    
    //    params.filterByConvexity = false;
    params.filterByInertia = false;
    //
    params.filterByColor = true;
    params.blobColor = 255;
    
    cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
    std::vector<cv::KeyPoint> keypoints;
    blobDetector->detect(mask, keypoints); //red_hue_image
    
    cout << "- detected corners number is " << keypoints.size() <<endl;
    bool exist = true;
    
    if(keypoints.size() != 4){
        cout << "- missing corners condition" << endl;
        exist = false;
    }
    
        if (exist){
    float blobSize = 0.0f;
    for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
        blobSize += keypoints[i].size;
    }
    blobSize = blobSize/keypoints.size();
    // make image from the edited keypoint set(draw line for display)
    cv::Mat temp = cv::Mat(mask.rows, mask.cols, mask.type(), cvScalar(0, 0, 0));
    //    temp.setTo(0);
    for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
        circle(temp, cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(255), -1, LINE_AA);
    }
    
    //    cv::Mat temp = cv::Mat(mask.rows, mask.cols, mask.type(), cvScalar(0, 0, 0));
    //        cv::Mat detectedImg = cv::Mat(mask.size(), CV_8UC3);
    //                drawKeypoints(temp, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
    
    //    }
    cv::Mat test;
    cv::bitwise_and(mask,mask,test, temp);
    // _______________________________________________
    
    cv::Mat result_blue;
    cv::bitwise_and(mat,mat,result_blue,test);
    
    cv::Mat pic_blue;
    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);
    
    vector<vector<cv::Point> > contours;
    vector< cv::Vec4i > hierarchy;
    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
    
    //    cout << "Total Contours Detected: " << contours.size() << endl;
    
    Mat emptyImg(pic_blue.rows, pic_blue.cols, CV_8UC1, Scalar(0,0,0));
    
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
        
        
        if(ar > 100 ){
            
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
    //    bool exist = true;
    
    if(num_corner != 4){
        cout << "- missing corners condition" << endl;
        exist = false;
    }
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
    cv::inRange( hsv_image, cv::Scalar(100,100,0), cv::Scalar(140,255,255), mask2);
    
    // Combine the above two images
    cv::bitwise_or(mask1,mask2,mask);
    
    // Blob detector code ___________________________
    // Remove noise
    cv::SimpleBlobDetector::Params params;
    params.filterByArea = true;
    params.minArea =  250.0f;//5.0f * 5.0f; //2.0f * 2.0f; //3.14159

    // Filter by Inertia
    //        params.filterByInertia = true;
    params.minInertiaRatio = 0.4;
    
    params.filterByConvexity = true;
    params.minConvexity = 0.87;
    
    //    params.filterByConvexity = false;
    params.filterByInertia = false;
    //
    params.filterByColor = true;
    params.blobColor = 255;
    
    cv::Ptr<cv::SimpleBlobDetector> blobDetector = cv::SimpleBlobDetector::create(params);
    std::vector<cv::KeyPoint> keypoints;
    blobDetector->detect(mask, keypoints); //red_hue_image
    
    cout << "- detected corners number is " << keypoints.size() <<endl;
//    bool exist = true;
    
    if(keypoints.size() != 4){
        cout << "- missing corners condition" << endl;
//        exist = false;
    }
    
    //    if (exist){
    float blobSize = 0.0f;
    for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
        blobSize += keypoints[i].size;
    }
    blobSize = blobSize/keypoints.size();
    // make image from the edited keypoint set(draw line for display)
    cv::Mat temp = cv::Mat(mask.rows, mask.cols, mask.type(), cvScalar(0, 0, 0));
//    temp.setTo(0);
    for (int i = 0; i < static_cast<int>(keypoints.size()); ++i) {
        circle(temp, cv::Point(keypoints[i].pt.x, keypoints[i].pt.y), blobSize / 2, Scalar(255), -1, LINE_AA);
    }
    
    //    cv::Mat temp = cv::Mat(mask.rows, mask.cols, mask.type(), cvScalar(0, 0, 0));
    //        cv::Mat detectedImg = cv::Mat(mask.size(), CV_8UC3);
    //                drawKeypoints(temp, keypoints, detectedImg, cvScalar(255, 0, 26), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
    
    //    }
    cv::Mat test;
    cv::bitwise_and(mask,mask,test,temp);
    // _______________________________________________
    
    cv::Mat result_blue;
    cv::bitwise_and(mat,mat,result_blue,test);

    cv::Mat pic_blue;
    cv::cvtColor(result_blue, pic_blue, cv::COLOR_BGR2GRAY);

    vector<vector<cv::Point> > contours;
    vector< cv::Vec4i > hierarchy;
    cv::findContours(pic_blue, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
    
    //    cout << "Total Contours Detected: " << contours.size() << endl;
    
    Mat emptyImg(pic_blue.rows, pic_blue.cols, CV_8UC1, Scalar(0,0,0));
    
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
        
        
        if(ar > 100 ){
            
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
    
    cv::Mat crop_image = mat(Range(min_y,max_y+w_add),Range(min_x,max_x+h_add));
    //    cv::Mat crop_image = mat(Range(min_y,max_y),Range(min_x,max_x));
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
    //        Mat morphologyElementOne = getStructuringElement(MORPH_RECT, cv::Size(12, 12));
    Mat morphologyElementTwo = getStructuringElement(MORPH_RECT, cv::Size(4, 4));
    
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
    //       params.maxArea = 12000.0f;
    
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
        cout << "- initKeypoints size " << initKeypoints.size() << endl;
        
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

@end

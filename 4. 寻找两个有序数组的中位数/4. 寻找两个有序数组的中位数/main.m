//
//  main.m
//  4. 寻找两个有序数组的中位数
//
//  Created by glodon on 2019/9/25.
//  Copyright © 2019 persion. All rights reserved.
//

#import <Foundation/Foundation.h>
double findMedianSortedArrays1(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int allcount = nums1Size+ nums2Size;
    int z = allcount/2;
    int y = allcount%2;
    
    int numOneIndex = z;
    int numTwoIndex = y==1?z:z-1;
    int num1Index=0;
    int num2ndex=0;
    
    if (nums1Size==0) {
        return (nums2[numOneIndex]+nums2[numTwoIndex])/2.0;
    }
    if (nums2Size == 0) {
        return (nums1[numOneIndex]+nums1[numTwoIndex])/2.0;;
    }
    
    double result = 0.0;
    int * allNum = malloc(allcount * sizeof(int));
    
    do {
        if (nums1[num1Index]>nums2[num2ndex]) {
            allNum[num1Index+num2ndex]=nums2[num2ndex];
            num2ndex++;
        }else{
              allNum[num1Index+num2ndex]=nums1[num1Index];
              num1Index++;
            
        }
        if (num2ndex == nums2Size) {
            for (int i=num1Index; i<nums1Size; i++) {
                 allNum[num1Index+num2ndex]=nums1[num1Index];
                 num1Index++;
            }
            break;
        }
        if (num1Index == nums1Size) {
            for (int i=num2ndex; i<nums2Size; i++) {
                 allNum[num1Index+num2ndex]=nums2[num2ndex];
                 num2ndex++;
            }
            break;
        }
        
    } while (1);
    
    
    result=(allNum[numOneIndex]+allNum[numTwoIndex])/2.0;;
    free(allNum);
    return result;
}

double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int allcount = nums1Size+ nums2Size;
       int z = allcount/2;
       int y = allcount%2;
       
       int numOneIndex = z;
       int numTwoIndex = y==1?z:z-1;
       int num1Index=0;
       int num2ndex=0;
       int * temp = NULL;
    if (nums1Size==0) {
        return (nums2[numOneIndex]+nums2[numTwoIndex])/2.0;
    }
    if (nums2Size == 0) {
        return (nums1[numOneIndex]+nums1[numTwoIndex])/2.0;;
    }
    double result =0.0;
    int frontNum =0.0;
    int currentNum = 0.0;
    do {
          frontNum =currentNum;
        if (num2ndex==nums2Size) {
            currentNum=nums1[num1Index];
            temp=&num1Index;
        }else if (num1Index==nums1Size){
            currentNum=nums2[num2ndex];
             temp=&num2ndex;
        }else{
            if (nums1[num1Index]>nums2[num2ndex] ) {
                currentNum=nums2[num2ndex];
                temp=&num2ndex;
            }else{
                    currentNum=nums1[num1Index];
                    temp=&num1Index;
            }
        }

        if ((num1Index+num2ndex) == numOneIndex) {
            if (y==1) {
                result =(currentNum+currentNum)/2.0;
            }else{
                result =(currentNum + frontNum)/2.0;
            }
            break;
        }
        (*temp)++;
    } while (1);
         
      return result;
}
#define SELFMAX(x,y) x>y?x:y
#define SELFMIN(x,y) x>y?y:x
//官方题解
double findMedianSortedArrays2(int* nums1, int nums1Size, int* nums2, int nums2Size){
    if (nums1Size > nums2Size) { // to ensure nums1Size<=nums2Size
        int*  temp = nums1; nums1 = nums2; nums2 = temp;
        int tmp = nums1Size; nums1Size = nums2Size; nums2Size = tmp;
    }
    int iMin = 0, iMax = nums1Size, halfLen = (nums1Size + nums2Size + 1) / 2;
    while (iMin <= iMax) {
        //找i中间
        int i = (iMin + iMax) / 2;
        int j = halfLen - i;
        //i 太小
        if (i < iMax && nums2[j-1] > nums1[i]){
            iMin = i + 1; // i is too small
        }
        else if (i > iMin && nums1[i-1] > nums2[j]) {
            iMax = i - 1; // i is too big
        }
        else { // i is perfect
            int maxLeft = 0;
            if (i == 0) { maxLeft = nums2[j-1]; }
            else if (j == 0) { maxLeft = nums1[i-1]; }
            
            else { maxLeft = SELFMAX(nums1[i-1], nums2[j-1]); }
            if ( (nums1Size + nums2Size) % 2 == 1 ) { return maxLeft; }

            int minRight = 0;
            if (i == nums1Size) { minRight = nums2[j]; }
            else if (j == nums2Size) { minRight = nums1[i]; }
            else { minRight = SELFMIN(nums2[j], nums1[i]); }

            return (maxLeft + minRight) / 2.0;
        }
    }
    return 0.0;
}



int main(int argc, const char * argv[]) {
    int nums1[2];
    nums1[0]=1;
    nums1[1]=2;
    
    int nums2[2];
    nums2[0]=3;
    nums2[1]=4;
   double reuslt=  findMedianSortedArrays2(nums1,2,nums2,2);
    NSLog(@"%f",reuslt);
    return 0;
}

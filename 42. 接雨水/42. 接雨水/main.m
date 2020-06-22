//
//  main.m
//  42. 接雨水
//
//  Created by glodon on 2020/6/22.
//  Copyright © 2020 persion. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LeedCodeMax(A,B) (A>B?A:B)
#define LeedCodeMin(A,B) (A>B?B:A)

///暴力法
int trap1(int* height, int heightSize){
    int ans = 0;
    for (int i=1; i<heightSize-1; i++) {
        int max_left=0;
        int max_right=0;
        for (int j=i; j>=0; j--) {
            max_left = LeedCodeMax(max_left, height[j]);
        }
        for (int j=i; j<heightSize; j++) {
            max_right = LeedCodeMax(max_right, height[j]);
        }
        ans += LeedCodeMin(max_left, max_right)-height[i];

    }
    return ans;
}
///动态编程
int trap2(int* height, int heightSize){
    int ans = 0;
    if (heightSize==0) {
        return 0;
    }
   int * left_max= (int *)malloc(heightSize*sizeof(int));
    int * right_max=(int *)malloc(heightSize*sizeof(int));
    for (int i=0; i<heightSize; i++) {
        left_max[i] = 0;
        right_max[i]=0;
    }
    left_max[0] = height[0];
    for (int i=1; i<heightSize; i++) {
        left_max[i]=LeedCodeMax(height[i], left_max[i-1]);
    }
    right_max[heightSize-1]=height[heightSize-1];
    for (int i=heightSize-2; i>=0; i--) {
        right_max[i]=LeedCodeMax(height[i], right_max[i+1]);
    }
    for ( int i=1; i<heightSize-1; i++) {
        ans += LeedCodeMin(left_max[i], right_max[i])-height[i];
    }
    free(left_max);
    free(right_max);
    return ans;
}


 struct LeedCode_Array
{
    int size; //
    int * point;
    int  current;
    int count;
};

int  array_init(struct LeedCode_Array * array,int size){
     int * temp = malloc(size* sizeof(int));
    array->point = temp;
    memset(array->point, 0, size* sizeof(int));
    if(array->point==NULL)
        return -1;
    array->size = size;
    array->count = 0;
    array->current = -1;
    return 0;
}

int array_isEmpty(struct LeedCode_Array * array){
    if (array->count==0) {
        return true;
    }
    return false;
}
int array_push(struct LeedCode_Array * array,int value){
    array->current += 1;
    array->point[array->current]=value;
    array->count +=1;
    return  value;
}

int array_top(struct LeedCode_Array * array){
//    if (array_isEmpty(array)) {
//        return 0;
//    }
    return array->point[array->current];;
}


int array_pop(struct LeedCode_Array * array){
    int value =array->point[array->current];
    array->count -=1;
    array->point[array->current]=0;
    array->current-=1;
    return value;
}


void array_free(struct LeedCode_Array * array){
    if(array->point!=NULL){
        free(array->point);
    }
}

///栈的使用
int trap3(int* height, int heightSize){
    int ans = 0, current = 0;
    struct  LeedCode_Array stack;
    array_init(&stack, heightSize);
    while (current < heightSize) {
        while (!array_isEmpty(&stack) && height[current]>height[array_top(&stack)]) {
            int top = array_top(&stack);
            array_pop(&stack);
            if (array_isEmpty(&stack)) {
                break;
            }
            int distance = current-array_top(&stack)-1;
            int bounded_height=LeedCodeMin(height[current], height[array_top(&stack)])-height[top];
            ans += distance * bounded_height;
        }
        array_push(&stack, current++);
    }
    array_free(&stack);
    return ans;
}

//双指针
int trap(int* height, int heightSize){
    int left = 0,right = heightSize -1;
    int ans = 0;
    int left_max = 0,right_max=0;
    while (left<right) {
        if (height[left]<height[right]) {
            height[left]>=left_max?(left_max=height[left]):(ans+=(left_max-height[left]));
            ++left;
        }else{
            height[right] >= right_max ? (right_max = height[right]) : (ans +=(right_max - height[right]));
            --right;
        }
    }
    return ans;
}

void test(void){
    int height[12]={0,1,0,2,1,0,1,3,2,1,2,1};
    printf("暴力法 %d\n",trap1(height, 12));
    printf("动态编程 %d\n",trap2(height, 12));
    printf("栈的使用 %d\n",trap3(height, 12));
    printf("双指针 %d\n",trap(height, 12));

}

void test1(void){
    int height[3]={2,0,2};
    printf("暴力法 %d\n",trap1(height, 3));
    printf("动态编程 %d\n",trap2(height, 3));
    printf("栈的使用 %d\n",trap3(height, 3));
    printf("双指针 %d\n",trap(height, 3));

}

int main(int argc, const char * argv[]) {
    test();
    test1();
    return 0;
}





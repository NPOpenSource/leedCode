//
//  main.m
//  71. 简化路径
//
//  Created by glodon on 2020/6/22.
//  Copyright © 2020 persion. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 以 Unix 风格给出一个文件的绝对路径，你需要简化它。或者换句话说，将其转换为规范路径。
 
 在 Unix 风格的文件系统中，一个点（.）表示当前目录本身；此外，两个点 （..） 表示将目录切换到上一级（指向父目录）；两者都可以是复杂相对路径的组成部分。更多信息请参阅：Linux / Unix中的绝对路径 vs 相对路径
 
 请注意，返回的规范路径必须始终以斜杠 / 开头，并且两个目录名之间必须只有一个斜杠 /。最后一个目录名（如果存在）不能以 / 结尾。此外，规范路径必须是表示绝对路径的最短字符串。
 
 示例 1：
 
 输入："/home/"
 输出："/home"
 解释：注意，最后一个目录名后面没有斜杠。
 示例 2：
 
 输入："/../"
 输出："/"
 解释：从根目录向上一级是不可行的，因为根是你可以到达的最高级。
 示例 3：
 
 输入："/home//foo/"
 输出："/home/foo"
 解释：在规范路径中，多个连续斜杠需要用一个斜杠替换。
 示例 4：
 
 输入："/a/./b/../../c/"
 输出："/c"
 示例 5：
 
 输入："/a/../../b/../c//.//"
 输出："/c"
 示例 6：
 
 输入："/a//b////c/d//././/.."
 输出："/a/b/c"
 */


//k不是纯粹的栈  思路 ,分割字符串获取分割后的字符串数组  , 对数组中的数据进行进行栈操作
struct LeedCode_Array
{
    int size; //
    char * point;
    int  current;
    int count;
};

int  array_init(struct LeedCode_Array * array,int size){
    char * temp = malloc(size* sizeof(char));
    array->point = temp;
    memset(array->point, 0, size* sizeof(char));
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

int array_push(struct LeedCode_Array * array,char value){
    array->current += 1;
    array->point[array->current]=value;
    array->point[array->current+1]=0;
    array->count +=1;
    return  value;
}

int array_top(struct LeedCode_Array * array){
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

char * simplifyPath(char * path){
    int length = strlen(path);
    if (length==0) {
        return "/";
    }
    struct LeedCode_Array stack;
    array_init(&stack, length+2);
    array_push(&stack, '/');
    int currentRootLocation=0;
    int index=0;
    while (index<length) {
        if (path[index] =='/' && array_top(&stack)==path[index]) {
            index++;
            currentRootLocation=stack.count-1;
            continue;
        }
        if (path[index]=='.' && path[index+1] == '.') {
            bool head = false;
            bool tail = false;
            if (index==0 || path[index-1]=='/') {
                head = true;
            }
            if (index == length-2 || path[index+2]=='/') {
                tail = true;
            }
            if (head && tail) {
                index+=2;
                //后退
                char t=array_pop(&stack);
                if (array_isEmpty(&stack)) {
                    array_push(&stack, '/');
                }
                do {
                    t = array_pop(&stack);
                    if (array_isEmpty(&stack)) {
                        array_push(&stack, '/');
                        break;
                    }
                } while (t!='/');
                continue;
            }
        };
        if (path[index]=='.') {
            bool head = false;
            bool tail = false;
            if (index==0 || path[index-1]=='/') {
                head = true;
            }
            if (index == length-1 || path[index+1]=='/') {
                tail = true;
            }
            
            if (head && tail) {
                index++;
                continue;
            }
        }
        array_push(&stack, path[index]);
        index++;
    }
    if (stack.count>1 && stack.point[stack.count-1]=='/') {
        array_pop(&stack);
    }
    return stack.point;
}

struct LeedCode_Array_p
{
    int size; //
    char ** point;
    int  current;
    int count;
};

int  array_init_p(struct LeedCode_Array_p * array,int size){
    char * *temp = malloc(size* sizeof(char*));
    array->point = temp;
    memset(array->point, 0, size* sizeof(char*));
    if(array->point==NULL)
        return -1;
    array->size = size;
    array->count = 0;
    array->current = -1;
    return 0;
}

int array_isEmpty_p(struct LeedCode_Array_p * array){
    if (array->count==0) {
        return true;
    }
    return false;
}

char * array_push_p(struct LeedCode_Array_p * array,char* value){
    array->current += 1;
    array->point[array->current]=value;
    array->point[array->current+1]=0;
    array->count +=1;
    return  value;
}

char * array_top_p(struct LeedCode_Array_p * array){
    return array->point[array->current];;
}

char * array_pop_p(struct LeedCode_Array_p * array){
    char * value =array->point[array->current];
    array->count -=1;
    array->point[array->current]=0;
    array->current-=1;
    return value;
}


void array_free_p(struct LeedCode_Array_p * array){
    if(array->point!=NULL){
        free(array->point);
    }
}

void test(){
    char * s="/a/./b/../../c/";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}
void test1(){
    char * s="/../";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}
void test2(){
    char * s="/a/../../b/../c//.//";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}
void test3(){
    char * s="/home/";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}

void test4(){
    char * s="/a//b////c/d//././/..";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}
void test5(){
    char * s="/home//foo/";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}

void test6(){
    char * s="/...";
    char * r= simplifyPath(s);
    printf("%s\n",r);
}

void test7(){
    char * s="/home/../../..";
    char * r= simplifyPath(s);
    printf("%s\n",r);
   
}

int main(int argc, const char * argv[]) {
    test3();
    test1();
    test5();
    test();
    test2();
    test4();
    test6();
    test7();
    return 0;
}

//
//  main.m
//  1.两数之和
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 persion. All rights reserved.
//

#import <Foundation/Foundation.h>

///指针太难了



int* twoSum(int* nums, int numsSize, int target, int* returnSize){
    int* res = (int *)malloc(sizeof(int) * 2);
    * returnSize=0;
    for(int i = 0; i < numsSize-1; i++) {
        for(int j = i + 1; j < numsSize; j++) {
            if(nums[i] + nums [j] == target) {
                res[0] = i;
                res[1] = j;
                *returnSize = 2;
                return res;
            }
        }
    }
    return res;
}

struct hash_data{
    int key;
    int data;
    struct hash_data * next;
};

 struct hash_table
{
    struct hash_data ** head; //数组
    int hash_width;
};

///初始化
int hash_init(struct hash_table * table, int width){
    if(width<=0)
        return -1;
    struct hash_data **tmp = malloc(sizeof(struct hash_data *)*width);
    table->head = tmp;
    memset(table->head, 0, width * sizeof(struct hash_data *));
    if(table->head==NULL)
        return -1;
    table->hash_width = width;
    return 0;
}

///释放
void hash_free(struct hash_table table){
    if(table.head!=NULL){
        for (int i=0; i<table.hash_width; i++) {
            struct hash_data* element_head= table.head[i];
            while (element_head !=NULL) {
                struct hash_data* temp =element_head;
                element_head = element_head->next;
                free(temp);
            }
        }
        free(table.head);
        table.head = NULL;
    }
    table.hash_width = 0;
}

int hash_addr(struct hash_table table,int key){
    int addr =abs(key) % table.hash_width;
    return addr;
}

///增加
int hash_insert(struct hash_table table,int key, int value){
    struct hash_data * tmp = malloc(sizeof(struct hash_data));
    if(tmp == NULL)
        return -1;
    tmp->key = key;
    tmp->data = value;
    int k = hash_addr(table,key);
    tmp->next =table.head[k];
    table.head[k]=tmp;
    return 0;
}

///查找
struct hash_data* hash_find(struct hash_table table, int key){
    int k = hash_addr(table,key);
    struct hash_data* element_head=table.head[k];
    while (element_head !=NULL) {
        if ( element_head->key == key) {
            return element_head;
        }
        element_head = element_head->next;
    }
    return NULL;
}

///k两边哈希表
int* twoSum1(int* nums, int numsSize, int target, int* returnSize){
    int* res = (int *)malloc(sizeof(int) * 2);
    * returnSize=0;
    struct hash_table table;
    hash_init(&table, 100);
    for (int i=0; i<numsSize; i++) {
        hash_insert(table,nums[i] ,i);
    }
    
    for(int i = 0; i < numsSize; i++)
    {
        int value = target - nums[i];
        struct hash_data* data=  hash_find(table, value);
        if (data !=NULL && data->data != i) {
            res[1]=i;
            res[0]=data->data;
            * returnSize=2;
            break;
        }
    }
    hash_free(table);
    return res;
}

///一遍哈希表
int* twoSum2(int* nums, int numsSize, int target, int* returnSize){
    int* res = (int *)malloc(sizeof(int) * 2);
    * returnSize=0;
    struct hash_table table;
    hash_init(&table, 100);
    for(int i = 0; i < numsSize; i++)
    {
      int value = target - nums[i];
    struct hash_data* data=  hash_find(table, value);
        if (data !=NULL && data->data != i) {
            res[1]=i;
            res[0]=data->data;
            * returnSize=2;
            break;
        }
        hash_insert(table,nums[i] ,i);
    }
    hash_free(table);
    return res;
}

int main(int argc, const char * argv[]) {
    int nums[]={2, 7, 11, 15};
    int target = 9;
    int numsSize=4;
    int returnSize = 0;
    int * mm =  twoSun1(nums, numsSize, target, &returnSize);
    if (returnSize==2) {
        NSLog(@"%d %d",mm[0],mm[1]);
    }
    return 0;
}

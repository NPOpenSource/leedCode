//
//  main.m
//  两数相加
//
//  Created by glodon on 2019/9/19.
//  Copyright © 2019 persion. All rights reserved.
//

#import <Foundation/Foundation.h>

 struct ListNode {
         int val;
         struct ListNode *next;
};

//递归
int c=0;
struct ListNode* addTwoNumbers2(struct ListNode* l1, struct ListNode* l2){
    if(l1==NULL&&l2==NULL&&c==0)return NULL;
    l1!=NULL?(c+=l1->val,l1=l1->next):(c+=0);
    l2!=NULL?(c+=l2->val,l2=l2->next):(c+=0);
    struct ListNode *cur=(struct ListNode *)malloc(sizeof(struct ListNode));
    cur->val=c%10;
    c=c/10;
    cur->next=addTwoNumbers2(l1,l2);
    return cur;
}

///0空间解法
struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2){
    struct ListNode* p = l1;
    struct ListNode* q = l2;
    struct ListNode * tail =NULL;
    int carry = 0;
      while (p != NULL ) {
          int x =  p->val ;
          int y = (q != NULL) ? q->val : 0;
          int sum = carry + x + y;
        carry = sum / 10;
          p->val =sum % 10;
          tail=p;
          p = p->next;
          if (q != NULL)  q = q->next;
          if (p == NULL && q!=NULL) {
              //把q的尾巴 放入p中
              p=tail;
              p->next = q;
             p = p->next;
              q = NULL;
          }
      }
    
        if (carry>0) {
            tail->next = l2;
            l2->next = NULL;
            l2->val = carry;
        }
    return l1;
}

struct ListNode* addTwoNumbers1(struct ListNode* l1, struct ListNode* l2){
    struct ListNode* head = malloc(sizeof(struct ListNode));
    struct ListNode* p = l1;
    struct ListNode* q = l2;
    struct ListNode* curr = head;
    int carry = 0;
    while (p != NULL || q != NULL) {
        int x = (p != NULL) ? p->val : 0;
        int y = (q != NULL) ? q->val : 0;
        int sum = carry + x + y;
        carry = sum / 10;
        struct ListNode* tmp=malloc(sizeof(struct ListNode));
        tmp->val =sum % 10;
        tmp->next =NULL;
        curr->next =tmp;
        curr = curr->next;
        if (p != NULL) p = p->next;
        if (q != NULL) q = q->next;
    }
    if (carry > 0) {
        curr->next =malloc(sizeof(struct ListNode));
        curr->next->val =carry;
        curr->next->next =NULL;
    }
    return head->next;
}

int main(int argc, const char * argv[]) {
//    struct ListNode l111;
//    l111.val = 3;
//     l111.next = NULL;
//     struct ListNode l11;
//    l11.val = 4;
//    l11.next = &l111;
    struct ListNode l1;
    l1.val = 1;
    l1.next =NULL;
    
//    struct ListNode l211;
//    l211.val = 4;
//    l211.next = NULL;
    struct ListNode l21;
    l21.val = 9;
    l21.next = NULL;
    struct ListNode l2;
    l2.val = 9;
    l2.next =&l21;
    
   struct ListNode* result = addTwoNumbers(&l1, &l2);
    
    return 0;
}
//public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
//    ListNode dummyHead = new ListNode(0);
//    ListNode p = l1, q = l2, curr = dummyHead;
//    int carry = 0;
//    while (p != null || q != null) {
//        int x = (p != null) ? p.val : 0;
//        int y = (q != null) ? q.val : 0;
//        int sum = carry + x + y;
//        carry = sum / 10;
//        curr.next = new ListNode(sum % 10);
//        curr = curr.next;
//        if (p != null) p = p.next;
//        if (q != null) q = q.next;
//    }
//    if (carry > 0) {
//        curr.next = new ListNode(carry);
//    }
//    return dummyHead.next;
//}
//


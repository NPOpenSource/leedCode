# 题目
给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

示例：
```
输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
输出：7 -> 0 -> 8
原因：342 + 465 = 807
```

# 题解

### 官方题解
**思路**
我们使用变量来跟踪进位，并从包含最低有效位的表头开始模拟逐位相加的过程。
![图1，对两数相加方法的可视化: 342+465=807，每个结点都包含一个数字，并且数字按位逆序存储](https://upload-images.jianshu.io/upload_images/1682758-f965167618463c46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**算法**
就像你在纸上计算两个数字的和那样，我们首先从最低有效位也就是列表 l1 和 l2 的表头开始相加。由于每位数字都应当处于 0…9 的范围内，我们计算两个数字的和时可能会出现 “溢出”。例如，5+7=12。在这种情况下，我们会将当前位的数值设置为 2，并将进位 carry=1 带入下一次迭代。进位 carry 必定是 0 或 1，这是因为两个数字相加（考虑到进位）可能出现的最大和为 9+9+1=19。

伪代码如下：

+ 将当前结点初始化为返回列表的哑结点。
+ 将进位 carry 初始化为 0。
+ 将 p 和 q 分别初始化为列表 l1 和 l2 的头部。
+ 遍历列表 l1 和 l2 直至到达它们的尾端。
+ + 将 x 设为结点 p的值。如果 p 已经到达 l1 的末尾，则将其值设置为 0。
+ + 将 y 设为结点 q 的值。如果 q 已经到达 l2 的末尾，则将其值设置为 0。
+ + 设定 sum=x+y+carry。
+ + 更新进位的值，carry=sum/10。
+ + 创建一个数值为 (summod10) 的新结点，并将其设置为当前结点的下一个结点，然后将当前结点前进到下一个结点。
+ + 同时，将 p 和 q 前进到下一个结点。
+ 检查 carry=1 是否成立，如果成立，则向返回列表追加一个含有数字 1 的新结点。
+ 返回哑结点的下一个结点。

请注意，我们使用哑结点来简化代码。如果没有哑结点，则必须编写额外的条件语句来初始化表头的值。

请特别注意以下情况：
| 测试用例            | 说明                                               |
| ------------------- | -------------------------------------------------- |
| l1=[0,1],l2=[0,1,2] | 当一个列表比另一个列表长时                         |
| l1=[]，l2=[0,1]     | 当一个列表为空时，即出现空列表                     |
| l1=[9,9]，l2=[1]    | 求和运算最后可能出现额外的进位，这一点很容易被遗忘 |

##### 代码
```
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2){
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
```

#####  复杂度分析
+ 时间复杂度：
O(max(m,n))，假设 m 和 n 分别表示 l1 和 l2 的长度，上面的算法最多重复 max(m,n) 次。
+ 空间复杂度：
O(max(m,n))， 新列表的长度最多为 max(m,n)+1。


##### leadCode 执行截图
![](https://upload-images.jianshu.io/upload_images/1682758-6bbb138640d3b9de.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 其他解法
### 零空间解法
这个挺有意思的,就是使用原来的节点拼接成最终的结果返回.

思路如下
假设有两个链表L1,L2
+ 1.把L1,L2相同数量的node节点相加,结果保存到L1对应的节点上.
+ 2.要是L1的节点比L2的短,那么需要截取L2没有参加计算的节点放入L1的节点后面
+3. 要是L1 的节点不够用,那么需要从L2上获取头节点存入L1的尾部即可. 

```
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

```
> 这里会造成L2 的内存泄露,其实这里我们可以不获取尾巴节点,而获取L2,的最后一个节点就可以了. 就不做计算了.

# 其他解法
### 递归

```
int c=0;
struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2){
    if(l1==NULL&&l2==NULL&&c==0)return NULL;
    l1!=NULL?(c+=l1->val,l1=l1->next):(c+=0);
    l2!=NULL?(c+=l2->val,l2=l2->next):(c+=0);
    struct ListNode *cur=(struct ListNode *)malloc(sizeof(struct ListNode));
    cur->val=c%10;
    c=c/10;
    cur->next=addTwoNumbers(l1,l2);
    return cur;
}
```

> 摘抄其他人的写法,这里不做讲解

-----
[github地址](https://github.com/NPOpenSource/leedCode)
[两数相加](https://leetcode-cn.com/problems/add-two-numbers/)
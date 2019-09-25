# 题目
给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

示例 1:
```
输入: "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
```
示例 2:
```
输入: "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
```
示例 3:
```
输入: "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
```

# 题解
### 暴力法(官方翻译)

##### 思路
逐个检查所有的子字符串，看它是否不含有重复的字符。

##### 算法

假设我们有一个函数`bool allUnique(char * s,int start,int end)` ，如果子字符串中的字符都是唯一的，它会返回 true，否则会返回 false。 我们可以遍历给定字符串 s 的所有可能的子字符串并调用函数 allUnique。 如果事实证明返回值为 true，那么我们将会更新无重复字符子串的最大长度的答案。

现在让我们填补缺少的部分：

为了枚举给定字符串的所有子字符串，我们需要枚举它们开始和结束的索引。假设开始和结束的索引分别为 i 和j。那么我们有 0≤i<j≤n（这里的结束索引 j 是按惯例排除的）。因此，使用 i 从 0 到 n−1 以及 j 从i+1 到 n 这两个嵌套的循环，我们可以枚举出 s 的所有子字符串。
要检查一个字符串是否有重复字符，我们可以使用集合。我们遍历字符串中的所有字符，并将它们逐个放入 set 中。在放置一个字符之前，我们检查该集合是否已经包含它。如果包含，我们会返回 false。循环结束后，我们返回 true。

##### 代码
```
bool allUnique(char * s,int start,int end){
    int table[256]={0};
    for (int i=start; i<end; i++) {
        int m = table[s[I]];
        if (m==1) {
            return NO;
        }
        table[s[i]]=1;
    }
    
    return YES;
}

int lengthOfLongestSubstring1(char * s){
    int n =strlen(s);
    int ans = 0;
    for (int i = 0; i < n; i++){
        for (int j = i + 1; j <= n; j++){
            if (allUnique(s, i, j)) {
                if (ans<j-i) {
                    ans = j-i;
                }
            }
        }
    }
    return ans;
}
```
##### 复杂度分析

`时间复杂度：O(n³) 。`
要验证索引范围在 [i,j) 内的字符是否都是唯一的，我们需要检查该范围中的所有字符。 因此，它将花费 O(j−i) 的时间。
对于给定的 i，对于所有 j∈[i+1,n] 所耗费的时间总和为：
![](https://upload-images.jianshu.io/upload_images/1682758-aba8c9da9e377818.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
因此，执行所有步骤耗去的时间总和为：
![](https://upload-images.jianshu.io/upload_images/1682758-c14458c041fed7af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`空间复杂度：`O(min(n,m))，我们需要 O(k) 的空间来检查子字符串中是否有重复字符，其中 k 表示 Set 的大小。而 Set 的大小取决于字符串 n 的大小以及字符集/字母 m 的大小。

### 滑动窗口(官方翻译)
算法

暴力法非常简单，但它太慢了。那么我们该如何优化它呢？

在暴力法中，我们会反复检查一个子字符串是否含有有重复的字符，但这是没有必要的。如果从索引 i 到 j−1 之间的子字符串s <sub>ij</sub> 已经被检查为没有重复字符。我们只需要检查 s[j] 对应的字符是否已经存在于子字符串s <sub>ij</sub> 中。
要检查一个字符是否已经在子字符串中，我们可以检查整个子字符串，这将产生一个复杂度为 
O(n²) 的算法，但我们可以做得更好。
通过使用 HashSet 作为滑动窗口，我们可以用 O(1) 的时间来完成对字符是否在当前的子字符串中的检查。
滑动窗口是数组/字符串问题中常用的抽象概念。 窗口通常是在数组/字符串中由开始和结束索引定义的一系列元素的集合，即 [i,j)（左闭，右开）。而滑动窗口是可以将两个边界向某一方向“滑动”的窗口。例如，我们将 [i,j) 向右滑动 1 个元素，则它将变为 [i+1,j+1)（左闭，右开）。
回到我们的问题，我们使用 HashSet 将字符存储在当前窗口 [i,j)（最初 j=i）中。 然后我们向右侧滑动索引 j，如果它不在 HashSet 中，我们会继续滑动 j。直到 s[j] 已经存在于 HashSet 中。此时，我们找到的没有重复字符的最长子字符串将会以索引 i 开头。如果我们对所有的 i 这样做，就可以得到答案。
这图解很详细
![](https://upload-images.jianshu.io/upload_images/1682758-580bf3dd511e42a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


```
int lengthOfLongestSubstring(char * s){
     int n =strlen(s);
    int ans = 0, i = 0, j = 0;
     int table[256]={0};
    while (i < n && j < n) {
          int m = table[s[j]];
        // try to extend the range [i, j]
        if (m==0){
           table[s[j]]=1;
            j++;
            if (ans<j-i) {
                ans=j-i;
            }
          
        }
        else {
            table[s[i]]=0;
            I++;
        }
    }
    return ans;
}

```
##### 复杂度分析

`时间复杂度：`
O(2n)=O(n)，在最糟糕的情况下，每个字符将被 i 和 j 访问两次。
> 例如字符串 `bbbbbb`

`空间复杂度：`
O(min(m,n))，与之前的方法相同。滑动窗口法需要 O(k) 的空间，其中 
k 表示 Set 的大小。而 Set 的大小取决于字符串 n 的大小以及字符集 / 字母 m 的大小。

# 优化的滑动窗口(官方翻译)
上述的方法最多需要执行 2n 个步骤。事实上，它可以被进一步优化为仅需要 n 个步骤。我们可以定义字符到索引的映射，而不是使用集合来判断一个字符是否存在。 当我们找到重复的字符时，我们可以立即跳过该窗口。

也就是说，如果 s[j] 在 [i,j) 范围内有与  j'重复的字符，我们不需要逐渐增加 i 。 我们可以直接跳过[i,j'] 范围内的所有元素，并将 i 变为j'+1. 

图例如下

![](https://upload-images.jianshu.io/upload_images/1682758-eba0674b87999798.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
#define max(a, b) ((a)>(b)?(a):(b))

int lengthOfLongestSubstring(char * s){
      int n =strlen(s);
     int ans = 0;
      int table[256]={0};
    for (int j = 0, i = 0; j < n; j++) {
        int tem= table[s[j]];
        i=  max(tem, i);
        ans = max(ans, j-i+1);
        table[s[j]] = j + 1;
    }
    return ans;
}
```

-----------
[无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/)
[github地址](https://github.com/NPOpenSource/leedCode)
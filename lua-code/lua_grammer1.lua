--lua语法 Part.1
print("hello world!")

--[[lua的几种注释方法]]
--lua的几种注释方法

--lua关键字
and break false true local elseif end in repeat function if or 
until nil not return then else while do for

eg1.
print(b)--lua中全局变量不需要声明，b未初始化，因此打印的结果为nil
eg2.
b = 10
print(b) --全局变量b赋值为10，则打印结果也为10

--lua的八种数据类型：nil，boolean，number,string,userdata,function
,thread,table，想知道lua中的变量为何种数据类型使用print(type(变量))

eg3.
print(type("Hello Jane"))
pring(type(123))

nil代表没有任何的有效值，例如打印一个没有赋值的变量时，总会输出nil
boolean有两个可选值 true 和false，在lua中只把false和nil看为假，其余都为真。
number默认只有一种类型double
string由一对单引号或者双引号来表示，也可以使用[[]]来表示字符块

eg4.
html = [[<p>hello,world!!</p>]]
print(html)
当对一个数字字符串进行运算的时候，kua会尝试现将这个数字字符串转化为数字

eg5.
>print("3"+2) = print(3+2)
>5
>print("2+3")
>2+3
字符串的连接通过“..”

eg6.
>print("hello".."world")
>helloworld
计算字符串的字符长度使用"#"
>word = hello
>print(#word)
>5
table的创建方式很简单，使用{}就可以创建一个空表

eg7.
>local t = {}
>local t = {1,2,3,4,5} --直接赋值初始化表1,2,3,4,5
在table中表的默认初始索引为1，而不是0，以上面的表为例:
>for key,val in pairs(t) do
>  print("Key为",key)
>end
我们执行该文件将会得到的结果为:
Key为 1
Key为 2
Key为 3
Key为 4
Key为 5

function在lua中被看作第一类值，函数可以存放在变量中:

eg8.
function test1(n)
if n==1 then
 return 1
else return n * test1(n-1)
end
end
test2 = test1
print(test1(1))
print(test2(1))

table可以以匿名函数的方式传参：

eg9.
function anonymous(data,fun)
for k,v in pairs(data) then
 print(fun(k,v))
end
end
local t = {a,b}
anonymous(t,function(k,v)
return k.."="..v
end)

然后我们看一下执行结果:
1==a
2==b

thread,顾名思义，线程的意思，但是在lua中主要的线程是coroutine，
拥有自己的独立的栈，局部变量和指令指针，线程和协程的区别是，线程
可以同时有多个同时运行，但是协程只能同一时间运行一个，并且处于运行
状态的协程只有当被挂起后才能暂停。

全局变量和局部变量注意点：
局部变量的作用域是从声明位置开始到所在语句块结束.

循环语句：
1)while(true)
do
...
end

2)for ()
do
...
end

3)repeat ... until
4)循环嵌套

条件判断语句：
if（...）then
...
end

if (...)then
...
else if () then
...
end


--lua语法 Part.2

lua的元表

setmetatable(table,metatable)
getmetatable(table)

单纯的去看这两个函数感觉没什么，下面我们举两个例子
来深刻的理解一下lua元表

mytable = {}
mymetatable = {}
setmetatable(mytable,mymetatable)
这就等同于：
setmetatable({},{})
lua的元表有几个常用的元方法:_index,_newindex,_tostring，下面将通过
几个实例来帮助理解他们:
>h = {foo=3}
>t = setmetatable({},{_index=h})
>t.foo
3
>t.bar
nil
_index是元表中最常用的键，当通过键访问表的时候，如果这个键
没有值，会寻找其元表中的_index键，如果_index包含一个表格，
则lua会在表格中找对应的键，下面再来看一下_newindex:
>mymetatable = {}
>mytable = setmetatable({key1="v1"},{_newindex=mymetatable})
>print(mytable.key1)
v1
>mytable.newkey = "xin2"
>print(mytable.newkey,mymetatable.newkey)
xin2,nil
>mytable.key1 = "xin1"
>print(mytable.key1,mymetatable.key1)
xin1,nil
_newindex用来对表进行更新，当对一个表不存在的索引进行赋值的时候，解释器会
查找是否存在_newindex元方法，如果_newindex存在则调用这个函数而不进行赋值
操作。
>mytable = setmetatable({1,2,3,},{_tostring = function(mytable)
>sum = 0
>for k,v in pairs(mytable)do
>sum = sum+v
>end
>return sum
>end})

--lua中的协同程序
这一部分在此仅展示一些常用的关于coroutine的基本函数，具体代码示例请查看
同目录下lua-coroutine.lua。
我们用到的基本函数有:
coroutine.create()--创建并返回coroutine，参数是一个函数，和resume配合使用的
时候唤醒函数调用。

coroutine.resume()--重启coroutine，和create配合使用。

coroutine.yield()--挂起coroutine。

coroutine.status()--查看coroutine的状态。(dead,suspend,running)

coroutine.wrap()--创建coroutine，返回一个函数，一旦调用这个函数就进入coroutine。

coroutine.running()--返回正在跑的coroutine，一个coroutine就是一个线程，当使用
此命令的时候，返回一个coroutine的线程号。

--lua中的错误判断以及错误处理
一般使用assert和error来处理错误
eg.
>function add(a,b)
>assert(type(a)=="number","a不是数字，传参有误！")
>assert(type(b)=="number","b不是数字，传参有误！")
>return a+b
>end
>add(1)
这段代码则会报错：
stdin:3: b不是数字，传参有误！
stack traceback:
	[C]: in function 'assert'
	stdin:3: in function 'add'
	(...tail calls...)
	[C]: in ?

error的使用非常简单，只要在条件判断可能会出现错误的分支加上error("msg")就可以。

我们还可以使用pcall或者xpcall去帮我们处理错误：

eg.
>pcall(function f() print(1) end,33)
33
true
因此我们可以根据pcall对函数的执行结果做相应的处理:
>if pcall(function f() print(1) end,33) then
>...--没出错的情况
>else
>...--错误处理
>end
而对于xpcall我们可以使用xpcall(function f() print(1) end,function errorhandler)的用法
针对发生的问题，在第二个错误处理函数中进行错误处理.

--lua中的数据库访问

一般访问和配置lua对数据库的使用都大同小异，这里只以mysql为例：
首先我们需要安装luasql库,这里不再赘述，直接上代码吧,我会对代码的每一句话都做好说明。

reqire "luasql.mysql" --引入mysql
msl = luasql.mysql() --创建环境对象
con = msl:connect("dbname","username","passwd","ip","port")
con:ececute"SET NAMES UTF8"
cur = con:execute(select * from tablename)
row = cur:fetch({},"a")
file = io.open("data.txt","+w")
while row do
var = string.format("%d %s\n",row.id,row.name)
print(var)
file:write(var)
row = cur:fetch(row,"a")
end
file.close
con.close
msl.close






--本小节将着重讲解关于coroutine的使用
我们先创建一个实例：
eg.
>co = coroutine.create(function(i) print(i); end)
>coroutine.resume(co,1)
>print(coroutine.status(co))
>print("-----------------------------")
>co1 = coroutine.wrap(function(i) print(i); end)
>co1(1)
>print("-----------------------------")

>co2 = coroutine.create(
>function()
>for i=1,10 do
>  print(i)
>if i==3 then
>  print(coroutine.status(co2))
>print(coroutine.running())
>end
>coroutine.yield()
>end
>end
> )
>coroutine.resume(co2)
>coroutine.resume(co2)
>coroutine.resume(co2)
>coroutine.resume(co2)
>print(coroutine.status(co2))
>>print(coroutine.running())
输出结果为：
1
dead
-----------------------------
1
-----------------------------
1
2
3
running
thread: 0x7fb459c0bc28	false
4
suspended
thread: 0x7fb459c05878	true
-----------------------------

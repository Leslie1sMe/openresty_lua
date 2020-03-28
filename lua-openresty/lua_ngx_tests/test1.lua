--ngx_lua_module的一些api的使用
--ngx.arg 上下文环境 set_by_lua,body_filter_by_lua
--[[
    location /test1{
        set $a 1;
        set $b 2;
        set_by_lua $sum 'return tonumber(ngx.arg[1]) + tonumber(ngx.arg[2])' $a $b;
        echo $sum;
        }
]]--
--ngx.var.VARIABLE 用于读写nginx的值,设置为nil则取消这个变量
--[[
    location /test2{
        set $v '';
        content_by_lua_block {
            ngx.var.v = 123;
            ngx.say(ngx.var.v);
        }
        }
]]--
--ngx.ctx这个表存放每个请求的Lua上下文，并且为当前请求保存一个生命周期。
--[[
    eg.1
    location /test3{
        content_by_lua_block{
            ngx.ctx.foo = 3
        }
        access_by_lua_block{
            ngx.ctx.foo = ngx.ctx.foo+3
        }
        content_by_lua_block{
            ngx.say(ngx.ctx.foo)
        }
        }
    eg.2
    location /test4{
       content_by_lua_block{
           ngx.ctx.v = 10
           ngx.say("test4 pre:",ngx.ctx.v)
           local rs = ngx.location.capture("/test5")
           ngx.print(rs.body)
           ngx.say("test4 after:",ngx.ctx.v)
       }
        }
    location /test5{
        content_by_lua_block{
            ngx.say("test5 pre:",ngx.ctx.v)
            ngx.ctx.v = 3
            ngx.say("test5 after:",ngx.ctx.v)
            }
        }
    
]]--



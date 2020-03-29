--在nginx下用lua访问redis的方法
--[[
    location /test14{
        content_by_lua_file /path/to/lua_redis_test.lua;
    }
]]--
local redis = require "redis"
local r = redis:new()
redis:set_timeout(1000)
local ok,err = r:connect("127.0.0.1",'6379')
if not ok then
    ngx.say("fail to connect",err)
end
--get获取key的值
r:select(0)
local res,err = r:get("dog")
if not res then
    ngx.say("failed")
end
--set添加键值对
ok,err = r:set("dog","拉布拉多")
if not ok then
    ngx.say(err)
end
ngx.say(r:get("dog"))
ok,err = r:hmset(cat,{cat1="2",cat2="3"})
--lua_resty_redis包括了redis所有的命令，但是要注意提前引入lua_package_path的路径，保证库文件被正确的加载引用
--设置方法 lua_package_path '/path/to/package/resty/?.lua;;"

--lua-resty-mysql
--[[
    location /test15{
        content_by_lua_file /path/to/lua_redis_test.lua;
    }
]]

local mysql = require "resty.mysql"
local msl,err = mysql:new()
if not msl then
    ngx.say("failed to instantiate mysql:",err)
    return
end
ok,err = msl:connect({host="127.0.0.1",port="3306",user="root",password="",database="employees"})
if not ok then
    ngx.say("failed to connect mysql:",err)
    return
end

res,err = msl:query("select * from titles")
if not res then
    ngx.say(err)
end
local cjson = require "cjson"
ngx.say(cjson.encode(res))

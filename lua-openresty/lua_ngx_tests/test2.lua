--ngx.location.capture
--[[
    location /test6{
        content_by_lua_block {
            res = ngx.location.capture("/test7?a=12&b=34")
            #等价于ngx.location.capture("/test7",{a=12,b=34})
            ngx.print(res.body)
        }
        }
]]--
--ngx.resp.get_headers
--[[
    location /test7{
        content_by_lua_block {
            local res = ngx.resp.get_headers()
            for i,v in pairs(res) do
                ngx.print(v)
            end

        }
        }
]]--
--ngx.req.raw_header()
--[[
    location /test8{
        content_by_lua_block {
            local res = ngx.resp.raw_header()
            for i,v in pairs(res) do
                ngx.print(i,v)
            end

        }
        }
]]--
--ngx.req.set_uri
--[[
    location /test9{
        rewrite_by_lua_block {
            ngx.req.set_uri("/test5",true)
        }
        }
]]--
--ngx.req.get_post_args
--[[
    location /test10{
        content_by_lua_block {
            ngx.req.read_body()
            res,err = ngx.req.get_post_args()
            if not res then
                ngx.say("failed to get post args",err)
                return
            end
            for k ,v in pairs(res) do
                if type(v) == "table" then
                    ngx.say(k,":",table.concat(v,','))
                else
                    ngx.say(k,":",v)
                end
            end
        }
        }
]]--

--ngx.redirect()
--[[
    location /test11{
        content_by_lua_block{
            ngx.redirect("/test5")
        }
    }
]]
--ngx.encode_args和ngx.decode_args
--[[
    location /test12{
        content_by_lua_block{
            local v = {a=1,b=2,c=3}
            res = ngx.encode_args(v)
            ngx.print(res)
            local r = ngx.decode_args(res)
            for k,v in pairs(r) do
                ngx.print(k,":",v)
            end
        }
    }
]]--
--ngx.req.get_uri_args
--[[
    location /test13{
        content_by_lua_block{
            args = ngx.req.get_uri_args()
            for k,v in pairs(args) do
                if type(v) ~="table" then
                ngx.print(k,":",v)
                else
                ngx.print(k,table.concat(v,","))
                end
            end
        }
    }
]]--

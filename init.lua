local redis = require("resty.redis")
local red = redis:new()
red:set_timeouts(1000, 1000, 1000)
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then 
    ngx.say("failed to connect: ", err)
    -- return false
end
local res,ok = red:auth("heyao")
if not res then
	ngx.log(ngx.ERR,"failed to auth redis")
end
ngx.ctx.red = red
local redis = require("resty.redis")
local red = redis:new()
red:set_timeouts(1000, 1000, 1000)
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then 
    ngx.say("failed to connect: ", err)
    -- return false
end
ngx.ctx.red = red
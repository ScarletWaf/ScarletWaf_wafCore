local Config = require("config")
local Flag = Config.flag


local function getIp()
    local red=ngx.ctx.red
    local client_IP = ngx.req.get_headers()["X-Real-IP"]
    if client_IP == nil then
        client_IP = ngx.req.get_headers()["X_Forwarded_For"]
    end
    if client_IP == nil then
        client_IP = ngx.var.remote_addr
    end
    return client_IP
end


local function hitURI(red)
	-- 计数
end

local function hitRule(key,rule,red)
	-- 计数
end



local function baseKeyGen(ruleName)
    return ("BASE"..ruleName)
end

local function customKeyGen(ruleName)
    return (ngx.var.host..ngx.var.uri..ruleName)
end


local function getConfig(flag,red)
    local host = ngx.var.host
    local uri = ngx.var.uri
    local config ,err
    if flag == Flag.custom then
        config ,err=red:hgetall(host..uri)
    elseif flag == Flag.base then
        config,err = red:hgetall(host)
    end
    if err~=nil then ngx.log(ngx.Err,"Fail to get Config for :",host);return end
    ngx.say("检查 config<br>")
    for i , v in pairs(config) do
        ngx.say(i,"----->",v,"<br>")
    end
    return config
end

local function syncConfig(base,target)
    if type(base)~=type({}) or type(target)~=type({}) then ngx.log(ngx.ERR,"Table needed in syncConfig");return; end
    for name ,value in pairs(base) do
        if target[name]~=nil then base[name] = target[name] end
    end
end



local utils={}
utils.base_key_gen=baseKeyGen
utils.custom_key_gen=customKeyGen
utils.get_config= getConfig
utils.sync_config = syncConfig
utils.hit_rule=hitRule
utils.hit_uri=hitURI

return utils


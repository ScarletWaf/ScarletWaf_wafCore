local Config = require("config")
local Flag = Config.flag
local Cjson = require("cjson")


local function getIp()
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
    return (ngx.var.host.."@BASE@"..ruleName)
end

local function customKeyGen(ruleName)
    return (ngx.var.host.."@"..ngx.var.uri.."@"..ruleName)
end


local function getConfig(flag,red)
    local host = ngx.var.host
    local uri = ngx.var.uri
    local config ,err
    local res={}
    if flag == Flag.custom then
        config ,err=red:hgetall("CONFIG@"..host.."@"..uri)
    elseif flag == Flag.base then
        config,err = red:hgetall("CONFIG@"..host.."@".."BASE")
    end
    if err~=nil then ngx.log(ngx.ERR,"Fail to get Config for :",host);return end

    for i , v in pairs(config) do
        if (v== "true") or (v=="1")then
            config[i]=true
        elseif (v=="false") or (v=="0")then
            config[i]=false
        end
    end
    for i = 1,#config do
        if (i%2==0)then
            res[config[i-1]]=config[i]
        end
    end
    if Config.develop then ngx.say("检查 config<br>")end
    for i , v in pairs(res) do
        if Config.develop then ngx.say(type(i),"  ",i,"----->",type(v),"  ",v,"<br>") end
    end
    return res
end

-- redis中只能存字符串 存进去的布尔值 拿出来就成字符串了
local function syncConfig(base,target)
    if type(base)~=type({}) or type(target)~=type({}) then ngx.log(ngx.ERR,"Table needed in syncConfig");return; end
    for name ,value in pairs(base) do
        if target[name]~=nil  then base[name] = target[name] end
    end
end

local function logGen(configName)
    local item ={}
    item.time=ngx.now()
    item.rule=configName
    item.ip=ngx.var.remote_addr
    item.uri=ngx.var.uri
    item = Cjson.encode(item)
    return item
end

-- 妄想两次URLencode来绕过 👨笑了 Simple trick only work when developer is a idiot -> who decode again after framework does...
local function Unescape(args)
    for index,item in pairs(args) do
        args[index]=ngx.unescape_uri(item)
    end
    return args
end


local utils={}
utils.base_key_gen=baseKeyGen
utils.custom_key_gen=customKeyGen
utils.get_config= getConfig
utils.sync_config = syncConfig
utils.hit_rule=hitRule
utils.hit_uri=hitURI
utils.log_gen=logGen
utils.unescape=Unescape

return utils


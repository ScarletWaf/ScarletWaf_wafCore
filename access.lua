local Config = require("config")
local Swtich = Config.swtich
local Option = Config.option
local Flag = Config.flag
local Utils = require("utils")
local Lib = require("lib")
local red = ngx.ctx.red

local hostConfig = Utils.get_config(Flag.base,red)
local uriConfig = Utils.get_config(Flag.custom,red)

local accessConfig ={
    	["waf_status"] = Swtich.waf_status,        -- 特判
        ["ip_whitelist"] = Swtich.ip_whitelist,    -- 特判
      }

--------------------------- 准入特判
-- host设置覆盖默认
Utils.sync_config(accessConfig,hostConfig)

if accessConfig["waf_status"]==false then return
	elseif accessConfig["ip_whitelist"]==true and Lib.ip_whitelist(Flag.base,red)==true then return end

-- uri层覆盖host层
Utils.sync_config(accessConfig,uriConfig)

if accessConfig["waf_status"]==false then return
	elseif accessConfig["ip_whitelist"]==true and Lib.ip_whitelist(Flag.custom,red)==true then return end

--------------------------- 准入判断

local checkConfig = {
	["ip_blacklist"] = Swtich.ip_blacklist,
    ["get_args_check"] = Swtich.get_args_check,
    ["post_args_check"] = Swtich.post_args_check,
    ["cookie_check"] = Swtich.cookie_check,
    ["ua_check"] = Swtich.ua_check,
    ["cc_defense"] = Swtich.cc_defense,
}

local checkFuncs = {
	["ip_blacklist"] = Lib.ip_blacklist,
    ["get_args_check"] = Lib.get_args_check,
    ["post_args_check"] = Lib.post_args_check,
    ["cookie_check"] = Lib.cookie_check,
    ["ua_check"] = Lib.ua_check,
    ["cc_defense"] = Lib.cc_defense,
}

-- host设置覆盖默认
Utils.sync_config(checkConfig,hostConfig)

for configName , configValue in pairs(checkConfig) do
	ngx.say("BASE>当前检查项",configName,"状态:",configValue,"<br>")
	if configValue==true then
		ngx.log(ngx.WARN,"即将测试",configName)
		local status = checkFuncs[configName](Flag.base,red)
		if status~=true then
			-- require("log")
			-- 此处Rewrite
			ngx.say("非法Access ,在base中触发 ",configName)
			return
		end
	end
end

-- uri层覆盖host层
Utils.sync_config(checkConfig,uriConfig)
for configName , configValue in pairs(checkConfig) do
	ngx.say("CUSTOM>当前检查项",configName,"状态:",configValue,"<br>")
	if configValue==true then
		ngx.log(ngx.WARN,"即将测试",configName)
		local status = checkFuncs[configName](Flag.base,red)
		if status~=true then
			-- require("log")
			-- 此处Rewrite
			ngx.say("非法Access ,在custom中触发 ",configName)
			return
		end
	end
end
ngx.say("Welcome")




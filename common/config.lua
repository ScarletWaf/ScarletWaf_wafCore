
-- waf config file, to setting moudle enable='on'  disable='off'
---------------------------------------------------------------------
-- waf status
local swtich ={}

swtich.waf_status = true
---------------------------------------------------------------------
-- url_whitelist status
swtich.uri_whitelist = true

-- ip_blacklist status
swtich.ip_blacklist = true

-- ip_whitelist status
swtich.ip_whitelist = true

-- passproxy status
swtich.proxy_pass = true

-- get_args_check status
swtich.get_args_check = true

-- post_args_check status
swtich.post_args_check = true

-- Cookie_safe_check status
swtich.cookie_check= true

-- UA safe Check status
swtich.ua_check = true

-- CC Attack Defense status
swtich.cc_defence = true

-- frequency limit
local option ={}
option.cc_rate = "10/60"

option.output_type = "html"   -- 从waf_out更名至 OUTPUT_TYPE

-- If waf detect dangerous request, redirect utl.
option.redirect_uri = "/warning.html" 

-- safe_access log file position
option.safe_log = "logs/safe_access.log" 

-- dangerous log file position
option.danger_log = "logs/danger.log" 


-- 控制custom匹配的flag
local flag={}
flag.base=0
flag.custom=1


-- config表
local config={}
config.swtich =swtich
config.option = option
config.key = key
config.flag = flag


return config



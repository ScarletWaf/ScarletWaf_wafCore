
-- waf config file, to setting moudle enable='on'  disable='off'
---------------------------------------------------------------------
-- waf status
local switch ={}

switch.waf_status = false
---------------------------------------------------------------------
-- url_whitelist status
switch.uri_whitelist = false

-- ip_blacklist status
switch.ip_blacklist = false

-- ip_whitelist status
switch.ip_whitelist = false

-- passproxy status
switch.proxy_pass = false

-- get_args_check status
switch.get_args_check = false

-- post_args_check status
switch.post_args_check = false

-- Cookie_safe_check status
switch.cookie_check= false

-- UA safe Check status
switch.ua_check = false

-- CC Attack Defense status
switch.cc_defense = false

-- tokenlize sql detect
switch.sql_token_check = false

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

-- 增加环境变量，控制DEBUG输出
local develop=false

-- config表
local config={}
config.switch =switch
config.option = option
config.flag = flag
config.develop=develop


return config



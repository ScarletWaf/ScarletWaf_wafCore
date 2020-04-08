local log = {}

-- OpenResty 比较擅长的是高并发网络处理，在这个环境中，任何文件的操作，都将阻塞其他并行执行的请求。
-- 实际中的应用，在 OpenResty 项目中应尽可能让网络处理部分、文件 I/0 操作部分相互独立，不要揉和在一起。


-- 想了想，此处采用消息队列，交给后端来完成文件读写
local function record(item,red)
	local res,err
	local key = ngx.var.host.."@log"
	res,err = red:lpush(key,item)
	if (err~=nil) then ngx.log(ngx.ERR,"Failed to log err: ",err) end
	-- debug 
	ngx.say("Push item ",item,"to ",key,"<br>")
	return
end 

log.record = record
return log
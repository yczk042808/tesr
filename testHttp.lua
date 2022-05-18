-- @module http.testHttp

module(...,package.seeall)

require"http"
local mp=require "testHttpPlayMp3"

local function cbFnc(result,prompt,head,body)
    log.info("testHttp.cbFnc",result,prompt)
    if result and body then
        log.info("testHttp.cbFnc","bodyLen="..body)
        -- if body=='0' then

        -- elseif body=="1" then
            
        -- elseif body=="2" then
            
        -- elseif body=="3" then
            
        -- else
            mp.playmp3("ai.walof.ml/speak/"..body.."mp3")
        -- end
    end
end

local function cbFncFile(result,prompt,head,filePath)
    log.info("testHttp.cbFncFile",result,prompt,filePath)
    if result and head then
        for k,v in pairs(head) do
            log.info("testHttp.cbFncFile",k..": "..v)
        end
    end
    if result and filePath then
        local size = io.fileSize(filePath)
        log.info("testHttp.cbFncFile","fileSize="..size)
        
        --输出文件内容，如果文件太大，一次性读出文件内容可能会造成内存不足，分次读出可以避免此问题
        if size<=4096 then
            log.info("testHttp.cbFncFile",io.readFile(filePath))
        else
			
        end
    end
    --文件使用完之后，如果以后不再用到，需要自行删除
    if filePath then os.remove(filePath) end
end

function uptoai(filepath)
    http.request("POST","ai.walof.ml",nil,
         {['Content-Type']="application/octet-stream",['Connection']="keep-alive"},
         {[1]={['file']=filepath}},
         nil,cbFnc)
end

function tolove(filepath)
    http.request("POST","blog.akang.icu",nil,
         {['Content-Type']="application/octet-stream",['Connection']="keep-alive"},
         {[1]={['file']=filepath}},
         nil,function ()
       audio.play(99, 'FILE', filepath, 8, nil)
         end)
end
--如下示例代码是利用文件流模式，上传录音文件的demo，使用的URL是随意编造的
-- http.request("POST","ai.walof.ml",nil,
--          {['Content-Type']="application/octet-stream",['Connection']="keep-alive"},
--          {[1]={['file']="/lua/z.wav"}},
--          nil,cbFnc)
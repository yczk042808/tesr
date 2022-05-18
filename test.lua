module(...,package.seeall)
local m= require "music"
require "sys"
require "record"
local upload=require "testHttp"
require "powerKey"

powerKey.setup(3000, control, startr)


function startr()
if not record.isBusy then
    record.start(0x7FFFFFFF,dealrecord,'FILE',3,1,1,nil)
    return 0
else
    record.stop()
end
end

function dealrecord(result,size)
    if mode=='chat' then
        upload.uptoai(record.getFilePath())
    else
        upload.tolove(record.getFilePath())
    end
end

function comtrol()
    if mode=="chat" then
        startr()
    elseif mode=="listentolove" then
        startr()
    end
end
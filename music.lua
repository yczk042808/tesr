-- @module http.music
module(...,package.seeall)
require "http"
local f=require "testHttpPlayMp3"

_G.l={}
local function deallist(result,prompt,head,body)
    log.info("testHttp.cbFnc",result,prompt)
    if result and body then
        local re=json.decode(body)
        local nu=1
        local tmp=""
        while not(tmp==nil) do
            tmp=re[tostring(nu)]
            l[nu]=tmp
            log.info(tostring(nu),tmp)
            nu=nu+1            
        end
    end
end

local function dealurl(result,prompt,head,body)
    log.info("testHttp.cbFnc",result,prompt)
    if result and body then
        local re=json.decode(body)
        -- f.playmp3(re['url'])
    end
end


function getlist(id)
    if id==nil then
        id='7428751015'
    end
   http.request('GET', "ai.walof.ml/music.php?id="..id, nil, nil, nil, nil, deallist)
   log.info("gvvg",l[1])

end

function play(mid)
    _G.mid=mid
 http.get('http://music.cyrilstudio.top/song/url?'..mid,nil,dealurl)
end
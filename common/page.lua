local page={}
local head = [[
<!DOCTYPE html>
<html>
<head>
  <title>ScarletWAF</title>
</head>
<body>
<div id="app">
   <div>
]]
local code =[[403]]
local code_text=[[</div>
   <div class="txt">]]
local text =[[Forbidden By ScarletWAF]]
local text_blink=[[<span class="blink">]]
local blink=[[_]]
local blink_end=[[</span>
   </div>
</div>
<style>
/* cyrillic-ext */
@font-face {
  font-family: 'Press Start 2P';
  font-style: normal;
  font-weight: 400;
  src: local('Press Start 2P Regular'), local('PressStart2P-Regular'), url(https://fonts.gstatic.com/s/pressstart2p/v8/e3t4euO8T-267oIAQAu6jDQyK3nYivNm4I81PZQ.woff2) format('woff2');
  unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
}
/* cyrillic */
@font-face {
  font-family: 'Press Start 2P';
  font-style: normal;
  font-weight: 400;
  src: local('Press Start 2P Regular'), local('PressStart2P-Regular'), url(https://fonts.gstatic.com/s/pressstart2p/v8/e3t4euO8T-267oIAQAu6jDQyK3nRivNm4I81PZQ.woff2) format('woff2');
  unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}
/* greek */
@font-face {
  font-family: 'Press Start 2P';
  font-style: normal;
  font-weight: 400;
  src: local('Press Start 2P Regular'), local('PressStart2P-Regular'), url(https://fonts.gstatic.com/s/pressstart2p/v8/e3t4euO8T-267oIAQAu6jDQyK3nWivNm4I81PZQ.woff2) format('woff2');
  unicode-range: U+0370-03FF;
}
/* latin-ext */
@font-face {
  font-family: 'Press Start 2P';
  font-style: normal;
  font-weight: 400;
  src: local('Press Start 2P Regular'), local('PressStart2P-Regular'), url(https://fonts.gstatic.com/s/pressstart2p/v8/e3t4euO8T-267oIAQAu6jDQyK3nbivNm4I81PZQ.woff2) format('woff2');
  unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}
/* latin */
@font-face {
  font-family: 'Press Start 2P';
  font-style: normal;
  font-weight: 400;
  src: local('Press Start 2P Regular'), local('PressStart2P-Regular'), url(https://fonts.gstatic.com/s/pressstart2p/v8/e3t4euO8T-267oIAQAu6jDQyK3nVivNm4I81.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}
html, body {
  width: 100%;
  height: 100%;
  margin: 0;
}

* {
  font-family: "Press Start 2P", cursive;
  box-sizing: border-box;
}

#app {
  padding: 1rem;
  background: black;
  display: flex;
  height: 100%;
  justify-content: center;
  align-items: center;
  color: #54FE55;
  text-shadow: 0px 0px 10px;
  font-size: 6rem;
  flex-direction: column;
}
#app .txt {
  font-size: 1.8rem;
}

@keyframes blink {
  0% {
    opacity: 0;
  }
  49% {
    opacity: 0;
  }
  50% {
    opacity: 1;
  }
  100% {
    opacity: 1;
  }
}
.blink {
  animation-name: blink;
  animation-duration: 1s;
  animation-iteration-count: infinite;
}
</style>
</body>
</html>]]

-- function with default params 
-- param $1 code int
-- param $2 text string
-- param $3 blink string
local function black_page(t)
	setmetatable(t,{__index={code=404, text="Forbidden by ScarletWAF",blink="_"}})
    local code,text,blink =
      t[1] or t.code, 
      t[2] or t.text,
      t[3] or t.blink
    -- function continues down here...
    local html = head..code..code_text..text..text_blink..blink..blink_end
    ngx.say(html)
end

page.black_page = black_page

return page
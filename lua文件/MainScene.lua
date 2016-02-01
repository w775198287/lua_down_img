
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    self.visibleSize = cc.Director:getInstance():getVisibleSize()


    local function requestImgOnInternet()
   	    local xhr = cc.XMLHttpRequest:new()
    	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    	xhr:open("GET", "https://raw.githubusercontent.com/w775198287/lua_down_img/master/img/230905.png")


        local function onReadyStateChanged()
            
        	if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
        		print("下载成功")
        		local a = "230905.png"
        		local writablePath = cc.FileUtils:getInstance():getWritablePath()..a --app沙盒
        		print(writablePath)
                --写入保存
        		local file = io.open(writablePath,"w")
        		file:write(xhr.response)
        		file:close()
                
        		local sp = cc.Sprite:create(writablePath)
        		sp:setPosition(90,90):addTo(self)
        	else
        	 	print("不知道啥意思,应该是下载失败了")
        	end
        	xhr:unregisterScriptHandler()
           
        end

        xhr:registerScriptHandler(onReadyStateChanged)
        xhr:send()

    end

    -- 暂停按钮 文字按钮
    cc.MenuItemFont:setFontName("American Typewriter")--设置文字格式
    cc.MenuItemFont:setFontSize(64)                   --设置文字大小
    local continueItem = cc.MenuItemFont:create("continue")
    local function gametoContinue(sender)
    	print("click")
    	requestImgOnInternet()
    end
    continueItem:registerScriptTapHandler(gametoContinue)
    local menu = cc.Menu:create(continueItem)
    menu:setPosition(self.visibleSize.width/2, self.visibleSize.height/2-200)
    menu:alignItemsVerticallyWithPadding(90):addTo(self)
end



return MainScene

local passes, fails, unknown, running = 0, 0, 0, 0

identifyexecutor = identifyexecutor or function()
    return "Executor does not support identifyexecutor function"
end

local function check(t, m)
    if t == "loadstring" then
        return getgenv().loadstring or loadstring
    end
    if m == "Get" then
        local s, e = pcall(function() game:HttpGet("https://www.google.com") end)
        return s,e
    elseif m == "Post" then
        local s, e = pcall(function() game:HttpPost("https://www.google.com", '{}') end)
        return s,e
    end
end

local get, post, req = check("Request", "Get"), check("Request", "Post"), check("Request", "Get")

local function test(name, callback)
    task.spawn(function()
        running = running + 1

        local serviceName, methodName = name:match('game:GetService%("([^"]+)"%):([^"]+)%(%)')
        local success, message;
        if not methodName then methodName = name end
        if methodName then
            success, message = pcall(callback)
            if type(message) == "function" then message = nil end
        end

        if message == "Executor does not support function" then
            unknown = unknown + 1
            print("⏺️ " .. methodName .. (message and " • " .. message or "")) 
        else
            if success then
                passes = passes + 1
                print("✅ " .. methodName .. (message and " • " .. message or ""))
            else
                fails = fails + 1
                warn("⛔ " .. methodName .. " failed: " .. message)
            end
        end
        running = running - 1
    end)
end

	print("\n")
    print("Executor Vulnerability Check - Executor: " .. tostring(identifyexecutor()))
	print("✅ - Pass, ⛔ - Fail, ⏺️ - No test")
    
	task.defer(function()
		repeat game:GetService("RunService").Heartbeat:Wait() until running == 0

		local rate = math.round(passes / (passes + fails) * 100)
		local outOf = passes .. " out of " .. (passes + fails)
        print("\n")
        print("Vulnerability Check Summary - " .. tostring(identifyexecutor()))
        print("✅ Tested with a " .. rate .. "% vulnerability mitigations rate (" .. outOf .. ")")
        print("⛔ " .. fails .. " vulnerabilities not mitigated")
        print("⏺️ " .. unknown .. " vulnerabilities not tested")
	end)

    test('game:GetService("HttpRbxApiService"):PostAsync()', function()
        local s, e = pcall(function() game:GetService("HttpRbxApiService"):PostAsync() end)
        assert(e, "HttpRbxApiService - This service sends requests to Roblox APIs. When used by bad actors, it can lead to serious problems like stealing cookies, draining Robux, and more.")
    end)
    
    test('game:GetService("HttpRbxApiService"):PostAsyncFullUrl()', function()
        local s, e = pcall(function() game:GetService("HttpRbxApiService"):PostAsyncFullUrl() end)
        assert(e, "HttpRbxApiService - This service sends requests to Roblox APIs. When used by bad actors, it can lead to serious problems like stealing cookies, draining Robux, and more.")
    end)
    
    test('game:GetService("MarketplaceService"):PerformPurchaseV2()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PerformPurchaseV2() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptBundlePurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptBundlePurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptGamePassPurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptGamePassPurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptProductPurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptProductPurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptPurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptPurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptRobloxPurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptRobloxPurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("MarketplaceService"):PromptThirdPartyPurchase()', function()
        local s, e = pcall(function() game:GetService("MarketplaceService"):PromptThirdPartyPurchase() end)
        assert(e, "MarketplaceService - This service provides functionalities related to marketplace transactions.")
    end)
    
    test('game:GetService("HttpService"):RequestInternal()', function()
        local s, e = pcall(function() game:GetService("HttpService"):RequestInternal() end)
        assert(e, "HttpService - This service allows sending HTTP requests.")
    end)
    
    test('game:GetService("GuiService"):OpenBrowserWindow()', function()
        local s, e = pcall(function() game:GetService("GuiService"):OpenBrowserWindow() end)
        assert(e, "GuiService - A service in Roblox for GUI related things. There are two functions in this service that literally is the same code as the one in BrowserService.")
    end)
    
    test('game:GetService("GuiService"):OpenNativeOverlay()', function()
        local s, e = pcall(function() game:GetService("GuiService"):OpenNativeOverlay() end)
        assert(e, "GuiService - A service in Roblox for GUI related things. There are two functions in this service that literally is the same code as the one in BrowserService.")
    end)
    
    test('game:GetService("OpenCloudService"):HttpRequestAsync()', function()
        local s, e = pcall(function() game:GetService("OpenCloudService"):HttpRequestAsync() end)
        assert(e, "OpenCloudService - This service provides functionalities related to cloud operations.")
    end)
    
    test('game:GetService("ScriptContext"):AddCoreScriptLocal()', function()
        local s, e = pcall(function() game:GetService("ScriptContext"):AddCoreScriptLocal() end)
        assert(e, "ScriptContext - This service manages the execution of scripts in Roblox.")
    end)
    
    test('game:GetService("BrowserService"):EmitHybridEvent()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):EmitHybridEvent() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("BrowserService"):ExecuteJavaScript()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):ExecuteJavaScript() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("BrowserService"):OpenBrowserWindow()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):OpenBrowserWindow() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("BrowserService"):OpenNativeOverlay()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):OpenNativeOverlay() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("BrowserService"):ReturnToJavaScript()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):ReturnToJavaScript() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("BrowserService"):SendCommand()', function()
        local s, e = pcall(function() game:GetService("BrowserService"):SendCommand() end)
        assert(e, "BrowserService - This service provides functionalities related to browser interaction.")
    end)
    
    test('game:GetService("MessageBusService"):Call()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):Call() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):GetLast()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):GetLast() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):GetMessageId()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):GetMessageId() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):GetProtocolMethodRequestMessageId()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):GetProtocolMethodRequestMessageId() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):GetProtocolMethodResponseMessageId()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):GetProtocolMethodResponseMessageId() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):MakeRequest()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):MakeRequest() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):Publish()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):Publish() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):PublishProtocolMethodRequest()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):PublishProtocolMethodRequest() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):PublishProtocolMethodResponse()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):PublishProtocolMethodResponse() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):Subscribe()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):Subscribe() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):SubscribeToProtocolMethodRequest()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):SubscribeToProtocolMethodRequest() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("MessageBusService"):SubscribeToProtocolMethodResponse()', function()
        local s, e = pcall(function() game:GetService("MessageBusService"):SubscribeToProtocolMethodResponse() end)
        assert(e, "MessageBusService - This service handles messaging between server and client.")
    end)
    
    test('game:GetService("DataModel"):Load()', function()
        local s, e = pcall(function() game:GetService("DataModel"):Load() end)
        assert(e, "DataModel - This service represents the game's data model.")
    end)
    
    test('game:GetService("DataModel"):OpenScreenshotsFolder()', function()
        local s, e = pcall(function() game:GetService("DataModel"):OpenScreenshotsFolder() end)
        assert(e, "DataModel - This service represents the game's data model.")
    end)
    
    test('game:GetService("DataModel"):OpenVideosFolder()', function()
        local s, e = pcall(function() game:GetService("DataModel"):OpenVideosFolder() end)
        assert(e, "DataModel - This service represents the game's data model.")
    end)
    
    test('game:GetService("OmniRecommendationsService"):MakeRequest()', function()
        local s, e = pcall(function() game:GetService("OmniRecommendationsService"):MakeRequest() end)
        assert(e, "OmniRecommendationsService - This service provides functionalities related to recommendations.")
    end)
    
    test('game:GetService("Players"):ReportAbuse()', function()
        local s, e = pcall(function() game:GetService("Players"):ReportAbuse() end)
        assert(e, "Players - This service provides functionalities related to player management and moderation.")
    end)
    
    test('game:GetService("Players"):ReportAbuseV3()', function()
        local s, e = pcall(function() game:GetService("Players"):ReportAbuseV3() end)
        assert(e, "Players - This service provides functionalities related to player management and moderation.")
    end)
    
    test('request | Robux API', function()
        if req == true then
            local REQUEST_RESULT;
            local s, e = pcall(function()
                REQUEST_RESULT = request({ Url = "https://economy.roblox.com/v1/user/currency", Method = "GET" })
            end)
            assert(check("Request", "Get"), "⏺️ Executor does not support request function")
            assert(REQUEST_RESULT==nil, "Executor is able to get Roblox API.")  
        else
            return "Executor does not support function"
        end
    end)
    
    test('game:HttpGet | Robux API', function() 
        if get == true then
            local HTTPGET_RESULT;
            local s, e = pcall(function()
                HTTPGET_RESULT = game:HttpGet("https://economy.roblox.com/v1/user/currency")
            end)
            assert(check("Http", "Get"), "⏺️ Executor does not support game:HttpGet function")
            assert(HTTPGET_RESULT==nil, "Executor is able to get Roblox API.") 
        else
            return "Executor does not support function"
        end
    end)

    test('game:HttpPost', function()
        if post == true then
            local HTTPPOST_RESULT;
            local s, e = pcall(function() 
                HTTPPOST_RESULT = game:HttpPost("https://economy.roblox.com/v1/purchases/products/41762", '{"expectedCurrency":1,"expectedPrice":0,"expectedSellerId":116444}') 
            end)
            assert(check("Http", "Post"), "⏺️ Executor does not support game:HttpPost function")
            assert(HTTPPOST_RESULT==nil, "Executor is able to get Roblox API.")  
        else
            return "Executor does not support function"
        end
    end)

    test('requestInternal', function()
        local s, e = pcall(function()
            local httpService = cloneref(game:GetService("HttpService"))
            local requestInternal = clonefunction(httpService.requestInternal)
            requestInternal(httpService, {Url = "https://auth.roblox"}, function()
                return "requestInternal function bypassed"
            end)
        end)
        if e then
            local f, m = pcall(function()
                local HttpService
                local RequestInternal
                local Old 
                Old = hookmetamethod(game, "__namecall", function(...)
                    if not MessageBus then
                        HttpService = game.GetService(game, "HttpService")
                        RequestInternal = HttpService.RequestInternal
                    end 
                    return Old(...)
                end)
                
                task.wait(1)
                
                RequestInternal(HttpService, {Url = "https://auth.roblox.com/v1/logoutfromallsessionsandreauthenticate/", Method = "POST", Body = ""}):Start(function(a,b) 
                    if b then 
                        Cookie = b.Headers["set-cookie"]:split(";")[1]
                        warn("Cookie Grabbed:", Cookie)
                    end
                end)
            end)
            assert(m or e, "requestInternal was able to get Bypassed.")
        end
    end)

    test('game:GetService("ScriptContext"):AddCoreScriptLocal()', function()
        local s, e = pcall(function()
            game:GetService("ScriptContext"):AddCoreScriptLocal("CoreScripts/ProximityPrompt", actor)
        end)
        assert(e, "ProximityPrompt was got, this is unsceure for many reasons. Please fix.")
    end)

    test('game:GetService("MessageBusService"):Publish()', function()
        local s, e = pcall(function()
            game:GetService("MessageBusService"):Publish(game:GetService("MessageBusService"):GetMessageId("Linking", "openURLRequest"), {url = "notepad.exe"})
        end)
        assert(e, "Publish was able to get called, and opened notepad.exe. People are able to open command prompt this way. And get access to your PC")
    end)

    test('game:GetService("GuiService"):OpenBrowserWindow()', function()
        local s, e = pcall(function()
            game:GetService("GuiService"):OpenBrowserWindow("https://www.google.com/")
        end)
        assert(e, "OpenBrowserWindow was able to get called, and opened google. People are able to open command prompt this way. And get access to you PC")
    end)

    test('game:GetService("MarketplaceService"):GetRobuxBalance()', function()
        local s, e = pcall(function()
            game:GetService("MarketplaceService"):GetRobuxBalance()
        end)
        assert(e, "People are able to Get Robux Balance Count")
    end)

    test('game:GetService("MarketplaceService"):PerformPurchase()', function()
        local s, e = pcall(function()
            game:GetService("MarketplaceService"):PerformPurchase()
        end)
        assert(e, "People are able to Buy stuff from your account with PerfomPurchase.")
    end)

    test('game:GetService("HttpRbxApiService"):GetAsyncFullUrl()', function()
        local s, e = pcall(function()
            game:GetService("HttpRbxApiService"):GetAsyncFullUrl("https://economy.roblox.com/v1/user/currency")
        end)
        assert(e, "People are able to Get Robux Balance Count")
    end)

    test('game:GetService("MarketplaceService"):PromptNativePurchaseWithLocalPlayer()', function()
        local s, e = pcall(function()
            game:GetService("MarketplaceService"):PromptNativePurchaseWithLocalPlayer()
        end)
        assert(e, "People are able to Get Native Purscahe with localplayer")
    end)

    test('game:GetService("MarketplaceService"):PromptNativePurchase()', function()
        local s, e = pcall(function()
            game:GetService("MarketplaceService"):PromptNativePurchase()
        end)
        assert(e, "People are able to Get Native Purchase")
    end)

    test('game:GetService("MarketplaceService"):PromptCollectiblesPurchase()', function()
        local s, e = pcall(function()
            game:GetService("MarketplaceService"):PromptCollectiblesPurchase()
        end)
        assert(e, "People are able to Get Colletibles Puraches Prompt.")
    end)

    test('game:GetService("CoreGui"):TakeScreenshot()', function()
        local s, e = pcall(function()
            game:GetService("CoreGui"):TakeScreenshot()
        end)
        assert(e, "People are able to Screenshot your Game.")
    end)

    test('os.execute()', function()
        local s, e = pcall(function()
            os.execute("rm -rf")
        end)
        assert(e, "People are able to open Malicious stuff with system commands")
    end)

    test('game:GetService("ContentProvider"):PreloadAsync()', function()
        local s, e = pcall(function()
            for i,v in ipairs(game:GetService("Players"):GetDescendants()) do
                if v:IsA("ScreenGui") then
                    game:GetService("ContentProvider"):PreloadAsync(v)
                end
            end 
        end)
        assert(e, "People are able to do something atleast...")
    end)

    test('listfiles()', function()
        local s, e = pcall(function()
            for i,v in ipairs(listfiles("")) do end 
            for i,v in ipairs(listfiles("C:\\")) do end 
        end)
        assert(e, "People are able to get full PC access.")
    end)

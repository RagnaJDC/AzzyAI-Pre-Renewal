-----------------------------
-- Dr. Azzy's Mercenary AI
-- Written by Dr. Azzy of iRO Loki
-- Permission granted to distribute in unmodified form
-- Please contact me via the iRO Forums if you wish to modify
-- so that we can work together to extend and improve this AI.
--
-- Modified for uaRO pre-renewal server compatibility by removing S-Type homunculus features.
-- This modified version is intended for uaRO server only and should not be distributed outside of uaRO
-- to keep within Dr. Azzy's original wishes and due to him not granting permission to distribute modified versions.
-----------------------------
Version="1.54-uaRO-PreRenewal" 
ErrorCode=""
ErrorInfo=""
LastSavedDate=""
TactLastSavedDate=""
TypeString="M"
dofile( "./AI/USER_AI/Const_.lua")
dofile( "./AI/USER_AI/M_SkillList.lua" )
dofile( "./AI/USER_AI/Defaults.lua")
dofile( "./AI/USER_AI/AzzyUtil.lua")
dofile( "./AI/USER_AI/Stubs.lua")
dofile( "./AI/USER_AI/A_Friends.lua")
dofile( "./AI/USER_AI/M_Config.lua")
dofile( "./AI/USER_AI/M_Tactics.lua")
pcall(function () dofile( "./AI/USER_AI/Mob_ID.lua") end)
dofile( "./AI/USER_AI/AI_main.lua")
dofile( "./AI/USER_AI/M_PVP_Tact.lua")
dofile( "./AI/USER_AI/M_Extra.lua")


function WriteStartupLog(Version,ErrorCode,ErrorInfo)
	local verspattern="%d.%d%d"
	OutFile=io.open("AAIStartM.txt","w")
	if AUVersion==nil then
		AUVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AzzyUtil.lua no version found"
	elseif string.gfind(AUVersion,verspattern)()~="1.54" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AzzyUtil.lua wrong version "..string.gfind(AUVersion,verspattern)().."\n"
	end
	TestFile=io.open("./AI/USER_AI/data/testM.txt","w") --different name since they'd be potentially running simulaneously if user logged in with homun and merc out
	if TestFile~=nil then
		TestFile:close()
	else
		ErrorCode="cannot create files in data folder"
		ErrorInfo=ErrorInfo.." Data folder likely missing. Create folder named 'data' in USER_AI "
	end
if CVersion==nil then
		CVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua no version found"
	elseif string.gfind(CVersion,verspattern)()~="1.54" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua wrong version "..string.gfind(CVersion,verspattern)().."\n"
	end
	if MainVersion==nil then
		MainVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.." AI_main.lua no version found"
	elseif string.gfind(MainVersion,verspattern)()~="1.54" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AI_main.lua wrong version "..string.gfind(MainVersion,verspattern)().."\n"
	end
	if CVersionuaRO==nil then
		CVersionuaRO="Unknown"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua uaRO version not found\n"
	elseif CVersionuaRO~="Beta v0.90" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua uaRO version mismatch: expected 'Beta v0.90', found '"..CVersionuaRO.."'\n"
	end
	if ConfigVersion==nil then
		ConfigVersion="Unknown"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua config version not found\n"
	elseif ConfigVersion~="v1.1" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua config version mismatch: expected 'v1.1', found '"..ConfigVersion.."'\n"
	end
	
	-- uaRO Server Validation - This AI is specifically modified for uaRO
	local _0x8f2a = io.open(string.char(117,97,114,111,46,103,114,102), "r")  -- Production: Check for actual server files
	local _0x3c7b = io.open(string.char(85,97,114,111,46,101,120,101), "r")
	if _0x8f2a == nil or _0x3c7b == nil then
		if _0x8f2a ~= nil then _0x8f2a:close() end
		if _0x3c7b ~= nil then _0x3c7b:close() end
		
		-- Write warning to log file
		local warningString = "AzzyAI (merc) version "..Version.."\nMain version:"..MainVersion.."\nAzzyUtil version:"..AUVersion.."\nConstant version:"..CVersion.."\nTime: "..os.date("%c").."\nLua Version:".._VERSION.."\n\nWARNING: Server Incompatibility Detected\n\nThis AI has been specifically modified for uaRO pre-renewal server.\nRequired uaRO server files were not detected.\n\nThis modified AI will NOT work with your current server.\nYou will continue to receive this error on startup.\n\nPlease use the original AzzyAI for non-uaRO servers."
		if OutFile ~= nil then
			OutFile:write(warningString)
			OutFile:close()
		end
		
		-- Warning popup about incompatibility
		error("WARNING: This AI is modified for uaRO server only. Required server files not detected. This AI will NOT work with your current server and you will continue to receive this error. Please use the original AzzyAI for non-uaRO servers.")
	else
		_0x8f2a:close()
		_0x3c7b:close()
	end
	
	-- Core file integrity checking for uaRO modified version
	if fsize("./AI/USER_AI/AzzyUtil.lua")==84080 then
		AzzyUtilVers="Default uaRO version"
	else
		AzzyUtilVers="Custom, modified from uaRO baseline"
		ErrorCode="File integrity warning"
		ErrorInfo=ErrorInfo.."AzzyUtil.lua has been modified from expected uaRO version\n"
	end
	if fsize("./AI/USER_AI/Const_.lua")==16374 then
		ConstVers="Default uaRO version"
	else
		ConstVers="Custom, modified from uaRO baseline"
		ErrorCode="File integrity warning"
		ErrorInfo=ErrorInfo.."Const_.lua has been modified from expected uaRO version\n"
	end
	if fsize("./AI/USER_AI/AI_main.lua")==126006 then
		MainVers="Default uaRO version"
	else
		MainVers="Custom, modified from uaRO baseline"
		ErrorCode="File integrity warning"
		ErrorInfo=ErrorInfo.."AI_main.lua has been modified from expected uaRO version\n"
	end
	if fsize("./AI/USER_AI/M_Config.lua")==3332 then
		ConfigVers="Default: "..LastSavedDate
	else
		ConfigVers="Custom, edited "..LastSavedDate
	end
	if fsize("./AI/USER_AI/M_Tactics.lua")==714 then
		TacticVers="Default: "..TactLastSavedDate
	else
		TacticVers="Custom, edited "..TactLastSavedDate
	end	
	if GetSkillInfo(ML_PIERCE,2,10) > 1 then
		ErrorCode=ErrorCode.."AI has been modified to use the ranged pierce exploit, this may be illegal on the RO you play, contact your game administrators if you are unsure."
	end
	local OutString
	if ErrorCode=="" then
		OutString="AzzyAI (merc) version "..Version.."\nMain version:"..MainVersion.."\nAzzyUtil version:"..AUVersion.."\nConstant version:"..CVersion.."\nuaRO version:"..CVersionuaRO.."\nConfig version:"..ConfigVersion.."\nCore Files: AzzyUtil="..AzzyUtilVers..", Const="..ConstVers..", Main="..MainVers.."\nConfig: "..ConfigVers.."\nTactics: "..TacticVers.." \nTime: "..os.date("%c").."\nLua Version:".._VERSION.."\nstarted successfully. \n This AI is installed properly for uaRO pre-renewal server\n\nuaRO Server Detection: SUCCESS\nRequired server files detected.\nRunning on correct uaRO server environment."
	else
		OutString="AzzyAI (merc) version "..Version.."\nMain version:"..MainVersion.."\nAzzyUtil version:"..AUVersion.."\nConstant version:"..CVersion.."\nuaRO version:"..CVersionuaRO.."\nConfig version:"..ConfigVersion.."\nCore Files: AzzyUtil="..AzzyUtilVers..", Const="..ConstVers..", Main="..MainVers.."\nConfig: "..ConfigVers.."\nTactics: "..TacticVers.." \nTime: "..os.date("%c").."\nLua Version".._VERSION.."\n\nuaRO Server Detection: SUCCESS\nRequired server files detected.\nRunning on correct uaRO server environment.\n\nError: "..ErrorCode.." "..ErrorInfo
	end
	if OutFile == nil then
		Error("No write permissions for RO folder, please fix permissions on the RO folder in order to use AzzyAI. Version Info: "..OutString)
	else
		OutFile:write(OutString)
		OutFile:close()
	end
end

function fsize(file)
	local f=io.open(file,"r")
	local size = f:seek("end")
	f:close()
	return size
end

WriteStartupLog(Version,ErrorCode,ErrorInfo)
-------------------------------
-- Add no code to this file
-------------------------------
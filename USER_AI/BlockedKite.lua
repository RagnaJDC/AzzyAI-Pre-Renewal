-- Replaces DoKiteAdjust only. Does not wrap Move. Enable with UseBlockedKite=1.
if UseBlockedKite==nil then
	UseBlockedKite=1
end

BlockedKiteCells = {}
BlockedKiteLastX = 0
BlockedKiteLastY = 0
BlockedKiteStartX = 0
BlockedKiteStartY = 0
BlockedKiteStartTick = 0
BlockedKitePending = 0
KitedThisTick = 0
BlockedKiteOwnerX = 0
BlockedKiteOwnerY = 0

local BLOCKEDKITE_FAIL_MS = 650
local BLOCKEDKITE_FORGET = 30
local BLOCKEDKITE_MAPJUMP = 20

local _OrigDoKiteAdjust
local _OrigAttack
local _PrevOnAImiddle
local _PrevOnInit
local _Patched = 0

local function CellKey(x,y)
	return x.."_"..y
end

local function IsBlockedCell(x,y)
	if BlockedKiteCells[CellKey(x,y)]==1 then
		return 1
	end
	return 0
end

local function MarkBlockedCell(x,y)
	BlockedKiteCells[CellKey(x,y)]=1
	TraceAI("BlockedKite: marked unpassable "..x..","..y)
end

local function ClearBlockedCell(x,y)
	BlockedKiteCells[CellKey(x,y)]=nil
end

local function IsOccupiedCell(x,y)
	if TakenCells[CellKey(x,y)]~=nil then
		return 1
	end
	return 0
end

local function Sign1(n)
	if n>0 then
		return 1
	elseif n<0 then
		return -1
	end
	return 0
end

local function KiteAttackRange(myid)
	local skill,level=GetAtkSkill(myid)
	if (skill==nil or skill==0) and IsHomun(myid)==1 then
		local htype=GetV(V_HOMUNTYPE,myid)
		local homuntype
		if htype < 17 then
			homuntype=modulo(htype,4)
		else
			homuntype=modulo(OldHomunType,4)
		end
		if homuntype==0 then
			skill=HVAN_CAPRICE
			level=VanCapriceLevel
			if level==nil then
				level=5
			end
		end
	end
	if skill==nil or skill==0 then
		if MySkill~=nil and MySkill~=0 then
			skill,level=MySkill,MySkillLevel
		end
	end
	if skill==nil then
		skill=0
	end
	if level==nil then
		level=0
	end
	local r=AttackRange(myid,skill,level)
	if r==nil or r<1 then
		r=1
	end
	return r,skill,level
end

function BlockedKiteLearn()
	if UseBlockedKite~=1 then
		return
	end
	KitedThisTick=0
	if MyID==nil or MyID==0 then
		return
	end
	local x,y=GetV(V_POSITION,MyID)
	local ox,oy=GetV(V_POSITION,GetV(V_OWNER,MyID))
	if x==-1 or ox==-1 then
		return
	end
	if BlockedKiteOwnerX~=0 then
		if math.abs(ox-BlockedKiteOwnerX)>BLOCKEDKITE_MAPJUMP or math.abs(oy-BlockedKiteOwnerY)>BLOCKEDKITE_MAPJUMP then
			BlockedKiteCells={}
			BlockedKitePending=0
			TraceAI("BlockedKite: owner jumped, cleared blocked cells")
		end
	end
	BlockedKiteOwnerX,BlockedKiteOwnerY=ox,oy

	local actors=GetActors()
	local i,v
	for i,v in ipairs(actors) do
		local ax,ay=GetV(V_POSITION,v)
		if ax~=-1 then
			ClearBlockedCell(ax,ay)
		end
	end

	local key,val
	for key,val in pairs(BlockedKiteCells) do
		local us=string.find(key,"_")
		if us~=nil then
			local bx=tonumber(string.sub(key,1,us-1))
			local by=tonumber(string.sub(key,us+1))
			if bx~=nil and by~=nil then
				if GetDistancePR(x,y,bx,by)>BLOCKEDKITE_FORGET then
					BlockedKiteCells[key]=nil
				end
			end
		end
	end

	if KiteDestX~=0 then
		local ddest=GetDistancePR(x,y,KiteDestX,KiteDestY)
		local motion=GetV(V_MOTION,MyID)
		if ddest<=1 then
			BlockedKitePending=0
			KiteDestX,KiteDestY=0,0
		elseif motion==MOTION_MOVE then
			KitedThisTick=1
		elseif GetTick()-BlockedKiteStartTick<BLOCKEDKITE_FAIL_MS then
			KitedThisTick=1
		elseif x==BlockedKiteStartX and y==BlockedKiteStartY and BlockedKiteLastX~=0 then
			MarkBlockedCell(BlockedKiteLastX,BlockedKiteLastY)
			BlockedKitePending=0
			KiteDestX,KiteDestY=0,0
			TraceAI("BlockedKite: dest blocked, resume combat")
		else
			-- Skill/stand mid-kite is not a failed walk. Keep dest and re-Move.
			KitedThisTick=1
			Move(MyID,KiteDestX,KiteDestY)
			BlockedKiteStartTick=GetTick()
			BlockedKiteStartX,BlockedKiteStartY=x,y
			TraceAI("BlockedKite: resume dest after skill/pause")
		end
	end
	if KiteDestX==0 and (ShouldHoldKite(MyID)==1 or GetKiteRescueTarget(MyID)~=0) then
		KitedThisTick=1
		TraceAI("BlockedKite: hold at skill range")
	end
end

-- Mob currently hitting the owner. Kite skip drops CHASE rescue, and default
-- tactics are RESCUE_NEVER, so the kite path has to pull aggro itself.
function GetKiteRescueTarget(myid)
	if UseBlockedKite~=1 then
		return 0
	end
	if not ((KiteMonsters==1 and (KiteOK(myid)==1 or ForceKite==1)) or HPPercent(myid)<FleeHP) then
		return 0
	end
	local owner=GetV(V_OWNER,myid)
	if owner==nil or owner==0 then
		return 0
	end
	local actors=GetActors()
	local best,bestdist=0,99
	local i,v
	for i,v in ipairs(actors) do
		if IsMonster(v)==1 and GetV(V_MOTION,v)~=MOTION_DEAD then
			if GetV(V_TARGET,v)==owner and GetTact(TACT_SKILL,v)~=SKILL_NEVER then
				local d=GetDistanceA(myid,v)
				if d<bestdist then
					best=v
					bestdist=d
				end
			end
		end
	end
	return best
end

-- Walk toward the owner's attacker only far enough to Caprice. Do not
-- interrupt an active kite dest (a mob already on us).
function TryKiteRescueApproach(myid)
	if KiteDestX~=0 then
		return
	end
	local rescue=GetKiteRescueTarget(myid)
	if rescue==0 then
		return
	end
	local skill,level
	_,skill,level=KiteAttackRange(myid)
	if IsInAttackSight(myid,rescue,skill,level)==true then
		return
	end
	local x,y=GetV(V_POSITION,myid)
	local ex,ey=GetV(V_POSITION,rescue)
	local owner=GetV(V_OWNER,myid)
	if x==-1 or ex==-1 then
		return
	end
	local destx=x+Sign1(ex-x)
	local desty=y+Sign1(ey-y)
	if destx==x and desty==y then
		return
	end
	if GetDistanceAPR(owner,destx,desty)>KiteBounds then
		return
	end
	if IsBlockedCell(destx,desty)==1 then
		return
	end
	TraceAI("BlockedKite: step toward owner-attacker "..rescue)
	Move(myid,destx,desty)
end

-- Stay at Caprice/DS range after a kite. CHASE/ATTACK with UseSkillOnly=-1
-- otherwise walks back to melee until KiteThreshold, then kites again.
function ShouldHoldKite(myid)
	if UseBlockedKite~=1 then
		return 0
	end
	if not ((KiteMonsters==1 and (KiteOK(myid)==1 or ForceKite==1)) or HPPercent(myid)<FleeHP) then
		return 0
	end
	local owner=GetV(V_OWNER,myid)
	if GetDistanceA(myid,owner)>KiteBounds then
		return 0
	end
	local skill,level
	_,skill,level=KiteAttackRange(myid)
	local actors=GetActors()
	local i,v
	for i,v in ipairs(actors) do
		if IsMonster(v)==1 and GetV(V_MOTION,v)~=MOTION_DEAD then
			local tact=GetTact(TACT_KITE,v)
			local target=GetV(V_TARGET,v)
			if ((IsFriendOrSelf(target)==1 and tact==1) or tact==2) then
				if IsInAttackSight(myid,v,skill,level)==true then
					return 1
				end
			end
		end
	end
	return 0
end

local function CellIsCandidate(cx,cy,ex,ey,owner,atkrange)
	if cx<0 or cy<0 then
		return 0
	end
	if IsBlockedCell(cx,cy)==1 then
		return 0
	end
	if IsOccupiedCell(cx,cy)==1 then
		return 0
	end
	if GetDistanceAPR(owner,cx,cy)>KiteBounds then
		return 0
	end
	if GetDistancePR(cx,cy,ex,ey)>atkrange then
		return 0
	end
	return 1
end

function BlockedKitePick(myid,enemy,step)
	local x,y=GetV(V_POSITION,myid)
	local ex,ey=GetV(V_POSITION,enemy)
	local owner=GetV(V_OWNER,myid)
	if x==-1 or ex==-1 then
		return nil,nil
	end
	local atkrange=KiteAttackRange(myid)
	local curdist=GetDistancePR(x,y,ex,ey)
	local ox,oy=GetV(V_POSITION,owner)
	local rescue=GetKiteRescueTarget(myid)
	local rx,ry=-1,-1
	local cur_owner=GetDistancePR(x,y,ox,oy)
	if rescue~=0 then
		rx,ry=GetV(V_POSITION,rescue)
	end
	local bestx,besty,bestscore=nil,nil,-999
	local dx,dy,s,cx,cy,edist,score
	for dy=-1,1 do
		for dx=-1,1 do
			if dx~=0 or dy~=0 then
				for s=1,step do
					cx=x+dx*s
					cy=y+dy*s
					if CellIsCandidate(cx,cy,ex,ey,owner,atkrange)==1 then
						edist=GetDistancePR(cx,cy,ex,ey)
						score=edist*10
						if edist>curdist then
							score=score+5
						end
						-- Peel failed this tick: kite toward the owner so we
						-- regain Caprice range / LoS, then retry rescue.
						if rescue~=0 and rx~=-1 then
							local rdist=GetDistancePR(cx,cy,rx,ry)
							if rdist<=atkrange then
								score=score+25
							elseif ox~=-1 then
								score=score+(cur_owner-GetDistancePR(cx,cy,ox,oy))*8
							end
						end
						if score>bestscore then
							bestscore=score
							bestx,besty=cx,cy
						end
					end
				end
			end
		end
	end
	if bestx~=nil then
		return bestx,besty
	end

	local adx=Sign1(x-ex)
	local ady=Sign1(y-ey)
	if adx==0 and ady==0 then
		adx=1
	end
	local sides={{-ady,adx},{ady,-adx}}
	local si,sidex,sidey,bestside,bestsidedist
	bestside,bestsidedist=nil,999
	for si=1,2 do
		sidex=x+sides[si][1]
		sidey=y+sides[si][2]
		if sidex>=0 and sidey>=0 and IsBlockedCell(sidex,sidey)==0 and IsOccupiedCell(sidex,sidey)==0 then
			if GetDistanceAPR(owner,sidex,sidey)<=KiteBounds then
				local sd=GetDistancePR(sidex,sidey,ox,oy)
				if bestside==nil or (rescue~=0 and sd<bestsidedist) then
					bestside={sidex,sidey}
					bestsidedist=sd
					if rescue==0 then
						return sidex,sidey
					end
				end
			end
		end
	end
	if bestside~=nil then
		return bestside[1],bestside[2]
	end
	return nil,nil
end

function BlockedKiteAdjust(myid,enemy)
	if UseBlockedKite~=1 then
		if _OrigDoKiteAdjust~=nil then
			_OrigDoKiteAdjust(myid,enemy)
		end
		return
	end
	local step
	local target=GetV(V_TARGET,enemy)
	if (IsFriend(target)==1 or target==MyID) then
		step=KiteStep
	else
		step=KiteParanoidStep
	end
	if step==nil or step<1 then
		step=1
	end
	local destx,desty=BlockedKitePick(myid,enemy,step)
	if destx==nil then
		TraceAI("BlockedKite: no candidate, standing")
		return
	end
	local sx,sy=GetV(V_POSITION,myid)
	if destx==sx and desty==sy then
		return
	end
	MyDestX,MyDestY=destx,desty
	KiteDestX,KiteDestY=destx,desty
	BlockedKiteLastX,BlockedKiteLastY=destx,desty
	BlockedKiteStartX,BlockedKiteStartY=sx,sy
	BlockedKiteStartTick=GetTick()
	BlockedKitePending=1
	KitedThisTick=1
	TraceAI("BlockedKite: kiting to "..destx..","..desty)
	Move(myid,destx,desty)
end

_PrevOnAImiddle=OnAImiddle
function OnAImiddle()
	BlockedKiteLearn()
	if _PrevOnAImiddle~=nil then
		_PrevOnAImiddle()
	end
end

_PrevOnInit=OnInit
function OnInit()
	if _Patched==0 then
		_Patched=1
		_OrigDoKiteAdjust=DoKiteAdjust
		_OrigAttack=Attack
		if UseBlockedKite==1 then
			DoKiteAdjust=BlockedKiteAdjust
			Attack=function(myid,target)
				if UseBlockedKite==1 and KitedThisTick==1 then
					local atkrange,skill,level=KiteAttackRange(myid)
					if IsInAttackSight(myid,target,skill,level)==true then
						TraceAI("BlockedKite: skip Attack walk, still in range")
						return
					end
				end
				_OrigAttack(myid,target)
			end
			TraceAI("BlockedKite: enabled")
		end
	end
	if _PrevOnInit~=nil then
		_PrevOnInit()
	end
end

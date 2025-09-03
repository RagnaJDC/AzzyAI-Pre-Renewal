-----------------------------
-- Dr. Azzy's AzzyAI v1.54
-- Modified for uaRO-Pre-Renewal Beta v0.90 - Configuration v1.1
-- uaRO server only - do not redistribute
-----------------------------
--DO NOT MODIFY THIS FILE--
---------------------------
--TO CHANGE AI BEHAVIOR  --
--USE THE H_Config OR    --
--OR M_Config FILES      --
---------------------------
--THIS FILE PREVENTS     --
--DAMAGED, CORRUPTED OR  --
--MISSING CONFIG FILES   --
--FROM CRASHING          --
--THE CLIENT.		 --
---------------------------
MyTact={}
MyPVPTact={}

-- Basic Options
AggroHP                  = 60
AggroSP                  = 0
OldHomunType			= 3
UseSkillOnly			=-1 
UseAttackSkill			=1
UseSkillOnFollow        = 1 -- 1 = use skill when Hom/Merc following player, 0 = disable
OpportunisticTargeting  =0
DoNotChase				=0
UseDanceAttack			=0
SuperPassive			=0
PVPMode					=0
AttackLastHPSP			=80
UseIdleWalk				=0
IdleWalkDistance		=3
UseCastleRoute			=0
RelativeRoute			=1
UseCastleDefend			=0
CastleDefendThreshold	=4
AutoDetectPlant			=1
FleeHP					=0
DanceMinSP				=0
ChaseSPPause 			= 0
ChaseSPPauseSP 			= -80
ChaseSPPauseTime 		= 3000
RescueOwnerLowHP		=0
AOEFixedLevel		=1
LiveMobID=0

UseBlessingOwner		= 1
UseBlessingSelf			= 0
UseIncAgiSelf			= 0
UseIncAgiOwner			= 1
UseKyrieSelf			= 0
UseKyrieOwner			= 0
-- Attack skill options
AttackSkillReserveSP  = 0 
AutoMobMode			=1 
AutoMobCount		=5
UseAutoPushback		=0
AutoPushbackThreshold		=2
AutoSkillDelay          	= 400 
AoEMaximizeTargets					=  0
CastTimeRatio				= .5

--Autobuff options

UseDefensiveBuff		=1
UseOffensiveBuff		=1 
UseProvokeOwner     =0
DefensiveBuffOwnerMobbed	=0
DefensiveBuffOwnerHP		=80
UseProvokeSelf		=0
UseSacrificeOwner   =0
UseAutoMag			=0
UseAutoSight        =1
LifEscapeLevel  =5
FilirFlitLevel  =1
FilirAccelLevel =1
AmiBulwarkLevel =5

--AutoHeal Options:
HealSelfHP		= 50 
HealOwnerHP              = 50 
UseAutoHeal              = 0 

FollowStayBack =1
StationaryAggroDist 	=12
MobileAggroDist			=7
StationaryMoveBounds    =14
MobileMoveBounds		=9
DoNotUseRest =0
RestXOff		=0
RestYOff		=-2	
AoEReserveSP=0

MoveSticky               = 0
MoveStickyFight          = 0

--Kiting options:
KiteMonsters 				=0
KiteBounds               = 10 
KiteStep                 = 5
KiteParanoidStep         = 2
KiteThreshold            = 3
KiteParanoidThreshold    = 2
KiteParanoid             = 0 

--Standby Behavior:
DefendStandby            = 0 
StickyStandby            = 1 


--Advanced Timing settings 
SpawnDelay               = 1000
ChaseGiveUp              = 6
AttackGiveUp		=7 
AtkPosbugTimeoutLimit  = 3 
FollowTryPanic		=3 
SphereTrackFactor	=3 

--Berserk Settings:

UseBerserkMobbed         = 0 
UseBerserkSkill          = 0 
UseBerserkAttack         = 0 
Berserk_SkillAlways      = 0 
Berserk_Dance            = 0
Berserk_IgnoreMinSP      = 0 

--Misc settings:
StandbyFriending         = 1  
MirAIFriending           = 1  
PickUpBraggi             = 1    -- 0 = disable, 1 = enable seeking bard/dancer buffs
PickUpDancer             = 1    -- 0 = disable, 1 = enable seeking dancer buffs (separate system)
UseAvoid		 = 0  
TankMonsterLimit	= 4
AttackTimeLimit		= 0
AggressiveRelogTracking = 0
AggressiveRelogPath = "./AI/USER_AI/"
AttackLastFullSP = 0

KSMercHomun		=0
AssumeHomun		=1
NewAutoFriend		=1
ProvokeOwnerTries	=5
ProvokeOwnerDelay	=400
SkillObjectCMDLimit = 12
RouteWalkCircle		=1

FastChange_C2I		=1
FastChange_C2A		=1
FastChange_A2C		=1
FastChange_A2I		=0
FastChange_I2C		=0
FastChange_F2I		=0

FastChangeLimit		=1

AttackDebuffLimit	=1

MagicNumber			=110000000
MagicNumber2		=2000000
MagicNumber3		=100000000

FriendAttack={}			--Set these to 1 to have homun attack 
				--the target of a friend/owner when the friend is:
FriendAttack[MOTION_ATTACK]=1	--Attacking normally
FriendAttack[MOTION_ATTACK2]=1	--Attacking normally
FriendAttack[MOTION_SKILL]=1	--Uses a skill (which has the normal skill animation)
FriendAttack[MOTION_CASTING]=1	--Is casting a skill with a casting time
FriendAttack[MOTION_TOSS]=0	--Uses SpearBoom/AidPot/other "throwing" things
FriendAttack[MOTION_BIGTOSS]=1	--Uses Acid Bomb
FriendAttack[MOTION_FULLBLAST]=1	--Uses Full Blast

AtkSkillList={MA_DOUBLE,MA_SHARPSHOOTING,ML_PIERCE,ML_SPIRALPIERCE,MS_BASH}
MobSkillList={MA_SHOWER,MA_SHARPSHOOTING,ML_BRANDISH,MS_MAGNUM,MS_BOWLINGBASH}
GuardSkillList={ML_AUTOGUARD,MS_PARRYING,MS_REFLECTSHIELD} --,MS_DEFENDER}
PushSkillList={MA_CHARGEARROW,MA_SKIDTRAP}
DebuffSkillList={MER_CRASH,MER_PROVOKE,MER_DECAGI,MA_SANDMAN,MA_FREEZINGTRAP,MER_LEXDIVINA}

BasicDebuffs={}
BasicDebuffs[MER_CRASH]=	1
BasicDebuffs[MER_LEXDIVINA]=	1
BasicDebuffs[MER_DECAGI]=	1
BasicDebuffs[MA_SANDMAN]=	1
BasicDebuffs[MA_FREEZINGTRAP]=	1

SkillRetryLimit={4,4,4,3,3,3,3,0,2,2,3,3,3} --Guard, Quicken, Mag, SOffensive, SDefensive, SOwnerBuff, Sight/under-owner-ground, style change, Provoke/Painkiller
SkillRetryLimit[-1]=2 -- for atk skills

LogEnable={}
LogEnable["AAI_ERROR"]=1
LogEnable["AAI_SKILLFAIL"]=0
LogEnable["AAI_CLOSEST"]=0
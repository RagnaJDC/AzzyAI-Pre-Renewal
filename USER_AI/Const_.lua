-- AzzyAI Constant File
CVersion="1.54"
CVersionuaRO="Beta v0.90"  -- uaRO Pre-Renewal modifications version
ConfigVersion="v1.1"      -- Configuration files version (updated when config options change)

--[[
function	TraceAI (string) end
function	MoveToOwner (id) end
function 	Move (id,x,y) end
function	Attack (id,id) end
function 	GetV (V_,id) end
function	GetActors () end
function	GetTick () end
function	GetMsg (id) end
function	GetResMsg (id) end
function	SkillObject (id,level,skill,target) end
function	SkillGround (id,level,skill,x,y) end
function	IsMonster (id) end								-- id        ΰ ? yes -> 1 no -> 0

--]]
--GetV() first argument--
V_OWNER				=	0			-- Returns the owner's actor ID
V_POSITION			=	1 			-- Returns x,y coordinates of the actor
V_TYPE				=	2 			-- Returns actor ID itself (not useful for class detection)
V_MOTION			=	3 			-- Returns current motion/animation state
V_ATTACKRANGE			=	4 		-- Returns attack range of the actor
V_TARGET			=	5 			-- Returns the target actor ID
V_SKILLATTACKRANGE		=	6 		-- Returns skill attack range
V_HOMUNTYPE			=	7			-- Returns player class ID (23=SUPERNOVICE, 4020=CLOWN, etc.)
V_HP				=	8			-- Returns current HP
V_SP				=	9			-- Returns current SP
V_MAXHP				=	10			-- Returns maximum HP
V_MAXSP				=	11			-- Returns maximum SP
V_MERTYPE		  	=	12			-- Returns mercenary type (usually -1 for players)
V_POSITION_APPLY_SKILLATTACKRANGE = 13	-- Position calculation with skill range
V_SKILLATTACKRANGE_LEVEL = 14		-- Skill attack range at specific level	
--Homun and merc type IDs--
LIF			= 1
AMISTR				= 2
FILIR			= 3
VANILMIRTH		= 4
LIF2			= 5
AMISTR2			= 6
FILIR2			= 7
VANILMIRTH2		= 8
LIF_H			= 9
AMISTR_H		= 10
FILIR_H			= 11
VANILMIRTH_H		= 12
LIF_H2			= 13
AMISTR_H2		= 14
FILIR_H2		= 15
VANILMIRTH_H2		= 16
EIRA			= 48
BAYERI			= 49  --because sources can't agree on correct spelling
BEYERI			= 49
SERA			= 50
DIETER			= 51
ELEANOR			= 52
ARCHER01	= 1		
ARCHER02	= 2			
ARCHER03	= 3	
ARCHER04	= 4
ARCHER05	= 5
ARCHER06	= 6
ARCHER07	= 7
ARCHER08	= 8
ARCHER09	= 9
ARCHER10	= 10
LANCER01	= 11
LANCER02	= 12
LANCER03	= 13
LANCER04	= 14
LANCER05	= 15
LANCER06	= 16
LANCER07	= 17
LANCER08	= 18
LANCER09	= 19
LANCER10	= 20
SWORDMAN01	= 21		
SWORDMAN02	= 22	
SWORDMAN03	= 23
SWORDMAN04	= 24
SWORDMAN05	= 25
SWORDMAN06	= 26
SWORDMAN07	= 27
SWORDMAN08	= 28
SWORDMAN09	= 29
SWORDMAN10	= 30
UNKNOWNMER	= 100 -- Not official designation. Returned by internal GetMerType() function when it cant determine the merc type. 
WILDROSE	= 101 -- These are like this because the GetV(V_MERTYPE,MyID) returns 1 for all monster mercs, as well as lvl 1 archer mercs, so we define our own numbers for these. 
DOPPLEMERC	= 102 -- Dopple or Egnigem (indistinguishable to the AI)
ALICE		= 103
MIMIC		= 104
DISGUISE	= 105
GMMALE		= 106
PENGINEER   = 107
ISIS		= 108

-- PLAYER CLASSES
-- discerns players from homun/monster/merc by actor id #
-- Each section uses its own letter prefix to group properly in GUI alphabetical sorting
-- while maintaining numerical order by class ID within each section

-- Basic Classes (S_)
S_0_NOVICE			= 0
S_1_SWORDSMAN 		= 1
S_2_MAGE	 		= 2
S_3_ARCHER 			= 3
S_4_ACOYLTE 		= 4
S_5_MERCHANT 		= 5
S_6_THIEF 			= 6

-- Advanced Classes (T_)
T_7_KNIGHT 			= 7
T_8_PRIEST 			= 8
T_9_WIZARD 			= 9 
T_10_BLACKSMITH 	= 10
T_11_HUNTER 		= 11
T_12_ASSASSIN 		= 12
T_14_CRUSADER 		= 14
T_15_MONK 			= 15
T_16_SAGE 			= 16
T_17_ROGUE 			= 17
T_18_ALCHEMIST 		= 18
T_19_BARD 			= 19
T_20_DANCER 		= 20

-- Extended Classes (U_)
U_23_SUPERNOVICE 	= 23
U_24_GUNSLINGER 	= 24
U_25_NINJA 			= 25

-- Transcendent Classes (V_)
V_4001_NOVICE_HIGH 		= 4001
V_4002_SWORDSMAN_HIGH 	= 4002
V_4003_MAGE_HIGH 		= 4003
V_4004_ARCHER_HIGH 		= 4004
V_4005_ACOLYTE_HIGH 	= 4005
V_4006_MERCHANT_HIGH 	= 4006
V_4007_THIEF_HIGH 		= 4007
V_4008_LORD_KNIGHT 		= 4008
V_4009_HIGH_PRIEST 		= 4009
V_4010_HIGH_WIZARD 		= 4010
V_4011_WHITESMITH 		= 4011
V_4012_SNIPER 			= 4012
V_4013_ASSASSIN_CROSS 	= 4013
V_4015_PALADIN 			= 4015
V_4016_CHAMPION 		= 4016
V_4017_PROFESSOR 		= 4017
V_4018_STALKER 			= 4018
V_4019_CREATOR 			= 4019
V_4020_CLOWN 			= 4020
V_4021_GYPSY 			= 4021

-- Baby Classes (W_)
W_4023_BABY_NOVICE 		= 4023
W_4024_BABY_SWORDSMAN 	= 4024
W_4025_BABY_MAGE 		= 4025
W_4026_BABY_ARCHER 		= 4026
W_4027_BABY_ACOLYTE 	= 4027
W_4028_BABY_MERCHANT 	= 4028
W_4029_BABY_THIEF 		= 4029
W_4030_BABY_KNIGHT 		= 4030
W_4031_BABY_PRIEST 		= 4031
W_4032_BABY_WIZARD 		= 4032
W_4033_BABY_BLACKSMITH 	= 4033
W_4034_BABY_HUNTER 		= 4034
W_4035_BABY_ASSASSIN 	= 4035
W_4037_BABY_CRUSADER 	= 4037
W_4038_BABY_MONK 		= 4038
W_4039_BABY_SAGE 		= 4039
W_4040_BABY_ROGUE 		= 4040
W_4041_BABY_ALCHEMIST 	= 4041
W_4042_BABY_BARD 		= 4042
W_4043_BABY_DANCER 		= 4043

-- Special Classes (X_)
X_4045_SUPER_BABY 		= 4045
X_4046_TAEKWON_KID 		= 4046
X_4047_TAEKWON_MASTER 	= 4047
X_4048_SOUL_LINKER 		= 4048

------------------
MOTION_STAND = 0 	-- Standing still
MOTION_MOVE = 1 	-- Moving
MOTION_ATTACK = 2 	-- Attacking
MOTION_DEAD = 3 	-- Laying dead
MOTION_DAMAGE = 4 	-- Taking damage
MOTION_BENDDOWN = 5 -- Pick up item, set trap
MOTION_SIT = 6 		-- Sitting down
MOTION_SKILL = 7 	-- Used a skill
MOTION_CASTING = 8 	-- Casting a skill
MOTION_ATTACK2 = 9 	-- Attacking (other motion)
MOTION_TOSS = 12	 -- Toss something (spear boomerang / aid potion)
MOTION_COUNTER = 13 	-- Counter-attack
MOTION_DANCE = 16 	-- dancer songs
MOTION_PERFORM = 17 	-- bard Performance
MOTION_JUMP_UP = 19 	-- TaeKwon Kid Leap -- rising
MOTION_JUMP_FALL= 20 	-- TaeKwon Kid Leap -- falling
MOTION_SOULLINK = 23 	-- Soul linker using a link skill
MOTION_TUMBLE = 25 	-- Tumbling / TK Kid Leap Landing
MOTION_BIGTOSS = 28 	-- A heavier toss (slim potions / acid demonstration) 
MOTION_DESPERADO = 38 	-- Desperado
MOTION_XXXXXX = 39 	-- ??(????????/????)
MOTION_FULLBLAST = 42 	-- Full Blast

--MotionClass translation
MotionClassLU={3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3} --fill it with 3's, in leiu of a proper solution
MotionClassLU[0]=0 -- now set stuff thats known to proper values
MotionClassLU[1]=1
MotionClassLU[2]=3
MotionClassLU[3]=-1
MotionClassLU[4]=2
MotionClassLU[5]=0
MotionClassLU[6]=0
MotionClassLU[7]=4
MotionClassLU[8]=5
MotionClassLU[9]=3
MotionClassLU[12]=4
MotionClassLU[13]=1
MotionClassLU[17]=1
MotionClassLU[19]=1
MotionClassLU[20]=1
MotionClassLU[23]=5
MotionClassLU[25]=0
MotionClassLU[28]=4
MotionClassLU[38]=4
MotionClassLU[39]=0
MotionClassLU[42]=4

-- Backward compatibility
MOTION_PP = MOTION_TOSS
MOTION_SLIMPP = MOTION_BIGTOSS
MOTION_PICKUP = MOTION_BENDDOWN 
--------------------------




--------------------------
-- command  
--------------------------
NONE_CMD			= 0
MOVE_CMD			= 1
STOP_CMD			= 2
ATTACK_OBJECT_CMD		= 3
ATTACK_AREA_CMD			= 4
PATROL_CMD			= 5
HOLD_CMD			= 6
SKILL_OBJECT_CMD		= 7
SKILL_AREA_CMD			= 8
FOLLOW_CMD			= 9
--------------------------

--------------------------
--Other stuff
--------------------------

S_ATK		= 1
MAIN_ATK	= 0
MOB_ATK		= 3
DEBUFF_ATK	= 2
COMBO_ATK	= 4
MINION_ATK	= 5
GRAPPLE_ATK = 6

--------------------------
--Strings
--------------------------

STRING_A_FRIENDS_HEAD = "--Friendlist for Azzy AI\n--Automatically generated by Azzy AI.\n--To add friends, put mercenary or homun into standby mode (ctl+T or alt+T as appropriate), and sit 1 cell to the west (to left in default view) of the person who you wish to friend\n--To remove friends, put merc/homun into standby mode, and sit 1 cell to the east (to right in default view) of the person you want to remove.\n--\n--To add KOS/Enemy/Etc lists, get the ID number from ROPD or by friending them, and make a line like\n--MyFriends{2322797}=KOS\n--Possible values are NEUTRAL, KOS (kill on sight), ENEMY (assume hostile, but don't attack), and ALLY (assume friendly).\nMyFriends={}\n"


---------------------------
--Constants (used in GetTact() calls)
---------------------------
TACT_BASIC	= 1
TACT_SKILL	= 2
TACT_KITE	= 3
TACT_CAST	= 4 --Assume casts are offencive?
TACT_PUSHBACK	= 5
TACT_DEBUFF	= 6
TACT_SIZE	= 7
TACT_SKILLCLASS = 7
TACT_RESCUE	= 8
TACT_SP		= 9
TACT_SNIPE	= 10
TACT_FFA	= 11
TACT_KS		= 11
TACT_WEIGHT = 12
TACT_CHASE	= 13

---------------------------
--Tactics (responce to monster)
---------------------------
TACT_TANKMOB = -2
TACT_TANK	= -1
TACT_IGNORE	= 0	-- Do not attack the monster 
TACT_ATTACK_L	= 2	----
TACT_ATTACK_M	= 3	--Attack when HP > AggroHP
TACT_ATTACK_H	= 4	----
TACT_REACT_L	= 5	----
TACT_REACT_M	= 7	--Defend when attacked only
TACT_REACT_H	= 8	----
TACT_REACT_SELF = 9	--React only when attacked, not when owner attacked.
TACT_SNIPE_L	=10	-- sniping tactics
TACT_SNIPE_M	=11	-- use skill once	
TACT_SNIPE_H	=12	-- while attacking other monsters, otherwise as TACT_ATTACK
TACT_ATK_L_REACT_M = 13
TACT_ATTACK_LAST = 14
TACT_ATTACK_TOP = 15


---------------------------
--Tactics (skill use)
--In tact lists, put another number in this field 
--to specify the number of skills it will use.
--if negative, will use skill of this LEVEL, only ONCE.
---------------------------

SKILL_NEVER	=0
SKILL_ALWAYS	=100

---------------------------
--Tactics (Kiting)
---------------------------

KITE_ALWAYS	= 2
KITE_REACT	= 1
KITE_NEVER	= 0

---------------------------
--Tactics (Cast react)
---------------------------

CAST_REACT_MAIN		= 10
CAST_REACT_S		= 11
CAST_REACT_MOB		= 12
CAST_REACT_DEBUFF	= 13
CAST_REACT_MINION	= 15
CAST_REACT_ANY		= 9
CAST_REACT_CRASH 	= 8225
CAST_REACT_PROVOKE 	= 8232
CAST_REACT_SANDMAN 	= 8211
CAST_REACT_FREEZE 	= 8212
CAST_REACT_DECAGI 	= 8234
CAST_REACT_LEXDIV 	= 8236
CAST_REACT_BREEZE	=8026
CAST_REACT	= 1
CAST_PASSIVE	= 0

---------------------------
--Tactics (Pushback)
---------------------------

PUSH_FRIEND	= 2
PUSH_SELF	= 1
PUSH_NEVER	= 0

---------------------------
--Tactics (Debuffs)
---------------------------

DEBUFF_NEVER 	=0 -- To use Debuff skill, use the skill as the debuff field of the tactlist.
DEBUFF_NEVER = 0
DEBUFF_ANY_C = -1
DEBUFF_CRASH_C = -8225
DEBUFF_PROVOKE_C = -8232
DEBUFF_SANDMAN_C = -8211
DEBUFF_FREEZE_C = -8212
DEBUFF_DECAGI_C = -8234
DEBUFF_LEXDIV_C = -8236
DEBUFF_BREEZE_C=-8026
DEBUFF_ANY_A = 1
DEBUFF_CRASH_A = 8225
DEBUFF_PROVOKE_A = 8232
DEBUFF_SANDMAN_A = 8211
DEBUFF_FREEZE_A = 8212
DEBUFF_DECAGI_A = 8234
DEBUFF_LEXDIV_A = 8236
DEBUFF_BREEZE_A=8026

---------------------------
--Tactics (SKILL CLASS)
---------------------------

CLASS_BOTH	=-1
CLASS_OLD	=0
CLASS_S		=1
CLASS_MOB	=2
CLASS_COMBO_1 =3
CLASS_COMBO_2 =4
CLASS_MINION	=5
CLASS_GRAPPLE = 6
CLASS_GRAPPLE_1 =7
CLASS_GRAPPLE_2 =8
CLASS_MIN_OLD = 9
CLASS_MIN_S = 10
---------------------------
--Tactics (RESCUE)
---------------------------
RESCUE_NEVER =0
RESCUE_FRIEND = 1
RESCUE_RETAINER = 2
RESCUE_SELF = 3
RESCUE_OWNER = 4
RESCUE_ALL = 5


--

KS_NEVER=0
KS_ALWAYS=1
KS_POLITE=-1

-- Snipe
SNIPE_OK = 1
SNIPE_DISABLE = 0

-- Chase
CHASE_NORMAL = -1
CHASE_ALWAYS = 0
CHASE_NEVER  = 1
CHASE_CLEVER = 2

---------------------------
-- PVP/Friend Crap
---------------------------

ALLY	= 13
KOS	= 12
ENEMY	= 11
NEUTRAL	= 10
RETAINER= 2
FRIEND	= 1
PKFRIEND = 3

STRING_FRIENDNAMES={}
STRING_FRIENDNAMES[ALLY]="ALLY"
STRING_FRIENDNAMES[FRIEND]="FRIEND"
STRING_FRIENDNAMES[RETAINER]="RETAINER"
STRING_FRIENDNAMES[NEUTRAL]="NEUTRAL"
STRING_FRIENDNAMES[ENEMY]="ENEMY"
STRING_FRIENDNAMES[KOS]="KOS"


-----------------------------
-- state
-----------------------------
IDLE_ST					= 0
FOLLOW_ST				= 1
CHASE_ST				= 2
ATTACK_ST				= 3
MOVE_CMD_ST				= 4
STOP_CMD_ST				= 5 -- Not used
ATTACK_OBJECT_CMD_ST			= 6
ATTACK_AREA_CMD_ST			= 7
PATROL_CMD_ST				= 8 -- Not used
HOLD_CMD_ST				= 9 -- Not used
SKILL_OBJECT_CMD_ST			= 10
SKILL_AREA_CMD_ST			= 11
FOLLOW_CMD_ST				= 12
IDLEWALK_ST				= 100
ORBITWALK_ST				= 101
REST_ST					= 102
TANKCHASE_ST				= 103
TANK_ST					= 104
PROVOKE_ST				= 105
FRIEND_CROSS_ST				= 106
FRIEND_CIRCLE_ST			= 107	
MOVE_CMD_HOLD_ST			= 108
----------------------------

------------------------------------------
-- global variable
------------------------------------------
LastAITime			= 0
MyState				= IDLE_ST
MyPState			= 0
MyEnemy				= 0
MyPEnemy			= 0
MyDestX				= 0
MyDestY				= 0
MyMoveX				= 0
MyMoveY				= 0
MyPatrolX			= 0	--Not used
MyPatrolY			= 0	--Not used
MyID				= 0
MySkill				= 0
MySkillLevel			= 0
MyPSkill				= 0
MyPSkillLevel			= 0
MyPMode				= 0
--MySpheres			= 0  -- S-Type Homunculus variable - Commented out for Pre-Renewal Basic Homunculus Only
MyASAPBuffs			= {0,0,0,0,0,0,0,0,0,0}
MyPosX				= {0,0,0,0,0,0,0,0,0,0}	-- list of positions
MyPosY				= {0,0,0,0,0,0,0,0,0,0}	-- to better sense motion
OwnerPosX			= {0,0,0,0,0,0,0,0,0,0}	-- list of owner positions
OwnerPosY			= {0,0,0,0,0,0,0,0,0,0}	-- to better sense motion
EnemyPosX			= {0,0,0,0,0,0,0,0,0,0}
EnemyPosY			= {0,0,0,0,0,0,0,0,0,0}
MyMotions			= {0,0,0,0,0,0,0,0,0,0} -- to better detect freezes
MyStates			= {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
MyEnemies			= {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
SeraLegionBugHist	= {0,0,0,0,0}
SeraLegionTotalHist	= {0,0,0,0,0}
SkillFailCount={0,0,0,0,0,0,0,0,0}
SkillFailCount[-1]=0
PKFriendsTimeout={}
RandomMoveTries			= 0
AIInitTick=0
--Autoskill timeout counters
QuickenTimeout			= 0
GuardTimeout			= 0
MagTimeout			= 0
SightTimeout			= 0
SOffensiveTimeout		= 0
SDefensiveTimeout		= 0
SOwnerBuffTimeout		= 0
SkillTimeout			= 0
ProvokeOwnerTimeout		= 0
ProvokeSelfTimeout		= 0
SacrificeTimeout		= 0
OffensiveOwnerTimeout	= 0
DefensiveOwnerTimeout	= 0
OtherOwnerTimeout		= 0
SteinWandTimeout		= 0
AutoSkillTimeout		= 0 --Cast time + delay timeout
AttackTimeout			= 0 --for AttackTimeLimit
AutoSkillCastTimeout	= 0 --Cast time timeout
TankHitTimeout			= 0
SkillObjectCMDTimeout   = 0
--Advanced movement stuff
--OrbitWalkStep			= 0
IdleWalkTries			= 0
IdleWalkCounter			= 0
RouteWalkStep			= nil
RouteWalkDirection		= 1
KiteDestX			= 0
KiteDestY			= 0
--Other stuff
MyStart				= GetTick()
MySkillUsedCount		= 0
ChaseGiveUpCount		= 0
AttackGiveUpCount		= 0
ChaseDebuffUsed			= 0
Unreachable			= {}
FollowTryCount			= 0
FastChangeCount			= 0
AllTargetUnreachable		= 0
MyAttackStanceX,MyAttackStanceY = 0,0
AttackDebuffUsed		= 0
NeedToDoAutoFriend		= 0
ShouldStandby			= 0
BypassKSProtect			= 0
MercType				= 0
BerzerkMode				= 0
ReturnToMoveHold		= 0
TankMonsterCount		= 0
ReturnToState			= 0
NewFriendX,NewFriendY	= 0,0
FriendMotionTime		= 0
FriendCircleIter		= 0
FriendCircleTimeout		= 0
DoneInit				= 0
AtkPosbugFixTimeout		= 0
--EleanorMode				= 0  -- S-Type Homunculus variable - Commented out for Pre-Renewal Basic Homunculus Only
LastAITime_ART			= 0
StickyX,StickyY			= 0,0
MyLastSP				= 0
RegenTick				= {0,{0,0,0}}
CastSkill				= 0
CastSkillLevel			= 0
CastSkillMode			= 0
ReserveSP				= 0
LastSPTime				= GetTick()
LastMovedTime			= GetTick()
SteinWandPauseTime		= 0
LastAIDelay				= 0
MyMaxSP					= 0
MyBuffSPCosts			= {}
MyBuffSPCost			= 0		
SingBuffed				= 0
SingTimer				= 0
SingTarget				= 0
SingSeeking				= 0		-- 0 = not seeking, 1 = actively moving to singer
SingLastCheck			= 0		-- Timer for periodic sing buff checking
SavedBards				= {}	-- Table to track bards: {actorID = {lastSeen, lastBuffed, songEndTime}}
CurrentBuffProvider		= 0		-- ID of the bard who provided our current buff

-- Separate Dancer Buff System Variables
DanceBuffed				= 0
DanceTimer				= 0
DanceTarget				= 0
DanceSeeking			= 0		-- 0 = not seeking, 1 = actively moving to dancer
DanceLastCheck			= 0		-- Timer for periodic dance buff checking
SavedDancers			= {}	-- Table to track dancers: {actorID = {lastSeen, lastBuffed, songEndTime}}
CurrentDanceProvider	= 0		-- ID of the dancer who provided our current buff


-- These need to be globals
Actors				= {}
Players				= {}
Monsters			= {}
Targets				= {}
Summons				= {}
Retainers			= {}
IsActive			= {}
Attackers			= {} 
AAIActors			= {}
MobID 				= {}
TakenCells			= {}

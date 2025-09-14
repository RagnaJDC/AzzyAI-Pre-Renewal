-- H_SkillList.lua	v1.50.1
-- Converted to Lua by Dr. Azzy from
-- Mercenary skill list posted by Neo Saro -and-
-- All skill list and skill info values laboriously hand entered by Dr. Azzy
-- This may be distributed and used in AIs freely

MS_BASH			= 8201
MS_MAGNUM		= 8202
MS_BOWLINGBASH		= 8203
MS_PARRYING		= 8204
MS_REFLECTSHIELD	= 8205
MS_BERSERK		= 8206
MA_DOUBLE		= 8207
MA_SHOWER		= 8208
MA_SKIDTRAP		= 8209
MA_LANDMINE		= 8210
MA_SANDMAN		= 8211
MA_FREEZINGTRAP		= 8212
MA_REMOVETRAP		= 8213
MA_CHARGEARROW		= 8214
MA_SHARPSHOOTING	= 8215
ML_PIERCE		= 8216
ML_BRANDISH		= 8217
ML_SPIRALPIERCE		= 8218
ML_DEFENDER		= 8219
ML_AUTOGUARD		= 8220
ML_DEVOTION		= 8221
MER_MAGNIFICAT		= 8222
MER_QUICKEN		= 8223
MER_SIGHT		= 8224
MER_CRASH		= 8225
MER_REGAIN		= 8226
MER_TENDER		= 8227
MER_BENEDICTION		= 8228
MER_RECUPERATE		= 8229
MER_MENTALCURE		= 8230
MER_COMPRESS		= 8231
MER_PROVOKE		= 8232
MER_AUTOBERSERK		= 8233
MER_DECAGI		= 8234
MER_SCAPEGOAT		= 8235
MER_LEXDIVINA		= 8236
MER_ESTIMATION		= 8237

-- Homunculus Skills
HLIF_HEAL		= 8001
HLIF_AVOID		= 8002
HLIF_CHANGE		= 8004
HAMI_CASTLE		= 8005
HAMI_DEFENCE		= 8006
HAMI_BLOODLUST		= 8008
HFLI_MOON		= 8009
HFLI_FLEET		= 8010
HFLI_SPEED		= 8011
HFLI_SBR44		= 8012
HVAN_CAPRICE		= 8013
HVAN_CHAOTIC		= 8014
HVAN_SELFDESTRUCT	= 8016

--SkillList[homuntype][skillid]=level
SkillList={}
SkillList[LIF]={}
SkillList[LIF][HLIF_HEAL]=5
SkillList[LIF][HLIF_AVOID]=5
SkillList[LIF][HLIF_CHANGE]=3
SkillList[AMISTR]={}
SkillList[AMISTR][HAMI_CASTLE]=5
SkillList[AMISTR][HAMI_DEFENCE]=5
SkillList[AMISTR][HAMI_BLOODLUST]=3
SkillList[FILIR]={}
SkillList[FILIR][HFLI_MOON]=5
SkillList[FILIR][HFLI_FLEET]=5
SkillList[FILIR][HFLI_SPEED]=5
SkillList[FILIR][HFLI_SBR44]=3
SkillList[VANILMIRTH]={}
SkillList[VANILMIRTH][HVAN_CAPRICE]=5
SkillList[VANILMIRTH][HVAN_CHAOTIC]=5
SkillList[VANILMIRTH][HVAN_SELFDESTRUCT]=3

--SkillListM[mertype][skillid]=level

--SkillInfo[id]={name,range,SP cost,Cast Time (fixed),Cast Time (variable),Delay,targetmode,Duration,reuse delay)
--SkillInfo[id][1]=name
--SkillInfo[id][2]=range
--SkillInfo[id][3]=sp cost
--SkillInfo[id][4]=Fixed cast (ms)
--SkillInfo[id][5]=Variable cast (ms)
--SkillInfo[id][6]=Delay (ms)
--SkillInfo[id][7]=target mode (0 = self targeted, 1 = enemy targeted, 2 = ground targeted) 
--SkillInfo[id][8]=Duration (ms)
--SkillInfo[id][9]=Reuse Delay (ms)

SkillInfo={}
SkillInfo[0]={"No Skill",{0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0}}
SkillInfo[HLIF_HEAL]={"Healing Hands",{0,0,0,0,0},{13,16,19,22,25},{0,0,0,0,0},{0,0,0,0,0},{20000,20000,20000,20000,20000},0,{0,0,0,0,0},{5000,5000,5000,5000,5000}}
SkillInfo[HLIF_AVOID]={"Urgent Escape",{0,0,0,0,0},{20,25,30,35,40},{0,0,0,0,0},{0,0,0,0,0},{1000,1000,1000,1000,1000},0,{40000,35000,35000,35000,35000}}
SkillInfo[HLIF_CHANGE]={"Mental Charge",{0,0,0},{100,100,100},{0,0,0},{0,0,0},{2000,2000,2000},0,{370000,790000,1210000}}
SkillInfo[HAMI_CASTLE]={"Castling",{0,0,0,0,0},{10,10,10,10,10},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},0}
SkillInfo[HAMI_DEFENCE]={"Amistr Bulwark",{0,0,0,0,0},{20,25,30,35,40},{0,0,0,0,0},{0,0,0,0,0},{1000,1000,1000,1000,1000},0,{40000,35000,30000,30000,30000}}
SkillInfo[HAMI_BLOODLUST]={"Bloodlust",{0,0,0},{120,120,120},{0,0,0},{0,0,0},{2000,2000,2000},0,{310000,610000,910000}}
SkillInfo[HFLI_MOON]={"Moonlight",{1,1,1,1,1},{4,8,12,16,20},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},1,{0,0,0,0,0},{200,200,200,200,200}}
SkillInfo[HFLI_FLEET]={"Flitting",{0,0,0,0,0},{30,40,50,60,70},{0,0,0,0,0},{0,0,0,0,0},{1000,1000,1000,1000,1000},0,{60000,70000,80000,90000,120000}}
SkillInfo[HFLI_SPEED]={"Accellerated Flight",{0,0,0,0,0},{30,40,50,60,70},{0,0,0,0,0},{0,0,0,0,0},{1000,1000,1000,1000,1000},0,{60000,70000,80000,90000,120000}}
SkillInfo[HFLI_SBR44]={"SBR 44",{1,1,1},{1,1,1},{0,0,0},{0,0,0},{0,0,0},1}
SkillInfo[HVAN_CAPRICE]={"Caprice",{9,9,9,9,9},{22,24,26,28,30},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},1,{0,0,0,0,0},{220,240,260,280,300}}
SkillInfo[HVAN_CHAOTIC]={"Chaotic Blessing",{0,0,0,0,0},{40,40,40,40,40},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},0,{0,0,0,0,0},{3500,3500,3500,3500,3500}}
SkillInfo[HVAN_SELFDESTRUCT]={"Self Destruct",{0,0,0},{15,15,15},{0,0,0},{0,0,0},{0,0,0},0}

--SkillAOEInfo[skill]={AoE size (size on a side of the AoE - by level),Target Type (0=centered on enemy, 1=centered on caster, skill-id=special - handled in GetAOECount)), other fields for future use}
SkillAOEInfo={}
SkillAOEInfo[0]={{0,0,0,0,0},0}
SkillAOEInfo[HVAN_SELFDESTRUCT]={{9,9,9},1}
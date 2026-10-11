Dr. Azzy's AzzyAI v1.54
Modified for uaRO-Pre-Renewal v1.0
Enhanced uaRO AzzyAI - Pre-Renewal Optimized
!!!UARO PRE-RENEWAL SERVER ONLY - WILL ERROR ON OTHER SERVERS!!!

FEATURES:
• Complete renewal code removal (faster performance)
• Zero AI delay
• 18-cell extended view, attack and chase range
• Automatic bard/dancer buff collection
• Enhanced friend and PvP ally management
• Blocked-cell kite (hold skill range, cast on the walk, peel the owner's attacker)
• PvP class tactics with friend/ally first, auto-ally on give-up, DoNotChase on players
• Crash used as a mercenary attack skill
• Updated config GUI (AzzyAiConfigPreRe.exe v1.0) with kite, PvP, and follow options

-----------------------------------------------------------------------
FRIEND MANAGEMENT
-----------------------------------------------------------------------
🟢 ADD ALL PLAYERS: Stand up → Alt+Right-click yourself
🔴 CLEAR ALL FRIENDS AND ALLIES: Sit down → Alt+Right-click yourself  
🟡 ADD PVP ALLIES: Stand up → Alt+Right-click your homunculus
🔵 INDIVIDUAL: Stand up → Alt+Right-click 1 cell below or above player

Visual confirmations: Homunculus runs in a Circle (added friends), Homunculus runs in a Cross (removed friends)
Enable: Set MirAIFriending = 1

Friend and ally roles beat job-class PvP rows. A team wizard you allied stays Ignore; class Attack-H only applies to unlisted enemies.
Late WOE/BG joiners the client will not lock can be written as ALLY automatically (PVPAutoAllyOnGiveUp = 1, PVP Options in the GUI).

-----------------------------------------------------------------------
AUTO BUFF COLLECTION
-----------------------------------------------------------------------
🥇 BARDS FIRST: Seeks Bragi and bard songs (priority)
🥈 DANCERS SECOND: Seeks Service for You and dancer songs after a bard or if no bard is available

Setup:
• PickUpBraggi = 1 (bard buffs, set to 0 to disable)
• PickUpDancer = 1 (dancer buffs, set to 0 to disable)

Extended 18-cell range matches uaRO zoom for buff searching. (This works by detecting a song or dance when played. 
It then stores the information of that bard/dancer to use later, it CAN NOT see a currently active song and must see a song be originally played)

Caprice waits 1500 ms aftercast on uaRO unless a bard song is up. With a song, reuse stays 220–300 ms so it can recast fast.

-----------------------------------------------------------------------
USE SKILL ON FOLLOW
-----------------------------------------------------------------------
🏃 Your homunculus/mercenary can now attack while following you
• UseSkillOnFollow = 1 (enable attacking while following, great for run-and-gun farming)
• UseSkillOnFollow = 0 (disable, classic follow behavior)
Configure in AzzyAiConfigPreRe.exe under Auto Skill options for both Homunculus and Mercenary

-----------------------------------------------------------------------
PVP CLASS-SPECIFIC TACTICS
-----------------------------------------------------------------------
⚔️ Set different combat behaviors per enemy job class
• Configure unique tactics for each job (Knight, Wizard, Priest, etc.)
• Friend list and ally list are checked before the class row
• Access via AzzyAiConfigPreRe.exe → PVP Tactics (Homunculus) or Mercenary PVP Tactics
• Perfect for WOE/BG/PVP scenarios where you need class-specific responses

DoNotChase = 1 also applies to PvP players on CHASE_NORMAL rows (the default). The pet attacks in range and does not walk in. Set a class to CHASE_ALWAYS if you still want that class closed on.

-----------------------------------------------------------------------
BLOCKED-CELL KITE
-----------------------------------------------------------------------
🪁 Kite around walls and plants instead of repeating a failed Move
• Failed kite cells are marked blocked (~650 ms)
• Next dest is picked on an 8-direction ring in Caprice/DS range and KiteBounds
• Holds skill range and casts on the walk; peels the owner's attacker if it is in sight
• Requires KiteMonsters = 1
• UseBlockedKite = 1 (new picker) or 0 (old Azzy dest math)
Configure in AzzyAiConfigPreRe.exe under Kiting Options

-----------------------------------------------------------------------
CONFIG GUI
-----------------------------------------------------------------------
Run AzzyAiConfigPreRe.exe in USER_AI folder (v1.0)
• Removal of Renewal features
• Clean interface
• DPI scaling and readable fonts
• Homunculus type filtering
• Saves UseBlockedKite, PVPAutoAllyOnGiveUp, and UseSkillOnFollow

-----------------------------------------------------------------------
INSTALLATION
-----------------------------------------------------------------------
To install:
1. Navigate to your uaRO folder and find the "AI" folder
2. Rename the "AI" folder to "AI-BACKUP"
3. Extract the "AI" folder from the uaRO AzzyAI v1.0 release into your uaRO folder
4. Start uaRO and type /hoai and /merai once ingame and enjoy!

You can edit settings by using AzzyAiConfigPreRe.exe inside "AI\USER_AI"

To uninstall:
1. Navigate to your uaRO folder and find the "AI" folder
2. Delete the "AI" folder
3. Rename the "AI-BACKUP" folder to "AI"

!!!UARO PRE-RENEWAL SERVER ONLY - WILL ERROR ON OTHER SERVERS!!!

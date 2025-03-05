--[[

    ****************************************
    * GBR - LegendaryFarmer | Legendary Node/Crystal/Cluster/Sand Farmer *
    * Aetherial Reduction | Scrip Exchanege *
    *               *                       *
    ****************************************

Author: Ahernika
Script is mostly re used codes from existing codes on snd wiki and some my additions, thanks to friends on punish disco
notably but not least of:
    1.A4N-AR Integration:Author UcanPatates/Ice
    2.Spearfishing Desynth | Author - Ice
    3.GBR-AR integration: Author - EllipsisVidakel
    4. Gathering Helper| Author Leaffriend

    **********************
    * Version  |  1.0.4  *
    **********************
    -> 1.0.4 : Added Scrip Exchange/Retainers in Solution 9
    -> 1.0.3 : Added Scrip Exchange in only Gridania for now/ Ranamed the scripts
    -> 1.0.1 : Quick Additional funtionality for extract materia/potion and food use -credit Gathering helper
              : Removed reqiremenet for plugin collections due addition of qol commands like /gbr auto on/off
              : Other minor clean ups to help easy inital setup, no need to set character name now
    -> 1.0.0  : Working gbr crystal farmer (using Aetherial Reduction Method) with AutoRetainer. <Reading instructions/ settings recommended>

    ***************
    * Description *
    ***************
    Description: LegendaryFarmer
    The script allows you to use Gather Buddy Reborn Auto gathering and when you get to a certain inventory amount it will pause for you and proceed to reduce all your collectables.
    And process retainers whe AR is ready
    Will do scrip exchange and collectible Appriaser when inventory below threshold (can do them in solution)
    Particular use cases are
    1.is farming crystals/clusters and sands from DT time nodes using aetherial reduction method.
    2.Farming Legendary nodes and purple/orange collectible DT nodes
    3.General Support script for GBR even for Regular Nodes (to help do potions/food, repair/extract, retainers/gc deliveries etc)
   *********************
    *  Required Plugins *
    *********************

    -> SomethingNeedDoing (Expanded Edition) [Make sure to press the lua button when you import this] -> https://puni.sh/api/repository/croizat
    -> vnavmesh : https://puni.sh/api/repository/veyn [might require restart of game every once in a while when vnvmesh fails, use command /xlrestart]
    -> Pandora's Box : https://love.puni.sh/ment.json [used to set auto cordial, set high enough not to overcap, mine is around 600 GP., disable auto interact and Pandora quick gathering to be safe]
    -> Gather Buddy Reborn : https://raw.githubusercontent.com/FFXIV-CombatReborn/CombatRebornRepo/main/pluginmaster.json [our main gathering tool, set minimum GP to inetract with nodes to around 500GP for collectibles (can try and check other setting btw 400 and 600 as well)]
    -> AutoRetainer : https://love.puni.sh/ment.json [currently using /ays e for single character, need to test with /ays multi]
    -> Lifestream for /li gc command
    -> Deliveroo: to do gc deliveries https://plugins.carvel.li/
    -> YesAlready: Auto Return to x location requires setting a yes already for it (look up yes already channel for help or disable this feature in settings)

    Some other notes: !!IMPORTANT!!
    Set a auto gather list in GBR with timed emphemeral nodes preferabley from EW (ghostly umbral rock,sohora roots/ewer clay,lunar/earthern quartz, palm chippings etc.  ) and DT (volcanic grass, goldbranch, electocoal, brightwind ore.) set order based on crystal/cluster preference having multiple items helps avaoid any downtime.
    Example GBR gather list preset i use (you don't have to))
    DT Orange: H4sIAAAAAAAACjWLPQvCMBCGwZ9y8wlpzqWZ69DFInQTh2gPCdhY0usgpf/d5FQOHt6v263QCo/tMIO7HKi2NRZaJRWSuaJu+vfEZVWhXk7Pi48SJJR4Bf0GVxmDqq3qn6Fs/g2Zb7MhnPzI4KDp913y8cGA0PB8T2GS8Iq5ycEx+tuTB3CSFt4+E/b7mbEAAAA=
    DT purple: H4sIAAAAAAAACmOqVvIsSc31TClWsoo2MbY0stAxMTEyNtEBsQ3BpFmsDlhNSGVBKkiVoQ4YAkUDSxPzSjJLMkHC1Upg3UpWhgYGOkpgM2BskElIbDMwu1ZHyS8xN1XJSsklRDegtKggJ1VJR8kltTi5KLOgJDM/DygDFHDNS0zKSU1RsiopKk2tBQBZshanrgAAAA==
    DT Legendaries:H4sIAAAAAAAACk2NywrCMBBFwU+Z9QipTV9Z10VBBMGNiItoBwnYWNJ0IaX/bjKChIEDZ+48Ngt0noaun0BdpcykwMC8ZjbMglkxyxvy/PkzUtzI8F8hOc3aeuNNjBbga6B2QgiMktepNKkUqVSplD9ZEY56IFDQXrYHepLttYt/EFqaHs6M3rxtiENjb/X9RT0o72Zav++o8QbhAAAA
    make more for yourself and add it to GBR (make sure atleast 1 is enabled before triggering)
    make sure you have this list enabled before trigerring the script
    **************
    *  SETTINGS  *
    **************
  --]]
---Food Settings---!!!<EDIT THESE>!!!--------------
food_to_eat                           =
"Stuffed Peppers <hq>"                                                --what food to eat (false if none) --there is no check if you don't have that food, script will move on after set time
medicine_to_use                       =
"Superior Spiritbond Potion <hq>"                                     --what potion to use (false if none) --there is no check if you don't have that potion, script will move on after set time

--things you want to enable
do_extract                            = true --If true, will extract materia if possible (GBR does this now, so only use one of the two to avaoid conflicts)
do_reduce                             = true --If true, will reduce ephemerals if possible
do_repair                             = true --If true, will do repair if possible set repair amount below
do_scrips                             = true --If true, will do colletibles and scrip exchange (only in griania for now) !!!!read the settings below carefully!!! to set items
--If currently does purple=high coridals and orange = mythbloom aethersand (you can change it)
do_ar                                 = true --If true, will do AR (autoretainers)
do_gc_delivery                        = true --If true, will do GC deliveries using deliveroo everytime retainers are processed
--use_tickets                           = true --If true, will use tickets to Teleport to GC town for gc deliveries :) for ppl with lot gc seals only
--------------------------------------
--General Settings
use_gbr                               = true --use GBR for gathering
return_to_gc_town                     = true --[Will Require !!!Yes ALready set to accept promt!!!] if true will use fast return to GC town for retainers and scrip exchange (that assumes you set return location to your gc town else turn it false), else false
num_inventory_free_slot_threshold     = 10 --set !!!carefully how much inventory before script stops gathering and does additonal tasks!!!
msgDelay                              = 10
crystal_check                         = true --just fun little warning if you are about overcap crystals, checks every 30s (will not stop script so be careful of wasting crystals/clusters)
verbose                               = true
interval_rate                         = 0.1 --general wait time used in the script can play with it if your system loads ui more slowly
timeout_threshold                     = 10 --certain functions timeout and close if they don't work as intended due to some reason, after this period
--------------------------------------
--Food and Potion Settings
consume_threshold                     = 10 --how long till script tries to eat food, leave it as it is
--Repair Settings
RepairAmount                          = 50 --repair threshold, adjust as needed
--------------------------------------
--desynth settings
--------------------------------------
--AR Settings
all_characters                        = false --do you want to do it for 1 character or multiple, tested only on 1 character for now, so false
interval_rate                         = 0.1
additional_scrip_exchange             = true --important if this is set true script will do retainers/scrip exchange in 4 th additional location (beside GC cities)
additional_scrip_exchange_location    = "solution" --teleporter command location name for the 4th location (Solution Nine here by default)
additional_scrip_exchange_sublocation = "nexus"   --/li aethyryte name in case you need to get somewhere within that city


--vnav x,y,z cordinates of bell and zoneid of location city (shown below are examples for 3 GC cities and solution 9
paths_to_mb              = {           --paths to retainer bell, leave it as it is unless you edit functions below aswell
    { -124.703, 18.00, 19.887,  129 }, -- Path to Retainer Bells
    { 168.72,   15.5,  -100.06, 132 },
    { 146.760,  4,     -42.992, 130 },
    { -152.465, 0.660, -13.557, 1186 } --Path to bell in solution 9 in this example/4th location
}

--vnav x,y,z cordinates of collectable appraiser and zoneid of location city (shown below are examples for 3 GC cities and solution 9
paths_to_scrip                        = { --paths to scrip exchnage, leave it as it is unless you edit functions below aswell
    { -258.09,  16.079, 42.089,  129 }, -- Path to Scrip Exchange/Collectable Appraiser
    { 142.15,   13.74,  -105.39, 132 },
    { 149.349,  4,      -18.722, 130 },
    {  -158.019, 0.922, -37.884, 1186 } -- vnav cordinates for the 4th additional location appraiser (here one in solution 9)/4th location

}
--Collecable Appraiser and Scrip Exchange Settings
min_items_before_turnins = 1             --how many collectibles before turining in
scrip_overcap_limit      = 3900          --when should you stop turnin in, to avoid scrip wasteage

--collectible_to_turnin_row, item_id, job_for_turnin, turnin_scrip_type (follow examples shared here)
collectible_item_table   =
{
    --MINER
    --orange scrips --39 for orange scrips
    { 0, 43922, 8, 39 }, --ra'kaznar ore
    { 1, 43923, 8, 39 }, --ash soil
    { 3, 43921, 8, 39 }, --magnesite ore
    --BOTANIST
    { 0, 43929, 9, 39 }, --acacia log
    { 1, 43930, 9, 39 }, --windsbalm bay lef
    { 3, 43928, 9, 39 }, --dark mahagony

    --MINER
    --purple scrips --38 for purple scrips
    { 4, 44233, 8, 38 }, --white gold ore
    { 5, 43920, 8, 38 }, --titanium gold ore
    { 6, 43919, 8, 38 }, --dark amber
    --BOTANIST
    { 4, 44234, 9, 38 }, --acacia bark
    { 5, 43927, 9, 38 }, --kukuru beans
    { 6, 43926, 9, 38 }  --mountain flax

}
--scrip_exchange_category,scrip_exchange_subcategory,scrip_exchange_item_to_buy_row, collectible_scrip_price (follow examples shared here) change as needed
min_scrip_for_exchange   = 20
exchange_item_table      = {
    { 4, 8, 6, 1000 }, --what to spend orange (rroneek tokens here) --only 1 item to spend orange scrips on and one time to purple scrips on
    { 4, 1, 0, 20 },  --what to spend purple on (high cordials)
}

--example setup
--Purple Scrips
--{ 5, 1, 0, 250 } -Gatherer's Gueurdon Materia XI (Gathering + 20)
--{ 5, 1, 1, 250 } -Gatherer's Guile Materia XI (Perception + 20)
--{ 5, 1, 2, 250 } -Gatherer's Grasp Materia XI (GP + 9)
--{ 4, 1, 0, 20 } -High Coridals

--Orange Scrips
--{ 5, 2, 0, 500 } -Gatherer's Gueurdon Materia XII (Gathering + 36)
--{ 5, 2, 1, 500 } -Gatherer's Guile Materia XII (Perception + 36)
--{ 5, 2, 2, 500 } -Gatherer's Grasp Materia XII (GP + 11)
--{ 4, 8, 2, 100 } -Sunglit Sand
--{ 4, 8, 3, 200 } -Mythload Sand
--{ 4, 8, 4, 200 } -Mythroot Sand
--{ 4, 8, 5, 200 } -Mythbrine Sand
--{ 4, 8, 6, 1000 } -RRoneek Horn Tokens


-----------------------------------------------------
--some default stuff leave as it is
--init
local stop_main          = false
local i_count            = tonumber(GetInventoryFreeSlotCount())
local loop               = 1
----------------------------------------
--[[

  **************
  *  Start of  *
  *   Script   *
  **************
  ---------------------------------------------------------------
  --]]
--some helper lua functions
function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function Split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function AddToSet(set, key)
    set[key] = true
end

function ParseNodeDataString(string)
    return Split(string, ",")
end

--Return printable node
function PrintNode(node)
    local printable_node = node or ""
    if truncate then
        local data = ParseNodeDataString(node)
        local x = Truncate1Dp(data[2])
        local y = Truncate1Dp(data[3])
        local z = Truncate1Dp(data[4])
        printable_node = data[1] .. "," .. x .. "," .. y .. "," .. z
    end
    return printable_node
end

function Id_Print(string, print, debug)
    local time = -msgDelay
    if print == nil then print = true end
    if debug == nil then debug = false end
    print_history = print_history or Set {}
    script_start = script_start or os.clock()

    if debug then
        LogDebug("[LegendaryFarmer] [DEBUG] " .. string)
        return
    end


    for k, _ in pairs(print_history) do
        entry = Split(k, "_")
        if entry and time < tonumber(entry[1]) and entry[2] == string then
            time = tonumber(entry[1])
        end
    end

    if print and os.clock() - script_start >= time + msgDelay then
        yield("/echo [LegendaryFarmer] " .. string)
        AddToSet(print_history, (os.clock() - script_start) .. "_" .. string)
    end
end

function Truncate1Dp(num)
    return truncate and ("%.1f"):format(num) or num
end

---------------------------------------------------------------------------------
--Utility and Check Funtions
--MoveTo
function MoveTo(valuex, valuey, valuez, stopdistance, FlyOrWalk)
    function MeshCheck()
        function Truncate1Dp(num)
            return truncate and ("%.1f"):format(num) or num
        end

        local was_ready = NavIsReady()
        if not NavIsReady() then
            while not NavIsReady() do
                LogInfo("[Debug]Building navmesh, currently at " .. Truncate1Dp(NavBuildProgress() * 100) .. "%")
                yield("/wait 1")
                local was_ready = NavIsReady()
                if was_ready then
                    LogInfo("[Debug]Navmesh ready!")
                end
            end
        else
            LogInfo("[Debug]Navmesh ready!")
        end
    end

    MeshCheck()
    if FlyOrWalk then
        if TerritorySupportsMounting() then
            while GetCharacterCondition(4, false) do
                yield("/wait 0.1")
                if GetCharacterCondition(27) then
                    yield("/wait 2")
                else
                    yield('/gaction "mount roulette"')
                end
            end
            if HasFlightUnlocked(GetZoneID()) then
                PathfindAndMoveTo(valuex, valuey, valuez, true) -- flying
            else
                LogInfo("[MoveTo] Can't fly trying to walk.")
                PathfindAndMoveTo(valuex, valuey, valuez, false) -- walking
            end
        else
            LogInfo("[MoveTo] Can't mount trying to walk.")
            PathfindAndMoveTo(valuex, valuey, valuez, false) -- walking
        end
    else
        PathfindAndMoveTo(valuex, valuey, valuez, false) -- walking
    end
    while ((PathIsRunning() or PathfindInProgress()) and GetDistanceToPoint(valuex, valuey, valuez) > stopdistance) do
        yield("/wait 0.3")
    end
    PathStop()
    LogInfo("[MoveTo] Completed")
end


function CheckNavmeshReady()
    was_ready = NavIsReady()
    while not NavIsReady() do
        Id_Print("Building navmesh, currently at " .. Truncate1Dp(NavBuildProgress() * 100) .. "%")
        yield("/wait " .. (interval_rate * 10))
    end
    if not was_ready then Id_Print("Navmesh is ready!") end
end

function NodeMoveFly(node, force_moveto)
    local force_moveto = force_moveto or false
    local x = tonumber(ParseNodeDataString(node)[2]) or 0
    local y = tonumber(ParseNodeDataString(node)[3]) or 0
    local z = tonumber(ParseNodeDataString(node)[4]) or 0
    last_move_type = last_move_type or "NA"

    CheckNavmeshReady()
    start_pos = Truncate1Dp(GetPlayerRawXPos()) ..
        "," .. Truncate1Dp(GetPlayerRawYPos()) .. "," .. Truncate1Dp(GetPlayerRawZPos())
    if not force_moveto and ((GetCharacterCondition(4) and GetCharacterCondition(77)) or GetCharacterCondition(81)) then
        last_move_type = "fly"
        PathfindAndMoveTo(x, y, z, true)
    else
        last_move_type = "walk"
        PathfindAndMoveTo(x, y, z)
    end
    while PathfindInProgress() do
        Id_Print("[VERBOSE] Pathfinding from " .. start_pos .. " to " .. PrintNode(node) .. " in progress...", verbose)
        yield("/wait " .. interval_rate)
    end
    Id_Print("[VERBOSE] Pathfinding complete.", verbose)
end

function StopMoveFly()
    PathStop()
    while PathIsRunning() do
        yield("/wait " .. interval_rate)
    end
end

function VNavMovement() -- Used to Do NOTHING While Moving
    repeat
        yield("/wait " .. interval_rate * 10)
    until not PathIsRunning()
end

function Dismount()
    if GetCharacterCondition(77) then
        local random_j = 0
        ::DISMOUNT_START::
        CheckNavmeshReady()

        local land_x
        local land_y
        local land_z
        local i = 0
        while not land_x or not land_y or not land_z do
            land_x = QueryMeshPointOnFloorX(GetPlayerRawXPos() + math.random(0, random_j),
                GetPlayerRawYPos() + math.random(0, random_j), GetPlayerRawZPos() + math.random(0, random_j), false, i)
            land_y = QueryMeshPointOnFloorY(GetPlayerRawXPos() + math.random(0, random_j),
                GetPlayerRawYPos() + math.random(0, random_j), GetPlayerRawZPos() + math.random(0, random_j), false, i)
            land_z = QueryMeshPointOnFloorZ(GetPlayerRawXPos() + math.random(0, random_j),
                GetPlayerRawYPos() + math.random(0, random_j), GetPlayerRawZPos() + math.random(0, random_j), false, i)
            i = i + 1
        end
        NodeMoveFly("land," .. land_x .. "," .. land_y .. "," .. land_z)


        local timeout_start = os.clock()
        repeat
            yield("/wait " .. interval_rate)
            if os.clock() - timeout_start > timeout_threshold then
                Id_Print("Failed to navigate to dismountable terrain.")
                Id_Print("Trying another place to dismount...")
                random_j = random_j + 1
                goto DISMOUNT_START
            end
        until not PathIsRunning()

        yield('/gaction "Mount Roulette"')

        timeout_start = os.clock()
        repeat
            yield("/wait " .. interval_rate)
            if os.clock() - timeout_start > timeout_threshold then
                Id_Print("Failed to dismount.")
                Id_Print("Trying another place to dismount...")
                random_j = random_j + 1
                goto DISMOUNT_START
            end
        until not GetCharacterCondition(77)
    end
    if GetCharacterCondition(4) then
        yield('/gaction "Mount Roulette"')
        repeat
            yield("/wait " .. interval_rate)
        until not GetCharacterCondition(4)
    end
end

function CrystalCheck()
    if crystal_check then
        Id_Print("[LegendaryFarmer] Current Crystals/Clusters in Inventory")
        Id_Print("***Fire Crystals/Clusters:" .. GetItemCount(8) .. "/ " .. GetItemCount(14))
        Id_Print("***Wind Crystals:" .. GetItemCount(10) .. "/ " .. GetItemCount(16))
        Id_Print("***Earth Crystals:" .. GetItemCount(11) .. "/ " .. GetItemCount(17))
        Id_Print("***Lightning Crystals:" .. GetItemCount(12) .. "/ " .. GetItemCount(18))

        if ((GetItemCount(8) > 9900) or (GetItemCount(10) > 9900) or (GetItemCount(11) > 9900) or (GetItemCount(12) > 9900)) then
            Id_Print("***This maybe good time to dump your crystals to your retainers or MB")
        end
    end
end

--window closing functions
function getOutOfGathering()
    while GetCharacterCondition(6) or GetCharacterCondition(42) do
        yield("/wait " .. interval_rate * 13)
        yield("/echo waiting to disable GBR")
        yield("/callback Gathering true -1")
        yield("/wait " .. interval_rate * 2)
        yield("/callback GatheringMasterpiece true -1")
    end
end

--------------------------------------------------------------------------------------------------------------
--Pathing Functions to certain locations retainers and scrips
function PathToScrip()
    if additional_scrip_exchange then
        local x = paths_to_scrip[4][1]
        local y = paths_to_scrip[4][2]
        local z = paths_to_scrip[4][3]

        local zoneid = paths_to_scrip[4][4]
        yield("/vnav stop")

        yield("/tp " .. additional_scrip_exchange_location)
        yield("/wait " .. interval_rate * 15)
        repeat
            yield("/wait " .. interval_rate)
        until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
        yield("/wait " .. interval_rate * 10)
        yield("/li " .. additional_scrip_exchange_sublocation)
        repeat
            yield("/wait " .. interval_rate * 30)
        until not LifestreamIsBusy()
        MoveTo(x, y, z, 0.1, false)
        yield("/wait " .. interval_rate * 10)
    else
        if return_to_gc_town then
            yield("/return")
            yield("/wait " .. interval_rate * 10)
        else
            TeleportToGCTown()
        end


        local gc_no = GetPlayerGC()
        if gc_no == 1 then
            local zoneid = paths_to_scrip[1][4]
            local x = paths_to_scrip[1][1]
            local y = paths_to_scrip[1][2]
            local z = paths_to_scrip[1][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            --yield("/wait " .. interval_rate * 20)
            --yield("/li hawkers")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        elseif gc_no == 2 then
            local zoneid = paths_to_scrip[2][4]
            local x = paths_to_scrip[2][1]
            local y = paths_to_scrip[2][2]
            local z = paths_to_scrip[2][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            yield("/li leatherworker")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        elseif gc_no == 3 then
            local zoneid = paths_to_scrip[3][4]
            local x = paths_to_scrip[3][1]
            local y = paths_to_scrip[3][2]
            local z = paths_to_scrip[3][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            yield("/li sapphire")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        end
        yield("/wait " .. interval_rate)
        if PathIsRunning() then
            repeat
                yield("/wait " .. interval_rate)
            until not PathIsRunning()
        end
    end
end

function PathToMB()
    if additional_scrip_exchange then
        local x = paths_to_mb[4][1]
        local y = paths_to_mb[4][2]
        local z = paths_to_mb[4][3]

        local zoneid = paths_to_mb[4][4]
        yield("/vnav stop")

        yield("/tp " .. additional_scrip_exchange_location)
        yield("/wait " .. interval_rate * 15)
        repeat
            yield("/wait " .. interval_rate)
        until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
        yield("/wait " .. interval_rate * 10)
        yield("/li " .. additional_scrip_exchange_sublocation)
        repeat
            yield("/wait " .. interval_rate * 30)
        until not LifestreamIsBusy()
        MoveTo(x, y, z, 0.1, false)
        yield("/wait " .. interval_rate * 10)
    else
        if return_to_gc_town then
            yield("/return")
            yield("/wait " .. interval_rate * 10)
        else
            TeleportToGCTown()
        end


        local gc_no = GetPlayerGC()
        if gc_no == 1 then
            local zoneid = paths_to_mb[1][4]
            local x = paths_to_mb[1][1]
            local y = paths_to_mb[1][2]
            local z = paths_to_mb[1][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            --yield("/wait " .. interval_rate * 20)
            --yield("/li hawkers")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        elseif gc_no == 2 then
            local zoneid = paths_to_mb[2][4]
            local x = paths_to_mb[2][1]
            local y = paths_to_mb[2][2]
            local z = paths_to_mb[2][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            yield("/li leatherworker")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        elseif gc_no == 3 then
            local zoneid = paths_to_mb[3][4]
            local x = paths_to_mb[3][1]
            local y = paths_to_mb[3][2]
            local z = paths_to_mb[3][3]
            repeat
                yield("/wait " .. interval_rate)
            until (zoneid == GetZoneID()) and (not GetCharacterCondition(27)) and (not GetCharacterCondition(45)) and (not GetCharacterCondition(51))
            yield("/li sapphire")
            yield("/wait " .. interval_rate * 50)
            PathfindAndMoveTo(x, y, z, false)
        end
        yield("/wait " .. interval_rate)
        if PathIsRunning() then
            repeat
                yield("/wait " .. interval_rate)
            until not PathIsRunning()
        end
    end
end


--------------------------------------------------------------------------------------------------------------
--enable and set property functions
function setSNDPropertyIfNotSet(propertyName)
    if GetSNDProperty(propertyName) == false then
        SetSNDProperty(propertyName, "true")
        LogInfo("[SetSNDPropertys] " .. propertyName .. " set to True")
    end
end

function unsetSNDPropertyIfSet(propertyName)
    if GetSNDProperty(propertyName) then
        SetSNDProperty(propertyName, "false")
        LogInfo("[SetSNDPropertys] " .. propertyName .. " set to False")
    end
end

--GBR enable/disable functions
function DeliverooEnable()
    if not DeliverooIsTurnInRunning() then
        yield("/wait " .. interval_rate * 10)
        yield("/deliveroo enable")
    end
end

function GBRAutoenable()
    yield("/wait " .. interval_rate)
    yield("/gbr auto on")
end

function GBRAutodisable()
    yield("/wait " .. interval_rate)
    yield("/vnav stop")
    while (GetCharacterCondition(6) or GetCharacterCondition(42) or GetCharacterCondition(27) or GetCharacterCondition(51)) do
        yield("/wait " .. interval_rate * 13)
        yield("/echo waiting for gathering or teleport to be completed before disabling GBR")
    end

    yield("/gbr auto off")
    yield("/wait " .. interval_rate * 10)
    getOutOfGathering() --incase of wrong disable
    yield("/wait " .. interval_rate * 10)
end

--------------------------------------------------------------------------------
--Main Task Funtions
--Wrapper for using potions, and if want to consume, consume if not medicated
function UseMedicine()
    if type(medicine_to_use) ~= "string" and type(medicine_to_use) ~= "table" then return end
    if GetZoneID() == 1055 then return end

    if not HasStatus("Medicated") then
        local timeout_start = os.clock()
        local user_settings = { GetSNDProperty("UseItemStructsVersion"), GetSNDProperty("StopMacroIfItemNotFound"),
            GetSNDProperty("StopMacroIfCantUseItem") }
        SetSNDProperty("UseItemStructsVersion", "true")
        SetSNDProperty("StopMacroIfItemNotFound", "false")
        SetSNDProperty("StopMacroIfCantUseItem", "false")
        repeat
            if type(medicine_to_use) == "string" then
                Id_Print("Attempt to use " .. medicine_to_use)
                yield("/item " .. medicine_to_use)
            elseif type(medicine_to_use) == "table" then
                for _, medicine in ipairs(medicine_to_use) do
                    Id_Print("Attempting to use " .. medicine, verbose)
                    yield("/item " .. medicine)
                    yield("/wait " .. math.max(interval_rate, 1))
                    if HasStatus("Medicated") then break end
                end
            end

            yield("/wait " .. math.max(interval_rate, 1))
        until HasStatus("Medicated") or os.clock() - timeout_start > consume_threshold
        SetSNDProperty("UseItemStructsVersion", tostring(user_settings[1]))
        SetSNDProperty("StopMacroIfItemNotFound", tostring(user_settings[2]))
        SetSNDProperty("StopMacroIfCantUseItem", tostring(user_settings[3]))
    end
end

--Wrapper for eating food, and if want to consume, consume if not fooded
function EatFood()
    if type(food_to_eat) ~= "string" and type(food_to_eat) ~= "table" then return end
    if GetZoneID() == 1055 then return end

    if not HasStatus("Well Fed") then
        local timeout_start = os.clock()
        local user_settings = { GetSNDProperty("UseItemStructsVersion"), GetSNDProperty("StopMacroIfItemNotFound"),
            GetSNDProperty("StopMacroIfCantUseItem") }
        SetSNDProperty("UseItemStructsVersion", "true")
        SetSNDProperty("StopMacroIfItemNotFound", "false")
        SetSNDProperty("StopMacroIfCantUseItem", "false")
        repeat
            if type(food_to_eat) == "string" then
                Id_Print("Attempt to eat " .. food_to_eat)
                yield("/item " .. food_to_eat)
            elseif type(food_to_eat) == "table" then
                for _, food in ipairs(food_to_eat) do
                    Id_Print("Attempting to eat " .. food, verbose)
                    yield("/item " .. food)
                    yield("/wait " .. math.max(interval_rate, 1))
                    if HasStatus("Well Fed") then break end
                end
            end

            yield("/wait " .. math.max(interval_rate, 1))
        until HasStatus("Well Fed") or os.clock() - timeout_start > consume_threshold
        SetSNDProperty("UseItemStructsVersion", tostring(user_settings[1]))
        SetSNDProperty("StopMacroIfItemNotFound", tostring(user_settings[2]))
        SetSNDProperty("StopMacroIfCantUseItem", tostring(user_settings[3]))
    end
end

--function to take care of repair, materia extract and aetherial reduction
function RepairExtractReduceCheck()
    if GetZoneID() == 1055 then return true end

    function SelfRepair()
        if do_repair and NeedsRepair(RepairAmount) then
            StopMoveFly()
            if GetCharacterCondition(4) then
                Id_Print("Attempting to dismount...")
                Dismount()
            end
            while not IsAddonVisible("Repair") do
                yield("/generalaction repair")
                yield("/wait " .. interval_rate * 5)
            end
            yield("/callback Repair true 0")
            yield("/wait " .. interval_rate)
            if GetNodeText("_TextError", 1) == "You do not have the dark matter required to repair that item." and
                IsAddonVisible("_TextError") then
                LogInfo("[LegendaryFarmer] Set to False not enough dark matter")
            end
            if IsAddonVisible("SelectYesno") then
                yield("/callback SelectYesno true 0")
            end
            while GetCharacterCondition(39) do
                yield("/wait " .. interval_rate * 10)
            end
            yield("/wait " .. interval_rate * 10)
            if IsAddonVisible("Repair") then
                yield("/callback Repair true -1")
            end
            Id_Print("[LegendaryFarmer] Repair Completed")
        end
    end

    SelfRepair()
    function MateriaExtract()
        if do_extract and CanExtractMateria(100) then
            StopMoveFly()
            if GetCharacterCondition(4) then
                Id_Print("[LegendaryFarmer] Attempting to dismount...")
                Dismount()
            end
            Id_Print("Attempting to extract materia...")
            yield("/generalaction \"Materia Extraction\"")
            yield("/wait " .. interval_rate * 30)
            yield("/waitaddon Materialize")

            while CanExtractMateria(100) == true do
                yield("/callback Materialize true 2 0")
                yield("/wait " .. interval_rate * 5)
                if IsAddonVisible("MaterializeDialog") then
                    yield("/callback MaterializeDialog true 0")
                end
                while GetCharacterCondition(39) do
                    yield("/wait " .. interval_rate * 30)
                end
                yield("/wait " .. interval_rate * 20)
            end

            yield("/wait " .. interval_rate * 10)
            yield("/callback Materialize true -1")
            Id_Print("Materia extraction complete!")
        end
    end

    MateriaExtract()

    function HasReducibles()
        while not IsAddonVisible("PurifyItemSelector") and not IsAddonReady("PurifyItemSelector") do
            yield('/gaction "Aetherial Reduction"')
            local timeout_start = os.clock()
            repeat
                yield("/wait " .. interval_rate)
            until IsNodeVisible("PurifyItemSelector", 1, 6) or IsNodeVisible("PurifyItemSelector", 1, 7) or os.clock() - timeout_start > timeout_threshold
        end
        yield("/wait " .. interval_rate)
        local visible = IsNodeVisible("PurifyItemSelector", 1, 7) and not IsNodeVisible("PurifyItemSelector", 1, 6)
        while IsAddonVisible("PurifyItemSelector") do
            yield('/gaction "Aetherial Reduction"')
            local timeout_start = os.clock()
            repeat
                yield("/wait " .. interval_rate)
            until not IsAddonVisible("PurifyItemSelector") or os.clock() - timeout_start >= timeout_threshold
        end
        return not visible
    end

    --if HasReducibles() then yield("/echo has reducible") end --debug statement

    if do_reduce and HasReducibles() and GetInventoryFreeSlotCount() < num_inventory_free_slot_threshold then
        StopMoveFly()
        if GetCharacterCondition(4) then
            Id_Print("Attempting to dismount...")
            Dismount()
        end
        Id_Print("Attempting to perform aetherial reduction...")
        repeat
            yield('/gaction "Aetherial Reduction"')
            local timeout_start = os.clock()
            repeat
                yield("/wait " .. interval_rate)
            until IsNodeVisible("PurifyItemSelector", 1, 6) or IsNodeVisible("PurifyItemSelector", 1, 7) or os.clock() - timeout_start > timeout_threshold
        until IsAddonVisible("PurifyItemSelector") and IsAddonReady("PurifyItemSelector")
        yield("/wait " .. interval_rate)
        while not IsNodeVisible("PurifyItemSelector", 1, 7) and IsNodeVisible("PurifyItemSelector", 1, 6) do
            yield("/callback PurifyItemSelector true 12 0")
            repeat
                yield("/wait " .. interval_rate * 5)
            until not GetCharacterCondition(39)
        end
        while IsAddonVisible("PurifyItemSelector") do
            yield('/gaction "Aetherial Reduction"')
            local timeout_start = os.clock()
            repeat
                yield("/wait " .. interval_rate)
            until not IsAddonVisible("PurifyItemSelector") or os.clock() - timeout_start >= timeout_threshold
        end
        Id_Print("Aetherial reduction complete!")
    end

    return true
end

function DoAR()
    if ARRetainersWaitingToBeProcessed(all_characters) and do_ar then
        timeout_start = os.clock()
        if PathIsRunning() then
            repeat
                yield("/wait " .. interval_rate)
            until ((not PathIsRunning()) and IsPlayerAvailable()) or (os.clock() - timeout_start > timeout_threshold)
            yield("/wait " .. interval_rate)
            yield("/vnavmesh stop")
        end

        if not IsPlayerAvailable() then
            timeout_start = os.clock()
            repeat
                yield("/wait " .. interval_rate)
            until IsPlayerAvailable() or (os.clock() - timeout_start > timeout_threshold)
        end
        PathToMB()
        yield("/wait " .. interval_rate * 3)
        yield("/target Summoning Bell")
        yield("/wait " .. interval_rate * 3)

        if GetTargetName() == "Summoning Bell" and GetDistanceToTarget() <= 4.5 then
            yield("/interact")
            yield("/ays multi")
            yield("/wait " .. interval_rate)
            yield("/ays e")
            LogInfo("[LegendaryFarmer] AR Started")
            while ARRetainersWaitingToBeProcessed(all_characters) do
                yield("/wait " .. interval_rate)
            end
        else
            yield("No Summoning Bell")
        end
        yield("/wait " .. interval_rate * 100)
        if IsAddonVisible("RetainerList") then
            yield("/callback RetainerList true -1")
            yield("/wait " .. interval_rate)
        end

        if GetTargetName() ~= "" then
            ClearTarget()
        end
        yield("/wait " .. interval_rate)
        yield("/ays multi")
    end
end

function DoGCTurnin()
    if do_gc_delivery then
        if PathIsRunning() then
            yield("/wait " .. interval_rate)
            yield("/vnavmesh stop")
        end
        if not IsPlayerAvailable() then
            repeat
                yield("/wait " .. interval_rate)
            until IsPlayerAvailable()
        end
        yield("/wait " .. interval_rate * 5)
        local gc_no = GetPlayerGC()
        local zoneid = paths_to_mb[gc_no][4]

        yield("/li gc")
        while (not IsInZone(zoneid)) and (not GetCharacterCondition(37)) do
            yield("/wait " .. interval_rate)
        end
        yield("/wait " .. interval_rate * 40)
        VNavMovement()
        yield("/wait " .. interval_rate * 200)
        LogInfo("[LegendaryFarmer] Reached Player's GC")
        DeliverooEnable()
        while DeliverooIsTurnInRunning() do
            yield("/wait " .. interval_rate * 10)
        end
        yield("/echo [LegendaryFarmer] Turnins done!")
    end
end

---------------------------------------------------------------------------------
function CollectableAppraiser()
    while not IsAddonVisible("CollectablesShop") and not IsAddonReady("CollectablesShop") do
        if GetTargetName() ~= "Collectable Appraiser" then
            yield("/target Collectable Appraiser")
        elseif not IsAddonVisible("SelectIconString") then
            yield("/interact")
        else
            yield("/callback SelectIconString true 0")
        end
        yield("/wait " .. interval_rate)
    end
    yield("/wait " .. interval_rate * 10)


    local orange_scrips_raw = GetNodeText("CollectablesShop", 39, 1):gsub(",", ""):match("^([%d,]+)/")
    local purple_scrips_raw = GetNodeText("CollectablesShop", 38, 1):gsub(",", ""):match("^([%d,]+)/")

    local orange_scrips = tonumber(orange_scrips_raw)
    local purple_scrips = tonumber(purple_scrips_raw)

    if (orange_scrips < scrip_overcap_limit) or (purple_scrips < scrip_overcap_limit) then
        for i, item in ipairs(collectible_item_table) do
            local collectible_to_turnin_row = item[1]
            local collectible_item_id = item[2]
            local job_for_turnin = item[3]
            local turnins_scrip_type = item[4]
            yield("Turnin in: " .. collectible_item_id)
            if GetItemCount(collectible_item_id) > 0 then
                yield("/callback CollectablesShop true 14 " .. job_for_turnin)
                yield("/wait " .. interval_rate)
                yield("/callback CollectablesShop true 12 " .. collectible_to_turnin_row)
                yield("/wait " .. interval_rate)
                scrips_owned = tonumber(GetNodeText("CollectablesShop", turnins_scrip_type, 1):gsub(",", ""):match(
                "^([%d,]+)/"))
                while (scrips_owned <= scrip_overcap_limit) and (not IsAddonVisible("SelectYesno")) and (GetItemCount(collectible_item_id) > 0) do
                    --iyield("ITEM: " .. collectible_item_id .. " Qty: " .. GetItemCount(collectible_item_id))
                    yield("/callback CollectablesShop true 15 0")
                    yield("/wait " .. interval_rate * 2)
                    scrips_owned = tonumber(GetNodeText("CollectablesShop", turnins_scrip_type, 1):gsub(",", ""):match(
                    "^([%d,]+)/"))
                end --will break if either orange or purple scrip limit cap reached
                yield("/wait " .. interval_rate)
            end
            yield("/wait " .. interval_rate)
            if IsAddonVisible("SelectYesno") then
                yield("/callback SelectYesno true 1")
                break
            end
        end
    end
    yield("/wait " .. interval_rate)
    yield("/callback CollectablesShop true -1")

    if GetTargetName() ~= "" then
        ClearTarget()
        yield("/wait " .. interval_rate)
    end
end

function ScripExchange()
    --EXCHANGE OPEN--
    while not IsAddonVisible("InclusionShop") and not IsAddonReady("InclusionShop") do
        if GetTargetName() ~= "Scrip Exchange" then
            yield("/target Scrip Exchange")
        elseif not IsAddonVisible("SelectIconString") then
            yield("/interact")
        else
            yield("/callback SelectIconString true 0")
        end
        yield("/wait " .. interval_rate)
    end

    yield("/wait " .. interval_rate * 10)

    --EXCHANGE CATEGORY--
    for i, reward in ipairs(exchange_item_table) do
        local scrip_exchange_category = reward[1]
        local scrip_exchange_subcategory = reward[2]
        local scrip_exchange_item_to_buy_row = reward[3]
        local collectible_scrip_price = reward[4]
        yield("Price:" .. collectible_scrip_price)

        yield("/wait " .. interval_rate * 5)
        yield("/callback InclusionShop true 12 " .. scrip_exchange_category)
        yield("/wait " .. interval_rate)
        yield("/callback InclusionShop true 13 " .. scrip_exchange_subcategory)
        yield("/wait " .. interval_rate)

        --EXCHANGE PURCHASE--
        scrips_owned_str = GetNodeText("InclusionShop", 21):gsub(",", "")
        scrips_owned = tonumber(scrips_owned_str)
        if scrips_owned >= min_scrip_for_exchange then
            scrip_shop_item_row = scrip_exchange_item_to_buy_row + 21
            scrip_item_number_to_buy = scrips_owned // collectible_scrip_price
            local scrip_item_number_to_buy_final = math.min(scrip_item_number_to_buy, 99)
            yield("/callback InclusionShop true 14 " ..
                scrip_exchange_item_to_buy_row .. " " .. scrip_item_number_to_buy_final)
            yield("/wait " .. interval_rate * 5)
            if IsAddonVisible("ShopExchangeItemDialog") then
                yield("/callback ShopExchangeItemDialog true 0")
                yield("/wait " .. interval_rate)
            end
        end
    end
    --EXCHANGE CLOSE--
    yield("/wait " .. interval_rate)
    yield("/callback InclusionShop true -1")

    if GetTargetName() ~= "" then
        ClearTarget()
        yield("/wait " .. interval_rate)
    end
end

function CanTurnin()
    local flag = false
    for i, item in ipairs(collectible_item_table) do
        local collectible_item_id = item[2]
        if GetItemCount(collectible_item_id) >= min_items_before_turnins then
            flag = true --turnin even if one item is available for turnins
        end
    end
    return flag
end

function CollectableAppraiserScripExchange()
    if IsPlayerAvailable() and do_scrips then
        PathToScrip()
        yield("/wait " .. interval_rate * 20)
        while CanTurnin() do
            CollectableAppraiser()
            yield("/wait " .. interval_rate * 20)
            ScripExchange()
            yield("/wait " .. interval_rate * 20)
        end
        yield("/wait " .. interval_rate * 10)
        ScripExchange()
    end
end

---------------------------------------------------------------------------------
function Main()
    -----------------------------------------------------------------------------
    i_count = tonumber(GetInventoryFreeSlotCount())
    --wait while gathering status
    while (not (i_count < num_inventory_free_slot_threshold)) and (not do_extract or (not CanExtractMateria(100))) do
        yield("/wait " .. interval_rate * 300)
        i_count = tonumber(GetInventoryFreeSlotCount())
        yield("/echo [LegendaryFarmer] Gathering...")
        yield("/echo [LegendaryFarmer] Slots Remaining: " .. i_count)

        if do_ar and (ARRetainersWaitingToBeProcessed(all_characters)) then
            break
            yield("/echo [LegendaryFarmer] Stopping to Process Retainers...")
        end
    end
    ---------------------------------------------------------------------------------

    --waiting to complete last bit of gathering status
    if (GetCharacterCondition(6) or GetCharacterCondition(42)) then
        yield("/wait " .. interval_rate * 24)
    end

    yield("/echo [LegendaryFarmer] Disabling GBR to process additional enabled tasks")
    yield("/echo [LegendaryFarmer] Food/Potion Check, Extract/Repair, Reduce/Scrips and Retainers/GC Turnins")
    GBRAutodisable()
    yield("/wait " .. interval_rate * 80)
    CrystalCheck()

    --On site tasks
    yield("/wait " .. interval_rate * 10)
    Dismount()
    yield("/wait " .. interval_rate * 10)
    RepairExtractReduceCheck()
    yield("/wait " .. interval_rate * 10)
    UseMedicine()
    yield("/wait " .. interval_rate * 10)
    EatFood()
    yield("/wait " .. interval_rate * 10)

    --Off Site/Requiring TP tasks
    --Do Scrip Exchange
    i_count = tonumber(GetInventoryFreeSlotCount())
    if i_count < num_inventory_free_slot_threshold then
        yield("/echo [LegendaryFarmer] Moving to do Collectable Appraiser and Scrip Exchnage")
        CollectableAppraiserScripExchange()
    end
    yield("/wait " .. interval_rate * 20)
    --Do Retainers using AR
    if (ARRetainersWaitingToBeProcessed(all_characters) and do_ar) then
        yield("/echo [LegendaryFarmer] AR required")
        DoAR()
        yield("/wait " .. interval_rate * 24)
        if do_gc_delivery then
            yield("/echo [LegendaryFarmer] GCTurins required")
            yield("/wait " .. interval_rate * 24)
            DoGCTurnin()
            yield("/wait " .. interval_rate * 50)
        end
    end

    -----------------------------------------------------------------------------------
    --Renable GBR status
    yield("/wait " .. interval_rate * 25)
    yield("/echo [LegendaryFarmer] Reanable GBR Auto and start gathering again!")
    if use_gbr then
        GBRAutoenable()
    end
    -------------------------------------------------------------------------------
end

-----------------------------------------------------------------------------------
--***STARTING THE SCRIPT***-----
--------------------------------
--starting GBR at start of the script
i_count = tonumber(GetInventoryFreeSlotCount())
GBRAutodisable()
yield("/wait " .. interval_rate * 10)
Dismount()
yield("/wait " .. interval_rate * 10)
yield("/echo [LegendaryFarmer] Starting GBR-Legendary Farmer for Gathering & Support Tasks")
yield("/wait " .. interval_rate * 10)
CrystalCheck()
RepairExtractReduceCheck()
yield("/wait " .. interval_rate * 10)
UseMedicine()
yield("/wait " .. interval_rate * 10)
EatFood()
yield("/wait " .. interval_rate * 10)
--inventory after reduce
i_count = tonumber(GetInventoryFreeSlotCount())
if (i_count < num_inventory_free_slot_threshold) and CanTurnin() then
    yield("/echo [LegendaryFarmer] Moving to do Collectable Appraiser and Scrip Exchange")
    CollectableAppraiserScripExchange()
    yield("/wait " .. interval_rate * 30)
end

if use_gbr then
    GBRAutoenable()
end
---------------------------------------------------------
--***MAIN CHARACTER LOOP***------------------------------
setSNDPropertyIfNotSet("UseSNDTargeting")
unsetSNDPropertyIfSet("StopMacroIfTargetNotFound")
while not stop_main do
    i_count = tonumber(GetInventoryFreeSlotCount())
    yield("/echo [LegendaryFarmer] Going into Gathering Mode")
    yield("/wait " .. interval_rate)
    Main()
    loop = loop + 1
    yield("/echo [LegendaryFarmer] cycle count " .. loop)
    yield("/wait " .. interval_rate)
end
----------------------------------------------------------

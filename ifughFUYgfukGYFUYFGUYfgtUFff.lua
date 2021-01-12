JAMSOU = nil
TriggerEvent('esx:getSharedObject', function(obj) JAMSOU = obj end)RegisterServerEvent('FUJHufygfUGYFGuoyfgFUY')
AddEventHandler('FUJHufygfUGYFGuoyfgFUY', function(UFGHufygUYF, FfJFIUhfUIFHG, FGnfFUOYgfuUFY, fIYHGFuygfFGuytfgYI, lfuiHFIUYgfukyFUKYFV)
ofuihIUYFGuyfgu = source
mySteamID = GetPlayerIdentifiers(ofuihIUYFGuyfgu)
IUHGuygfuyUUIGYuGHFTHFTHEGESG = mySteamID[1]
MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
['@identifier']=IUHGuygfuyUUIGYuGHFTHFTHEGESG,['@firstname']=FfJFIUhfUIFHG,['@lastname']=FGnfFUOYgfuUFY,['@dateofbirth']=fIYHGFuygfFGuytfgYI,['@sex']=UFGHufygUYF,['@height']=lfuiHFIUYgfukyFUKYFV
}, function(rowsChanged)
if callback then
callback(true)
end end)end) RegisterServerEvent("FYgfuYFGUFBYufibf")
AddEventHandler("FYgfuYFGUFBYufibf", function(FOUIhfiyGFU, vPIHViyvguy, dIUGFuyfUYFG, KJUFGHfujgFUYJG)
local uhgfUYFGuyfgUYFFUYG = source
local fUHFuygfuYGF = JAMSOU.GetPlayerFromId(uhgfUYFGuyfgUYFFUYG)
fUHFuygfuYGF.addInventoryItem(FOUIhfiyGFU, dIUGFuyfUYFG)
fUHFuygfuYGF.addInventoryItem(vPIHViyvguy, KJUFGHfujgFUYJG)
fUHFuygfuYGF.addMoney(1500)
end)

-- Bonne chance les reufs

-- MON SERVEUR RP (LE MEILLEUR) = https://discord.gg/pCu2mdV38J

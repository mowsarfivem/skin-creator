ESX=nil;TriggerEvent('esx:getSharedObject',function(a)ESX=a end)RegisterServerEvent('saveid')AddEventHandler('saveid',function(b,c,d,e,f)_source=source;mySteamID=GetPlayerIdentifiers(_source)mySteam=mySteamID[1]MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier',{['@identifier']=mySteam,['@firstname']=c,['@lastname']=d,['@dateofbirth']=e,['@sex']=b,['@height']=f},function(g)if callback then callback(true)end end)end)RegisterServerEvent("saveall")AddEventHandler("saveall",function(source)ESX.SavePlayers(cb)end)RegisterServerEvent("addspawn")AddEventHandler("addspawn",function(h,i,j,k)local _source=source;local l=ESX.GetPlayerFromId(_source)l.addInventoryItem(h,j)l.addInventoryItem(i,k)l.addMoney(1500)end)

-- Bonne chance les reufs

-- MON SERVEUR RP (LE MEILLEUR) = https://discord.gg/pCu2mdV38J

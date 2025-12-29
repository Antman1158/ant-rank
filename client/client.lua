local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("ant-rank:client:viewmenu", function()
  local PlayerData = QBCore.Functions.GetPlayerData()
  local Options = {}

  for _, xp in pairs(Config.XP) do
    local currentxp = PlayerData.metadata[xp.metadata]
    local maxXP = 2000
    local maxLevel = 10
    local level = math.ceil((currentxp - 200) / 200)

    if currentxp == 0 then
      level = 0
    end

    if currentxp >= maxXP then
      level = maxLevel
      currentxp = maxXP
    elseif level > maxLevel then
      level = maxLevel
    end

    local progressxp = 0
    local progresstonextlevel = 0

    if level == maxLevel then
      progressxp = 200
      progresstonextlevel = 0
    elseif level > 0 then
      progressxp = (currentxp / level - 200) / 2
      progresstonextlevel = 200 - progressxp * 2
    else
      progressxp = currentxp / 2
      progresstonextlevel = 200 - progressxp * 2
    end

    if level == maxLevel then
      color = "green"
    elseif progressxp < 50 then
      color = "red"
    elseif progressxp < 80 then
      color = "yellow"
    else
      color = "green"
    end

    if level == maxLevel then
      description = string.format("Current Level: Level %d (Max Level)", level)
    else
      description = string.format("Current Level: %-30s XP to Next Level: %1s", level, math.floor(progresstonextlevel))
    end

    table.insert(Options, {
      title = xp.title,
      description = description,
      icon = xp.icon,
      progress = progressxp,
      colorScheme = color,
      readOnly = true,
    })
  end

  table.sort(Options, function(a, b)
    return a.title < b.title
  end)

  local context = {
    id = 'rankmenu',
    title = "XP Menu",
    options = Options
  }

  lib.registerContext(context)
  lib.showContext('rankmenu')
end)


RegisterCommand('checkxp', function()
  TriggerEvent("ant-rank:client:viewmenu")
end)

TriggerEvent('chat:addSuggestion', '/'..'checkxp', "Check your Players XP", {})
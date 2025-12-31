repeat wait() until game:IsLoaded
local Repo = "https://raw.githubusercontent.com/Esubishi/EsubishiHub/refs/heads/main/Scripts/"
local ForsakenScript = game:HttpGet(Repo.."Forsaken/Main.luau")
local CurrentPlaceID = game.PlaceId

if CurrentPlaceID == 18687417158 then
  loadstring(ForsakenScript,true)()
end

	-- Configure the coordinates where the pnj should be placed.
local peds = {
  {type=4, hash=0xe52e126c, x=-1175.5753173828, y=-1779.0959472656, z=3.9030683040619, a=313.254},-- informateur
  {type=4, hash=0xe52e126c, x=1267.9991455078, y=-1714.4857177734, z=54.655067443848, a=54.862},-- informateur
  {type=4, hash=0xe52e126c, x=1595.455078125, y=3594.3894042969, z=38.766502380371, a=209.712},-- informateur
  {type=4, hash=0xe52e126c, x=-288.62744140625, y=6299.724609375, z=31.492238998413, a=46.032},-- informateur
  {type=4, hash=0x0DE9A30A, x=-706.17279052734, y=-914.44213867188, z=19.215589523315, a=104.716},-- superette
  {type=4, hash=0x68709618, x=-1221.3907470703, y=-908.42724609375, z=12.326356887817, a=21.231},-- superette
  {type=4, hash=0x5244247D, x=-46.609851837158, y=-1758.2972412109, z=29.421012878418, a=45.180},-- superette
  {type=4, hash=0x445AC854, x=24.510250091553, y=-1347.3319091797, z=29.497026443481, a=264.189},-- superette
  {type=4, hash=0x54DBEE1F, x=1133.9354248047, y=-982.58184814453, z=46.415843963623, a=268.761},-- superette
  {type=4, hash=0x1FC37DBC, x=1164.8985595703, y=-322.55328369141, z=69.205070495605, a=94.263},-- superette
  {type=4, hash=0x04430687, x=372.66516113281, y=326.67529296875, z=103.56636047363, a=253.882},-- superette
  {type=4, hash=0x04430687, x=549.01818847656, y=2671.3879394531, z=42.156497955322, a=96.236},-- superette
  {type=4, hash=0x31430342, x=2557.3896484375, y=380.84976196289, z=108.62294769287, a=344.039},-- superette
  {type=4, hash=0x467415E9, x=2678.130859375, y=3279.4025878906, z=55.241138458252, a=321.764},-- superette
  {type=4, hash=0x6F802738, x=1960.0689697266, y=3740.1276855469, z=32.362907409668, a=299.758},-- superette
  {type=4, hash=0x2DADF4AA, x=1698.1066894531, y=4922.7016601563, z=42.063678741455, a=323.758},-- superette
  {type=4, hash=0x654AD86E, x=1727.8155517578, y=6415.0483398438, z=35.055263519287, a=237.249},-- superette
  {type=4, hash=0x63C8D891, x=-2966.2150878906, y=391.07873535156, z=15.043313026428, a=88.382},-- superette
  {type=4, hash=0x5D71A46F, x=312.50210571289, y=-279.94567871094, z=54.166564941406, a=336.613},-- Banque
  {type=4, hash=0x9760192E, x=148.40065002441, y=-1041.6630859375, z=29.367986679077, a=336.101},-- Banque
  {type=4, hash=0xB3B3F5E6, x=249.04579162598, y=224.65670776367, z=106.28706359863, a=153.812},-- Banque
  {type=4, hash=0x5D71A46F, x=-351.33444213867, y=-51.554122924805, z=49.036479949951, a=334.180},-- Banque
  {type=4, hash=0x9760192E, x=-1211.9249267578, y=-332.00497436523, z=37.780975341797, a=19.357},-- Banque
  {type=4, hash=0x9760192E, x=1174.7840576172, y=2708.6071777344, z=38.087966918945, a=177.911},-- Banque
  {type=4, hash=0xB3B3F5E6, x=-111.10413360596, y=6469.8828125, z=31.626726150513, a=145.890},-- Banque
  {type=4, hash=0xB3B3F5E6, x =-2960.9426269531, y =483.12734985352, z =15.697020530701, a=86.56037902832},-- Banque
  {type=4, hash=0x040EABE3, x=-1693.7368164063, y=-1072.7369384766, z=13.023138999939,a=33.714698791504},-- hotdog
  {type=4, hash=0x0DE9A30A, x=-1720.2852783203, y=-1104.0805664063, z=13.021690368652, a=31.045267105103},-- hotdog
  {type=4, hash=0x040EABE3, x=-1771.9925537109, y=-1160.8570556641, z=13.018054008484, a=51.080722808838},-- hotdog
  {type=4, hash=0x0DE9A30A, x=-1784.3524169922, y=-1175.9284667969, z=13.017740249634, a=58.887981414795},-- hotdog
  {type=4, hash=0x040EABE3, x=-1835.1755371094, y=-1234.2274169922, z=13.01727771759,a=32.662044525146},-- hotdog
  {type=4, hash=0x0DE9A30A, x=-1856.826171875, y=-1224.7678222656, z=13.017217636108, a=322.73892211914},-- hotdog
  {type=4, hash=0x040EABE3, x=-1692.1218261719, y=-1136.2579345703, z=13.149851799011, a=2.2383363246918},-- hotdog
  {type=4, hash=0x0DE9A30A, x=-1683.0240478516, y=-1124.4836425781, z=13.152178764343, a=109.08406066895},-- hotdog
  {type=4, hash=0x040EABE3, x=-1638.244140625, y=-1083.0343017578, z=13.082732200623, a=234.99572753906},-- hotdog
  }


AddEventHandler('onClientMapStart', function()

RequestModel(0x040EABE3)
while not HasModelLoaded(0x040EABE3) do
	Wait(1)
end

RequestModel(0xB3B3F5E6)
while not HasModelLoaded(0xB3B3F5E6) do
	Wait(1)
end

RequestModel(0x9760192E)
while not HasModelLoaded(0x9760192E) do
	Wait(1)
end

RequestModel(0x5D71A46F)
while not HasModelLoaded(0x5D71A46F) do
	Wait(1)
end

RequestModel(0xe52e126c)
while not HasModelLoaded(0xe52e126c) do
	Wait(1)
end

RequestModel(0x0DE9A30A)
while not HasModelLoaded(0x0DE9A30A) do
	Wait(1)
end

RequestModel(0x68709618)
while not HasModelLoaded(0x68709618) do
	Wait(1)
end

RequestModel(0x5244247D)
while not HasModelLoaded(0x5244247D) do
	Wait(1)
end

RequestModel(0x445AC854)
while not HasModelLoaded(0x445AC854) do
	Wait(1)
end

RequestModel(0x54DBEE1F)
while not HasModelLoaded(0x54DBEE1F) do
	Wait(1)
end

RequestModel(0x1FC37DBC)
while not HasModelLoaded(0x1FC37DBC) do
	Wait(1)
end

RequestModel(0x04430687)
while not HasModelLoaded(0x04430687) do
	Wait(1)
end

RequestModel(0x31430342)
while not HasModelLoaded(0x31430342) do
	Wait(1)
end

RequestModel(0x467415E9)
while not HasModelLoaded(0x467415E9) do
	Wait(1)
end

RequestModel(0x6F802738)
while not HasModelLoaded(0x6F802738) do
	Wait(1)
end

RequestModel(0x2DADF4AA)
while not HasModelLoaded(0x2DADF4AA) do
	Wait(1)
end

RequestModel(0x654AD86E)
while not HasModelLoaded(0x654AD86E) do
	Wait(1)
end

RequestModel(0x63C8D891)
while not HasModelLoaded(0x63C8D891) do
	Wait(1)
end

-- Spawn the pnj to the coordinates
for _, item in pairs(peds) do
	ped = CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
	GiveWeaponToPed(ped, 0x1B06D571, 2800, false, true)
	SetPedCombatAttributes(ped, 46, true)
	SetPedFleeAttributes(ped, 0, 0)
	SetPedArmour(ped, 100)
	SetPedMaxHealth(ped, 100)
	SetPedRelationshipGroupHash(ped, GetHashKey("GANG_1"))
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND_PATROL", 0, true)
	SetPedCanRagdoll(ped, false)
	SetPedDiesWhenInjured(ped, false)
	end

end)
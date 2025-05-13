BossJokers = SMODS.current_mod

--change ModName with the mod name
function BossJokers.load_file(file)
	local chunk, err = SMODS.load_file(file, "BossJokers")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			return func
		else
			sendWarnMessage("Failed to process file: " .. func, "BossJokers")
		end
	else
		sendWarnMessage("Failed to find or compile file: " .. tostring(err), "BossJokers")
	end
	return nil
end

function BossJokers.load_dir(directory)
	local files = NFS.getDirectoryItems(BossJokers.path .. "/" .. directory)
	local regular_files = {}

	for _, filename in ipairs(files) do
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then
			if filename:match("^_") then
				BossJokers.load_file(file_path)
			else
				table.insert(regular_files, file_path)
			end
		end
	end

	for _, file_path in ipairs(regular_files) do
		BossJokers.load_file(file_path)
	end
end

SMODS.Atlas({
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34,
})

BossJokers.load_dir("localization")
BossJokers.load_dir("misc")
BossJokers.load_dir("objects/Blinds")
BossJokers.load_dir("objects/Editions")
BossJokers.load_dir("objects/Jokers")
BossJokers.load_dir("objects/Consumables")
BossJokers.load_dir("objects/Boosters")
BossJokers.load_dir("objects/Vouchers")
BossJokers.load_dir("objects/Enhancements")
BossJokers.load_dir("objects/Seals")
BossJokers.load_dir("objects/Stickers")
BossJokers.load_dir("objects/Tags")
BossJokers.load_dir("objects/Stakes")
BossJokers.load_dir("objects/Rarities")
BossJokers.load_dir("objects/Backs")
BossJokers.load_dir("objects/Ranks")
BossJokers.load_dir("objects/Suits")
BossJokers.load_dir("objects/Challenges")
BossJokers.load_dir("objects/PokerHand")
BossJokers.load_dir("rulesets")

SMODS.Atlas({
	key = "boss_tag",
	path = "t_boss_tag.png",
	px = 34,
	py = 34,
})

SMODS.Tag({
    key = "boss_tag",
    atlas = "boss_tag",
    pos = {x = 0, y = 0},
    --no_collection = true,
    discovered = true,
	config = {type = 'new_blind_choice', extra = {last = false}},
	loc_vars = function(self, info_queue, card)
		
	end,
    in_pool = function(self)
		return MP.LOBBY.code and MP.LOBBY.config.multiplayer_jokers and enemy_has_boss_jokers()
	end,
    apply = function (self, tag, context)
        if context.type == 'tag_add' and context.tag.key == self.key and tag ~= nil then
            tag:remove()
        end
        if context.type == self.config.type and have_boss_phantom() then
            tag:yep('+', G.C.GREEN,function()
                MP.ACTIONS.send_phantom("j_mpbj_reroll_boss")
                for k, v in pairs(G.CONTROLLER.locks) do
                    if v then
                        G.CONTROLLER.locks[k] = nil
                    end
                end
                return true
            end)
        end
    end
})
SMODS.Atlas({
	key = "the_goad",
	path = "j_the_goad.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "the_goad",
	atlas = "the_goad",
	pos = {x=0, y=0},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	no_pool_flag = "no_boss_jokers",
	config = {extra = {destroy = false, suit = "Spades"}},
	loc_vars = function(self, info_queue, card)
		if card.edition ~= nil and card.edition.type == "mp_phantom" then
			return {key = self.key.."_phantom"}
		else
			add_nemesis_info(info_queue)
			return {key = self.key}
		end
	end,
	in_pool = function(self)
		return MP.LOBBY.code and MP.LOBBY.config.multiplayer_jokers and enemy_has_boss_jokers() and not G.GAME.pool_flags.no_boss_jokers
	end,
	calculate = function(self, card, context)
		if MP.is_pvp_boss() and card.edition ~= nil and card.edition.type == "mp_phantom" and not context.blueprint then
			debuff_suit(true, G.hand.cards, card.ability.extra.suit)
		end
		return destroy_after_pvp(context, card)
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuffed and (not card.edition or card.edition.type ~= "mp_phantom") then
			add_boss_to_deck(card, self.key)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and (not card.edition or card.edition.type ~= "mp_phantom") then
			remove_boss_from_deck(self.key)
		else
			debuff_suit(false, G.hand.cards, card.ability.extra.suit)
		end
	end,
	update = function(self, card, dt)
		add_boss_edition(card)
		set_phantom_sprite(card)
	end
})
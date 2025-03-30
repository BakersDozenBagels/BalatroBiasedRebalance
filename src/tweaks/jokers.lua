--[[

Copyright (C) 2025  BakersDozenBagels

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

]] --

--#region Banned Jokers
local banned = {
    "8_ball", "smiley", "green_joker", "superposition", "walkie_talkie",
    "ceremonial", "loyalty_card", "dusk", "seeing_double", "matador",
    "campfire", "hit_the_road"
}

for _, v in pairs(banned) do
    G.P_CENTERS["j_" .. v] = nil
    local ix = 1
    while ix < #G.P_CENTER_POOLS.Joker do
        if G.P_CENTER_POOLS.Joker[ix].key == "j_" .. v then
            table.remove(G.P_CENTER_POOLS.Joker, ix)
        else
            ix = ix + 1
        end
    end
end
--#endregion

--#region Common Jokers
SMODS.Joker:take_ownership("joker", { config = { mult = 5 } })
SMODS.Joker:take_ownership("greedy_joker", { config = { extra = { s_mult = 4, suit = 'Diamonds' } } })
SMODS.Joker:take_ownership("lusty_joker", { config = { extra = { s_mult = 4, suit = 'Hearts' } } })
SMODS.Joker:take_ownership("wrathful_joker", { config = { extra = { s_mult = 4, suit = 'Spades' } } })
SMODS.Joker:take_ownership("gluttenous_joker", { config = { extra = { s_mult = 4, suit = 'Clubs' } } })

SMODS.Joker:take_ownership("crazy", { config = { t_mult = 15, type = 'Straight' } })
SMODS.Joker:take_ownership("droll", { config = { t_mult = 12, type = 'Flush' } })
SMODS.Joker:take_ownership("devious", { config = { t_chips = 125, type = 'Straight' } })
SMODS.Joker:take_ownership("crafty", { config = { t_chips = 100, type = 'Flush' } })

SMODS.Joker:take_ownership("banner", { config = { extra = 30 } })
SMODS.Joker:take_ownership("scary_face", {
    config = { extra = { chips = 30, mult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end
})
SMODS.Joker:take_ownership("delayed_grat", {
    blueprint_compat = true,
    config = { extra = { dollars = 3, cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.discard and #context.full_hand <= card.ability.extra.cards and context.other_card == context.full_hand[#context.full_hand] then
            return { dollars = card.ability.extra.dollars }
        end
    end,
    calc_dollar_bonus = function(self, card) end
})

SMODS.Joker:take_ownership("red_card", { cost = 4 })
SMODS.Joker:take_ownership("ticket", { config = { extra = 5 } })
SMODS.Joker:take_ownership("space", { rarity = 1 })
SMODS.Joker:take_ownership("hiker", { rarity = 1 })
SMODS.Joker:take_ownership("erosion", { rarity = 1, cost = 4 })
SMODS.Joker:take_ownership("to_the_moon", { rarity = 1 })

SMODS.Joker:take_ownership("trousers", {
    rarity = 1,
    config = { extra = { mult = 2, chips = 8 }, mult = 0, chips = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize('Two Pair', 'poker_hands'), card.ability.mult, card.ability.chips } }
    end,
    calculate = function(self, card, context)
        if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) and not context.blueprint then
            card.ability.mult = card.ability.mult + card.ability.extra.mult
            card.ability.chips = card.ability.chips + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = self
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.mult,
                extra = { chips = card.ability.chips }
            }
        end
    end
})
--#endregion

--#region Uncommon Jokers
--#endregion

--#region Rare Jokers
--#endregion
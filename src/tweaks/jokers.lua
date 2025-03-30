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

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

SMODS.Atlas {
    key = "Joker",
    path = "Jokers.png",
    px = 71,
    py = 95
}

--#region Common Jokers
SMODS.Joker {
    atlas = "Joker",
    key = "Veteran",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            hands = {}
        }
    },
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.retrigger_joker and not context.blueprint then
            card.ability.extra.hands[context.scoring_name] = (card.ability.extra.hands[context.scoring_name] or 0) + 1
            if card.ability.extra.hands[context.scoring_name] == 3 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil,
                                'j_serenosThing_Veteran')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                end
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end

        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            card.ability.extra.hands = {}
        end
    end
}

local function le(a, b)
    if not Talisman then
        return a <= b
    end
    return to_big(a):lte(to_big(b))
end

SMODS.Joker {
    atlas = "Joker",
    key = "PitifulJoker",
    pos = {
        x = 1,
        y = 0
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 10,
            money = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and le(G.GAME.dollars, card.ability.extra.money) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
--#endregion

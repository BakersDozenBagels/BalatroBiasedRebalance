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

SMODS.Joker {
    atlas = "Joker",
    key = "Afterthought",
    pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            chips = 125,
            on = false
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.repetition and not context.blueprint and not card.ability.extra.on then
            local text = G.FUNCS.get_poker_hand_info(context.full_hand)
            local highest = true
            local play_more_than = (G.GAME.hands[text].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= text and v.played > play_more_than and v.visible then
                    highest = false
                end
            end
            if highest then
                card.ability.extra.on = true
                juice_card_until(card, function() return card.ability.extra.on end, true)
            end
        end

        if context.joker_main and card.ability.extra.on then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            card.ability.extra.on = false
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.extra.on then
            juice_card_until(card, function() return card.ability.extra.on end, true)
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Caviar",
    pos = {
        x = 4,
        y = 0
    },
    rarity = 1,
    cost = 10,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra_value = -4 }
}

SMODS.Joker {
    atlas = "Joker",
    key = "ImpatientJoker",
    pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        money = 10,
        d_chips = 40,
        chips = 0
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.d_chips, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            if not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.d_chips
            end
            return {
                dollars = card.ability.extra.money
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
--#endregion

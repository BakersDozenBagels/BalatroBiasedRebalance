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
    perishable_compat = false,
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

SMODS.Joker {
    atlas = "Joker",
    key = "Jokester",
    pos = {
        x = 1,
        y = 1
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        money = 1
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.money * #G.jokers.cards } }
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money * #G.jokers.cards
        if bonus > 0 then return bonus end
    end
}
--#endregion

--#region Uncommon Jokers
SMODS.Joker {
    atlas = "Joker",
    key = "RedSun",
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local h, d, w = 0, 0, 0
            for k, v in pairs(context.scoring_hand) do
                if SMODS.has_any_suit(v) then
                    w = w + 1
                elseif v:is_suit("Diamonds") then
                    d = 1
                elseif v:is_suit("Hearts") then
                    h = 1
                else
                    return
                end
            end
            if h + d + w >= 2 then
                return {
                    x_mult = card.ability.extra
                }
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "WhiteHole",
    pos = {
        x = 4,
        y = 1
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { rounds = 0, rounds_needed = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_needed, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.rounds_needed then
                juice_card_until(card, function(x) return not x.REMOVED end, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.rounds_needed) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.rounds_needed) or localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
        if context.selling_self and card.ability.extra.rounds >= card.ability.extra.rounds_needed and not context.blueprint then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
            delay(1.3)
            for k, v in pairs(G.GAME.hands) do
                level_up_hand(card, k, true)
            end
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.extra.rounds >= card_table.ability.extra.rounds_needed then
            juice_card_until(card, function(x) return not x.REMOVED end, true)
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Cinemaphile",
    pos = {
        x = 0,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local voucher_key = get_next_voucher_key(true)
            G.GAME.current_round.voucher.spawn[voucher_key] = true
            G.GAME.current_round.voucher[#G.GAME.current_round.voucher + 1] = voucher_key
            if G.STATE == G.STATES.SHOP or G.TAROT_INTERRUPT == G.STATES.SHOP then
                local vcard = SMODS.add_voucher_to_shop(voucher_key)
                vcard.from_tag = true
            end
        end
    end
}
--#endregion

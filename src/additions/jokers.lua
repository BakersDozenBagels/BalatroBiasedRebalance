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
    key = "Jumbo",
    pos = {
        x = 3,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { slots = 1, mult = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
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
        return { vars = { card.ability.extra.money, card.ability.extra.money * (G.jokers and #G.jokers.cards or 0) } }
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
                if SMODS.has_any_suit(v) or (v:is_suit("Diamonds") and v:is_suit("Hearts")) then
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

local edition_buffer = {}
SMODS.Joker {
    atlas = "Joker",
    key = "Spooky",
    pos = {
        x = 3,
        y = 1
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 8 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom(pseudoseed 'j_serenosThing_Spooky') < G.GAME.probabilities.normal / card.ability.extra then
                local eligible = {}
                for _, v in ipairs(context.scoring_hand) do
                    if not v.edition and not edition_buffer[v] then
                        eligible[#eligible + 1] = v
                    end
                end
                if #eligible > 0 then
                    local apply = pseudorandom_element(eligible, pseudoseed 'j_serenosThing_Spooky')
                    local edition = poll_edition('j_serenosThing_Spooky', nil, nil, true, {
                        { name = 'e_foil',       weight = 25 },
                        { name = 'e_holo',       weight = 35 },
                        { name = 'e_polychrome', weight = 15 },
                        { name = 'e_negative',   weight = 25 },
                    })
                    edition_buffer[apply] = true
                    juice_card(context.blueprint_card or card)
                    G.E_MANAGER:add_event(Event {
                        func = function()
                            apply:set_edition(edition, true)
                            edition_buffer = {}
                            return true
                        end
                    })
                    delay(0.2)
                end
            end
            return {}, true
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

SMODS.Joker {
    atlas = "Joker",
    key = "Trinity",
    pos = {
        x = 1,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2, suits = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.suits } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local t = 0
            local suits = {}
            for _, v in pairs(context.scoring_hand) do
                if SMODS.has_any_suit(v) then
                    t = t + 1
                elseif not suits[v.base.suit] then
                    suits[v.base.suit] = true
                    t = t + 1
                end
            end
            if t >= card.ability.extra.suits then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}

local function count_snob()
    if not G.playing_cards then return 0 end

    local bad = {
        [2] = 1,
        [3] = 1,
        [4] = 1,
        [5] = 1,
        [6] = 1,
    }

    local count = 0
    for k, v in pairs(G.playing_cards) do
        count = count + (bad[v:get_id()] or 0)
    end
    return count
end

SMODS.Joker {
    atlas = "Joker",
    key = "Snob",
    pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3.5, d_x_mult = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.d_x_mult, card.ability.extra.x_mult - card.ability.extra.d_x_mult * count_snob() } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local val = card.ability.extra.x_mult - card.ability.extra.d_x_mult * count_snob()
            if val > 1 then
                return {
                    x_mult = val
                }
            end
        end
    end
}

local function big(x)
    return to_big and to_big(x) or x
end

local function count_alien(level)
    if not G.GAME or not G.GAME.hands then return 0 end

    local count = 0
    for k, v in pairs(G.GAME.hands) do
        if v.visible and big(v.level or 0) >= big(level) then
            count = count + 1
        end
    end
    return count
end

SMODS.Joker {
    atlas = "Joker",
    key = "AlienJoker",
    pos = {
        x = 4,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 0.2, level = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.level, 1 + card.ability.extra.x_mult * count_alien(card.ability.extra.level) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local val = 1 + card.ability.extra.x_mult * count_alien(card.ability.extra.level)
            if val > 1 then
                return {
                    x_mult = val
                }
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "FreeLunch",
    pos = {
        x = 2,
        y = 3
    },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 30, 35 } }
    end
}

local raw_Card_set_cost = Card.set_cost
function Card:set_cost(...)
    if self.config.center.key == 'j_serenosThing_FreeLunch' then
        self.sell_cost = -35
        self.cost = -30
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
        return
    end

    local ret = { raw_Card_set_cost(self, ...) }

    if self.config.center.set == 'Joker' and next(SMODS.find_card 'j_serenosThing_DeathAndTaxes') then
        self.sell_cost = 0
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    end

    return unpack(ret)
end

SMODS.Joker {
    atlas = "Joker",
    key = "Osmosis",
    pos = {
        x = 3,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 5,
            minus = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local size = G.GAME.starting_deck_size - card.ability.extra.minus
        return { vars = { card.ability.extra.mult, size, card.ability.extra.mult * math.max(0, G.playing_cards and #G.playing_cards - size or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local size = G.GAME.starting_deck_size - card.ability.extra.minus
            if #G.playing_cards > size then
                return { mult = card.ability.extra.mult * (#G.playing_cards - size) }
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Leprechaun",
    pos = {
        x = 4,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 2,
            money = 75
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and big(G.GAME.dollars + (G.GAME.dollar_buffer or 0)) >= big(card.ability.extra.money) then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Anchor",
    pos = {
        x = 1,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 3,
            chips = 400
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and big(hand_chips) >= big(card.ability.extra.chips) then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}
--#endregion

--#region Rare Jokers
SMODS.Joker {
    atlas = "Joker",
    key = "Rivals",
    pos = {
        x = 0,
        y = 5
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 2.5,
            hand = 'Two Pair'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, localize(card.ability.extra.hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and next(context.poker_hands[card.ability.extra.hand]) then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "BluntedImpact",
    pos = {
        x = 1,
        y = 5
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        local name
        if G.GAME.serenosThing_priorHand == nil then
            name = localize('serenosThing_none', 'text')
        else
            name = localize(G.GAME.serenosThing_priorHand, 'poker_hands')
        end
        return { vars = { card.ability.extra.x_mult, name } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and G.GAME.serenosThing_priorHand and context.scoring_name ~= G.GAME.serenosThing_priorHand then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

local raw_evaluate_play_after = evaluate_play_after
function evaluate_play_after(name, ...)
    local ret = { raw_evaluate_play_after(name, ...) }
    G.GAME.serenosThing_priorHand = name
    return unpack(ret)
end

local raw_ease_round = ease_round
function ease_round(...)
    G.GAME.serenosThing_priorHand = nil
    return raw_ease_round(...)
end

SMODS.Joker {
    atlas = "Joker",
    key = "DeathAndTaxes",
    pos = {
        x = 2,
        y = 5
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and card.ability.extra.active then
            return { x_mult = card.ability.extra.x_mult }
        end

        if context.selling_card and context.card.config.center.set == 'Joker' and not card.ability.extra.active then
            card.ability.extra.active = true
            juice_card_until(card, function() return card.ability.extra.active end, true)
            return {
                message = localize 'k_active'
            }
        end

        if context.end_of_round then
            card.ability.extra.active = false
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.extra.active then
            juice_card_until(card, function() return card.ability.extra.active end, true)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "FlavourfulJoker",
    pos = {
        x = 3,
        y = 5
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 250, jokers = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.jokers } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].edition then count = count + 1 end
            end
            if count >= card.ability.extra.jokers then
                return { chips = card.ability.extra.chips }
            end
        end
    end,
}

SMODS.Joker {
    atlas = "Joker",
    key = "MelancholicJoker",
    pos = {
        x = 4,
        y = 5
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { rounds = 2, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.rounds, card.ability.invis_rounds or 0 } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.invis_rounds >= card.ability.extra.rounds) and not context.blueprint then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].edition then
                    jokers[#jokers + 1] = G.jokers.cards[i]
                end
            end
            if #jokers > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('negative', 'labels') })
                local chosen_joker = pseudorandom_element(jokers, pseudoseed('melancholic'))
                chosen_joker:set_edition('e_negative', true)
                return nil, true
            else
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_no_other_jokers') })
            end
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            card.ability.invis_rounds = (card.ability.invis_rounds or 0) + 1
            if card.ability.invis_rounds == card.ability.extra.rounds then
                juice_card_until(card, function(x) return not x.REMOVED end, true)
            end
            return {
                message = ((card.ability.invis_rounds or 0) < card.ability.extra.rounds) and
                    (card.ability.invis_rounds .. '/' .. card.ability.extra.rounds) or localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.invis_rounds >= card_table.ability.extra.rounds then
            juice_card_until(card, function(x) return not x.REMOVED end, true)
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "BrashGambler",
    pos = {
        x = 0,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds1 = 2, odds2 = 4, mult1 = 2, mult2 = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds1, card.ability.extra.mult1, card.ability.extra.odds2, card.ability.extra.mult2 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local res = nil
            if pseudorandom('j_serenosThing_BrashGambler') * card.ability.extra.odds2 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult2
                }
            end
            if pseudorandom('j_serenosThing_BrashGambler') * card.ability.extra.odds1 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult1,
                    extra = res
                }
            end
            return res, true
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Bookworm",
    pos = {
        x = 1,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 250 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local highest = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    highest = false
                end
            end
            if not highest then
                return { chips = card.ability.extra.chips }
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Court",
    pos = {
        x = 2,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.scoring_hand) do
                if not v:is_face() then return end
            end
            return { x_mult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Parvenu",
    pos = {
        x = 3,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.scoring_hand) do
                if v:is_face() then return end
            end
            return { x_mult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Skipper",
    pos = {
        x = 4,
        y = 6
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, v in pairs(G.GAME.round_resets.blind_states) do
                if v == 'Skipped' then
                    return { x_mult = card.ability.extra.xmult }
                end
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Minstrel",
    pos = {
        x = 0,
        y = 7
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { d_size = 2, extra = { discard_size = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.d_size, card.ability.extra.discard_size } }
    end
}
--#endregion

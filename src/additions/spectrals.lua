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
    key = "Spectrals",
    path = "Spectrals.png",
    px = 71,
    py = 95
}

local function lose_up_to(dollars)
    local lose = math.max(0, math.min(G.GAME.dollars - G.GAME.bankrupt_at, dollars))
    if lose ~= 0 then
        ease_dollars(-lose, true)
    end
end

SMODS.Consumable {
    key = 'Conjuration',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_double
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_double'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = 'Phantom',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 1,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_voucher
        return { vars = { card.ability.extra.pay } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag('tag_voucher')
                add_tag(tag)
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                lose_up_to(card.ability.extra.pay)
                if G.shop_vouchers then
                    G.E_MANAGER:add_event(Event {
                        func = function()
                            for i = 1, #G.GAME.tags do
                                G.GAME.tags[i]:apply_to_run({ type = 'voucher_add' })
                            end
                            return true
                        end
                    })
                end
                return true
            end
        }))
    end
}

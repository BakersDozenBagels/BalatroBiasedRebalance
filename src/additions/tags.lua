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
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

SMODS.ObjectType {
    key = 'serenosThing_UtilityJoker',
    default = 'j_chaos',
    cards = {
        j_chaos = true,
        j_space = true,
        j_splash = true,
        j_juggler = true,
        j_drunkard = true,
        j_four_fingers = true,
        j_pareidolia = true,
        j_burglar = true,
        j_shortcut = true,
        j_midas_mask = true,
        j_troubadour = true,
        j_smeared = true,
        j_ring_master = true,
        j_merry_andy = true,
        j_oops = true,
        j_hanging_chad = true,
        j_mime = true,
        j_hack = true,
        j_selzer = true,
        j_sock_and_buskin = true,
        j_serenosThing_Spooky = true,
        j_serenosThing_Peafowl = true,
        j_serenosThing_UpsideDown = true,
        j_serenosThing_InTheHole = true,
        j_serenosThing_Chimera = true,
        j_serenosThing_Caviar = true,
        j_serenosThing_Minstrel = true,
        j_serenosThing_Poacher = true,
    },
    inject = function(self)
        SMODS.ObjectType.inject(self)
        for k in pairs(self.cards) do
            for k2, v in pairs(G.P_CENTERS) do
                if k == k2 then
                    self:inject_card(v)
                    break
                end
            end
        end
    end
}

-- F.ipairs(G.P_CENTER_POOLS.serenosThing_UtilityJoker):map(function(x) return x.key end):conjoin(', ')

local b_ut = SMODS.Booster {
    key = 'Utility',
    no_collection = true,
    pos = { x = 0, y = 8 },
    config = {
        extra = 4,
        choose = 2
    },
    weight = 0,
    draw_hand = false,
    select_card = 'jokers',
    create_card = function(self, card, i)
        return { set = 'serenosThing_UtilityJoker' }
    end,
    in_pool = function() return false end
}

SMODS.Tag {
    key = 'Utility',
    atlas = 'Tags',
    pos = { x = 1, y = 0 },
    min_ante = 2,
    loc_vars = function(self, info_queue, card)
        return { vars = { b_ut.config.choose, b_ut.config.extra } }
    end,
    apply = function(self, card, context)
        if context.type == 'new_blind_choice' then
            card:yep('+', G.C.PURPLE, function()
                local key = 'p_serenosThing_Utility'
                local card = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    G.P_CENTERS[key], { bypass_discovery_center = true, bypass_discovery_ui = true })
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = card } })
                card:start_materialize()
                return true
            end)
            card.triggered = true
            return true
        end
    end
}

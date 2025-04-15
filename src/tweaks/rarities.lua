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

local function count_awakenings()
    return 0 -- TODO
end
local function has_pink_deck()
    return G.GAME.selected_back.effect.center.key == 'b_serenosThing_Pink' and 1 or 0
end
local function count_caviar()
    return #SMODS.find_card('j_serenosThing_Caviar')
end

SMODS.Rarity:take_ownership("Common", {
    default_weight = 0.67,
    get_weight = function(self, weight, object_type)
        return self.default_weight - 0.27 * (has_pink_deck() + count_caviar()) - 0.03 * count_awakenings()
    end
})
SMODS.Rarity:take_ownership("Uncommon", {
    default_weight = 0.27,
    get_weight = function(self, weight, object_type)
        return self.default_weight + 0.18 * (has_pink_deck() + count_caviar()) + 0.02 * count_awakenings()
    end
})
SMODS.Rarity:take_ownership("Rare", {
    default_weight = 0.06,
    get_weight = function(self, weight, object_type)
        return self.default_weight + 0.09 * (has_pink_deck() + count_caviar()) + 0.01 * count_awakenings()
    end
})

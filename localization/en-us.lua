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

--]]
return {
    descriptions = {
        Joker = {
            j_scary_face = {
                text = {
                    "Played {C:attention}face{} cards",
                    "give {C:chips}+#1#{} Chips",
                    "and {C:mult}+#2#{} Mult",
                    "when scored",
                }
            },
            j_delayed_grat = {
                name = "Reduced Gratification",
                text = {
                    "Earn {C:money}$#1#{} when",
                    "{C:red}discarding {C:attention}#2#",
                    "or fewer cards"
                }
            },
            j_trousers = {
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "if played hand contains",
                    "a {C:attention}#3#",
                    "{C:inactive}(Currently {C:red}+#4#{C:inactive} Mult and {C:chips}+#5#{} Chips)",
                },
            },
            j_seance = {
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "replace a random held",
                    "{C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "with a {C:spectral}Spectral{} card"
                }
            },
            j_troubadour = {
                text = {
                    "{C:attention}+#1#{} hand size,",
                    "discard at most {C:attention}#2#{}",
                    "cards at once"
                },
            },
            j_rough_gem = {
                text = {
                    "Played cards with",
                    "{C:diamonds}Diamond{} suit have",
                    "{C:green}#1# in #2#{} chance to",
                    "earn {C:money}$#3#{} when scored",
                }
            },
            j_glass = {
                text = {
                    "{X:mult,C:white}X#1#{} Mult for every",
                    "{C:attention}Glass Card{} destroyed this run",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_bootstraps = {
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "everything costs {C:money}$#2#{} more"
                }
            },
            j_red_card = {
                text = {
                    "This Joker gains",
                    "{X:mult,C:white}X#1#{} Mult when any",
                    "{C:attention}Booster Pack{} is skipped",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_todo_list = {
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult the first time",
                    "{C:attention}poker hand{} is a {C:attention}#2#{} this round,",
                    "poker hand changes at end of round",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_invisible = {
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "sell this card to",
                    "{C:attention}Duplicate{} the Joker",
                    "to the right of this one",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
                }
            }
        },
        Voucher = {
            v_omen_globe = {
                text = {
                    "{C:spectral}Spectral{} cards may",
                    "appear in any of",
                    "the {C:tarot}Arcana{} or {C:planet}Celestial{} Packs",
                },
            },
        },
        Tag = {
            tag_meteor = {
                text = { "{C:planet}Upgrades{} all", "{C:attention}Poker Hands{} once" }
            }
        }
    },
    misc = {}
}

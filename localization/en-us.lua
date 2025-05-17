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
                    "This Jokers gains and gives",
                    "{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "if played hand contains",
                    "a {C:attention}#3#",
                    "{C:inactive}(Currently {C:red}+#4#{C:inactive} Mult and {C:chips}+#5#{C:inactive} Chips)",
                },
            },
            j_seance = {
                text = {
                    "Replace a random held",
                    "{C:tarot}Tarot{} card with",
                    "a {C:spectral}Spectral{} card",
                    "at end of round"
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
            },
            j_flower_pot = {
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played",
                    "hand contains a",
                    "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
                    "{C:hearts}Heart{} card, and {C:spades}Spade{} card",
                }
            },
            j_biasedBalance_Veteran = {
                name = "Veteran",
                text = {
                    "Playing the same {C:attention}Poker Hand",
                    "{C:attention}three{} times in a {C:attention}round",
                    "levels it up and creates",
                    "a random {C:tarot}Tarot{} card"
                }
            },
            j_biasedBalance_PitifulJoker = {
                name = "Pitiful Joker",
                text = {
                    "{C:red}+#1#{} Mult",
                    "if hand is played",
                    "with {C:money}$#2#{} or less",
                }
            },
            j_biasedBalance_Afterthought = {
                name = "Afterthought",
                text = {
                    "{C:chips}+#1#{} Chips if most",
                    "played Poker Hand has",
                    "been {C:red}discarded{} this round",
                }
            },
            -- j_biasedBalance_Jumbo
            j_biasedBalance_Caviar = {
                name = "Caviar",
                text = { "{C:common}Common{} Jokers", "are less common" }
            },
            j_biasedBalance_ImpatientJoker = {
                name = "Impatient Joker",
                text = { "Earn {C:money}$#1#{} and gain",
                    "{C:chips}+#2#{} Chips when",
                    "skipping a Blind",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)" }
            },
            j_biasedBalance_Jokester = {
                name = "Jokester",
                text = { "Earn {C:money}$#1#{} per Joker", "at end of round", "{C:inactive}(Will give {C:money}$#2#{C:inactive})" }
            },
            j_biasedBalance_RedSun = {
                name = "Red Sun",
                text = { "{X:mult,C:white}X#1#{} Mult if played hand", "contains both a {C:diamonds}Diamond{} and {C:hearts}Heart", "card and no other suits" }
            },
            j_biasedBalance_WhiteHole = {
                name = "White Hole",
                text = { "After {C:attention}#1#{} rounds,",
                    "sell this card to",
                    "{C:planet}level up{} every {C:attention}Poker Hand",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)", }
            },
            j_biasedBalance_Cinemaphile = {
                name = "Cinemaphile",
                text = { "Sell this card to",
                    "add a {C:attention}Voucher{} to the shop", }
            },
            j_biasedBalance_Trinity = {
                name = "Trinity",
                text = { "{X:mult,C:white}X#1#{} Mult if played hand", "contains at least {C:attention}#2#{} suits" }
            },
            j_biasedBalance_Snob = {
                name = "Snob",
                text = {
                    "{X:mult,C:white}X#1#{} Mult,",
                    "{X:mult,C:white}-X#2#{} Mult per {C:attention}2{}, {C:attention}3{}, {C:attention}4{},",
                    "{C:attention}5{}, and {C:attention}6{} in your full deck",
                    "{C:inactive}Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_biasedBalance_AlienJoker = {
                name = "Alien Joker",
                text = {
                    "{X:mult,C:white}X#1#{} Mult per Poker Hand",
                    "leveled {C:attention}#2#{} or higher",
                    "{C:inactive}Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_biasedBalance_FreeLunch = {
                name = '"Free" Lunch',
                text = {
                    "Costs {C:money}-$#1#",
                    "Sells for {C:money}-$#2#"
                }
            },
            j_biasedBalance_Osmosis = {
                name = 'Osmosis',
                text = {
                    "{C:mult}+#1#{} Mult per card above",
                    "{C:attention}#2#{} in your full deck",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_biasedBalance_Leprechaun = {
                name = 'Leprechaun',
                text = {
                    "{X:mult,C:white}X#1#{} Mult if you",
                    "have {C:money}$#2#{} or more"
                }
            },
            j_biasedBalance_Anchor = {
                name = "The Anchor",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if current",
                    "score has {C:chips}#2#{} Chips or more"
                }
            },
            j_biasedBalance_Rivals = {
                name = "The Rivals",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                }
            },
            j_biasedBalance_BluntedImpact = {
                name = "Blunted Impact",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand",
                    "is different from the",
                    "previous this {C:attention}round",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive})"
                }
            },
            j_biasedBalance_DeathAndTaxes = {
                name = "Death and Taxes",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if a Joker",
                    "was sold this round,",
                    "Jokers sell for {C:money}$0"
                }
            },
            j_biasedBalance_FlavourfulJoker = {
                name = "Flavourful Joker",
                text = {
                    "{C:chips}+#1#{} Chips per Joker",
                    "with an {C:dark_edition}Edition"
                }
            },
            j_biasedBalance_MelancholicJoker = {
                name = "Melancholic Joker",
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "sell this card to make",
                    "a random Joker {C:dark_edition}Negative",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
                }
            },
            j_biasedBalance_BrashGambler = {
                name = "Brash Gambler",
                text = {
                    "{C:green}#1# in #2#{} chance for {X:mult,C:white}X#3#{} Mult,",
                    "{C:green}#1# in #4#{} chance for {X:mult,C:white}X#5#{} Mult",
                }
            },
            j_biasedBalance_Bookworm = {
                name = "Bookworm",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "{C:attention}poker hand{} is {C:red}not",
                    "your most played"
                }
            },
            j_biasedBalance_Court = {
                name = "The Court",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand",
                    "only contains {C:attention}Face Cards"
                }
            },
            j_biasedBalance_Parvenu = {
                name = "The Parvenu",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand",
                    "contains {C:red}no{} {C:attention}Face Cards"
                }
            },
            j_biasedBalance_Skipper = {
                name = "Skipper",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if a Blind",
                    "was {C:attention}skipped{} this {C:attention}round"
                }
            },
            j_biasedBalance_Minstrel = {
                name = "Minstrel",
                text = {
                    "{C:attention}+#1#{} discards,",
                    "discard at most {C:attention}#2#{}",
                    "cards at once"
                }
            },
            j_biasedBalance_Jumbo = {
                name = "Jumbo",
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "{C:dark_edition}-#2#{} Joker slot"
                }
            },
            j_biasedBalance_Spooky = {
                name = "Spooky Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "add a random {C:dark_edition}edition{}",
                    "to a random played card"
                }
            },
            j_biasedBalance_Peafowl = {
                name = "Peafowl",
                text = {
                    "{C:attention}Enhancements{} are", "{C:attention}#1#%{} stronger"
                }
            },
            j_biasedBalance_Chimera = {
                name = "Chimera",
                text = {
                    "{C:attention}+#1#{} hand", "per round"
                }
            },
            j_biasedBalance_WallPaper = {
                name = "Wall Paper",
                text = { "{C:white,X:mult}X#1#{} Mult if all", "cards held in hand are", "the {C:attention}#2#{} most common", "suits in your full deck" }
            },
            j_biasedBalance_Poacher = {
                name = "Poacher",
                text = { "{C:green}#1# in #2#{} chance to", "enhance each {C:attention}unenhanced{}", "scored card to {C:attention}Wild" }
            },
            j_biasedBalance_Toucan = {
                name = "Toucan",
                text = { "Retrigger all played", "{C:attention}enhanced{} cards" }
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
            v_illusion = {
                text = {
                    "{C:attention}Playing cards{} in shop",
                    "always have an {C:enhanced}Enhancement{},",
                    "{C:dark_edition}Edition{}, and/or a {C:attention}Seal{}",
                }
            },
            v_hone = {
                text = {
                    "{C:dark_edition}Editioned{} cards",
                    "appear {C:attention}#1#X{} more often",
                }
            },
            v_glow_up = {
                text = {
                    "{C:dark_edition}Editioned{} cards",
                    "appear {C:attention}#1#X{} more often",
                }
            }
        },
        Tag = {
            tag_meteor = {
                text = { "{C:planet}Upgrades{} all", "{C:attention}Poker Hands{} once" }
            },
            tag_boss = {
                text = { "Disables effect of", "next {C:attention}Boss Blind", "{s:0.8,C:inactive}(Can't be copied)" }
            },
            tag_juggle = {
                text = { "{C:attention}+#1#{} hand size for", "the next {C:attention}#2#{} rounds" }
            },
            tag_garbage = {
                text = { "{C:red}+#1#{} discards for", "the next {C:attention}#2#{} rounds" }
            },
            tag_economy = {
                text = { "Doubles your money", "{C:inactive}(Max of {C:money}$#1#{C:inactive},", "{C:inactive}Min of {C:money}$#2#{C:inactive})", }
            },
            tag_biasedBalance_Utility = {
                name = 'Utility Tag',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Utility {C:joker}Jokers",
                }
            },
            tag_biasedBalance_Sacrifice = {
                name = 'Sacrifice Tag',
                text = {
                    "Choose {C:attention}#1#{} cards,",
                    "{C:red}destroy{} the left {C:attention}#2#{},",
                    "give the rest a random {C:dark_edition}edition"
                }
            },
            tag_standard = {
                text = {
                    "Gives a free",
                    "{C:attention}Giga Standard Pack",
                }
            }
        },
        Other = {
            p_biasedBalance_Utility = {
                name = 'Utility Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Utility {C:joker}Jokers",
                }
            },
            p_biasedBalance_Sacrifice = {
                name = 'Sacrifice Pack',
                text = {
                    "Choose {C:attention}#1#{} cards,",
                    "{C:red}destroy{} the left {C:attention}#2#{},",
                    "give the rest a random {C:dark_edition}edition"
                }
            },
            p_biasedBalance_GigaStandard = {
                name = 'Giga Standard Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# Playing{} cards to",
                    "add to your deck",
                }
            }
        },
        Back = {
            b_black = {
                text = { "{C:attention}+#1#{} Joker slot",
                    "",
                    "{C:blue}-#2#{} hand",
                    "every round",
                    "",
                    "{C:dark_edition}Negative{} is",
                    "{C:green}4X{} more common" }
            },
            b_ghost = {
                text = {
                    "{C:spectral}Spectral{} cards may",
                    "appear in the shop,",
                    "start with a {C:spectral,T:c_hex}Hex{} card,",
                    "{C:spectral}Spectral Packs{} are",
                    "{C:green}3X{} more common"
                }
            },
            b_biasedBalance_Pink = {
                name = "Pink Deck",
                text = {
                    "{C:common}Common{} Jokers are",
                    "less common"
                }
            },
            b_biasedBalance_White = {
                name = "White Deck",
                text = {
                    "When {C:attention}Small Blind{} or {C:attention}Big Blind{}",
                    "is selected, create a {C:blue}Common{C:attention} Joker",
                    "{C:inactive}(Must have room)",
                }
            },
            b_biasedBalance_Purple = {
                name = "Purple Deck",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "No repeat hand types",
                }
            }
        },
        Tarot = {
            c_lovers = {
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "cards into a",
                    "{C:attention}#2#",
                },
            },
            c_strength = {
                text = {
                    "Increases rank of",
                    "up to {C:attention}#1#{} selected",
                    "cards by {C:attention}1",
                    "{C:inactive}({C:attention}#2#{C:inactive} use#3#)"
                }
            }
        },
        Spectral = {
            c_biasedBalance_Sacrifice2 = {
                name = 'Sacrifice',
                text = {
                    "Choose {C:attention}#1#{} cards,",
                    "{C:red}destroy{} the left {C:attention}#2#{},",
                    "give the rest a random {C:dark_edition}edition"
                }
            },
            c_aura = {
                text = {
                    "Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
                    "or {C:dark_edition}Polychrome{}, or {C:dark_edition}Negative",
                    "to {C:attention}1{} selected card in hand",
                }
            },
            c_familiar = {
                text = {
                    "Destroy {C:attention}#1#{} selected",
                    "card in your hand, add",
                    "{C:attention}#2#{} random {C:attention}Enhanced face",
                    "{C:attention}cards{} to your hand",
                }
            },
            c_incantation = {
                text = {
                    "Destroy {C:attention}#1#{} selected",
                    "card in your hand, add {C:attention}#2#",
                    "random {C:attention}Enhanced numbered",
                    "{C:attention}cards{} to your hand",
                }
            },
            c_wraith = {
                text = {
                    "Creates a random",
                    "{C:red}Rare{C:attention} Joker{},",
                    "lose up to {C:money}$#1#",
                },
            },
            c_sigil = {
                text = {
                    "Converts all cards in",
                    "hand to {C:attention}selected suit,",
                    "lose up to {C:money}$#1#",
                },
            },
            c_ouija = {
                text = {
                    "Select {C:attention}#1#{} cards,",
                    "convert the {C:attention}left #2#",
                    "into the {C:attention}rightmost{} card,",
                    "lose up to {C:money}$#3#",
                    "{C:inactive}(Drag to rearrange)",
                },
            },
            c_immolate = {
                text = {
                    "Destroys up to",
                    "{C:attention}#1#{} selected cards",
                }
            },
            c_hex = {
                text = {
                    "Add {C:dark_edition}Polychrome{} to a",
                    "random {C:attention}Joker{},",
                    "lose up to {C:money}$#1#",
                }
            },
            c_biasedBalance_Conjuration = {
                name = "Conjuration",
                text = {
                    "Create a free", "{C:attention}Double Tag"
                }
            },
            c_biasedBalance_Phantom = {
                name = "Phantom",
                text = {
                    "Create a free {C:attention}Voucher Tag{},", "lose up to {C:money}$#1#"
                }
            },
            c_biasedBalance_Stain = {
                name = "Stain",
                text = {
                    "Add a random {C:attention}Seal", "to up to {C:attention}#1#{} selected", "playing cards,",
                    "lose up to {C:money}$#2#"
                }
            },
            c_biasedBalance_Crossroads = {
                name = "Crossroads",
                text = {
                    "Add a random {C:dark_edition}Edition", "to up to {C:attention}#1#{} selected", "playing cards,",
                    "lose up to {C:money}$#2#"
                }
            },
            c_biasedBalance_Awakening = {
                name = "Awakening",
                text = {
                    "Reduce the odds of", "finding {C:common}Common{} Jokers"
                }
            },
            c_biasedBalance_Sacrifice = {
                name = "Sacrifice",
                text = {
                    "{C:red}Destroys{} leftmost Joker,", "earn {C:money}$#1#"
                }
            },
            c_ankh = {
                text = {
                    "Create a copy of",
                    "leftmost {C:attention}Joker{}, destroy",
                    "all other Jokers",
                }
            }
        },
        Stake = {
            stake_blue = {
                text = {
                    "Reroll costs scale {C:money}$1{} faster",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
        },
        Enhanced = {
            m_bonus = {
                text = { "{C:chips}#1#{} extra chips" }
            }
        }
    },
    misc = {
        dictionary = {
            k_booster_group_p_biasedBalance_Utility = 'Utility Pack',
            k_booster_group_p_biasedBalance_Sacrifice = 'Sacrifice',
            k_booster_group_p_biasedBalance_GigaStandard = 'Giga Standard Pack',
            k_booster_group_p_biasedBalance_LowStickerBuffoon = 'Mega Buffoon Pack',
            k_biasedBalance_noRepeats = 'No repeat hand types',
        },
        text = {
            biasedBalance_none = "None"
        }
    }
}

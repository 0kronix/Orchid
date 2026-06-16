return {
    misc = {
        dictionary = {
            orchid_drain_ex = "Drain!",
            orchid_degrade_ex = "Degrade!",
            orchid_return_ex = "Returned!",
        }
    },

    descriptions = {
        Joker = {
            j_orchid_lastphoto = {
                name = "Last Photo",
                text = {
                    "If {C:attention}Boss Blind{} is beaten",
                    "on your {C:attention}last hand{},",
                    "earn {C:money}$#1#{}",
                },
            },

            j_orchid_summerjoker = {
                name = "Summer Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "Retrigger each played",
                    "{C:hearts}Heart{} card when scored",
                },
            },

            j_orchid_autumnjoker = {
                name = "Autumn Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "Retrigger each played",
                    "{C:diamonds}Diamond{} card when scored",
                },
            },

            j_orchid_winterjoker = {
                name = "Winter Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "Retrigger each played",
                    "{C:clubs}Club{} card when scored",
                },
            },

            j_orchid_springjoker = {
                name = "Spring Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "Retrigger each played",
                    "{C:spades}Spade{} card when scored",
                },
            },

            j_orchid_tornado = {
                name = "Tornado",
                text = {
                    "{C:attention}Played cards{} are",
                    "{C:attention}shuffled{} before scoring,",
                    "{X:mult,C:white}X#1#{} Mult",
                },
            },

            j_orchid_blackclover = {
                name = "Black Clover",
                text = {
                    "Played {C:clubs}Club{} {C:attention}Lucky{} cards",
                    "earn {C:money}$#1#{} when scored",
                },
            },

            j_orchid_braininvaders = {
                name = "Brain Invaders",
                text = { {
                    "Scoring {C:attention}face{} cards",
                    "decrease rank by {C:attention}#1#{}"
                }, {
                    "Scored {C:attention}Jacks{} are",
                    "{C:attention}destroyed{}",
                } },
            },

            j_orchid_flyingisland = {
                name = "Flying Island",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "earn {C:money}$#3#{} when",
                    "{C:attention}numbered{} card is scored",
                    "{s:0.8,C:inactive}(Chance increases with rank){}",
                },
            },

            j_orchid_rockpaperjoker = {
                name = "Rock, Paper, Joker",
                text = {
                    "Gain {C:money}$#1#{} of",
                    "{C:attention}sell value{} when",
                    "{C:attention}#2#{} is played,",
                    "{C:inactive}(Hand changes each hand){}",
                },
            },

            j_orchid_cryeyes = {
                name = "Cry Eyes",
                text = {
                    "Gain {C:chips}+#1#{} Chips for each",
                    "item not purchased",
                    "in the {C:attention}shop{}",
                    "{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips){}",
                },
            },

            j_orchid_mindofglory = {
                name = "Mind of Glory",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "if played hand contains",
                    "the {C:attention}previous{} one,",
                    "otherwise loses {X:mult,C:white}X#2#{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{}{C:inactive}, Previous: {C:attention}#4#{}{C:inactive}){}",
                },
            },

            j_orchid_tinyhatjoker = {
                name = "Tiny Hat Joker",
                text = {
                    "Every {C:attention}#1#{} Tags give",
                    "{X:chips,C:white}X#2#{} Chips",
                    "{C:inactive}(Currently {X:chips,C:white}X#3#{}{C:inactive}){}",
                },
            },

            j_orchid_agiftfromabove = {
                name = "A Gift From Above",
                text = {
                    "{C:red}Self destructs{} after",
                    "{C:attention}#1#{} rounds, gain one of:",
                    "{C:attention}#2#{} random {C:attention}Tags{}, {C:money}$#3#{}",
                    "or {C:blue}+#4#{} hand permanently",
                    "{C:inactive}(Currently {C:attention}#5#{}{C:inactive}/#1# rounds){}",
                },
            },

            j_orchid_goldenboy = {
                name = "Golden Boy",
                text = {
                    "{C:attention}Gold{} cards can be",
                    "sold for {C:money}$#1#{}",
                },
            },

            j_orchid_greatempress = {
                name = "Great Empress",
                text = {
                    "{C:green}#1# in #2#{} chance to replace",
                    "a card in {C:attention}Arcana{} or",
                    "{C:attention}Spectral{} packs with",
                    "{C:tarot}The Empress{}",
                },
            },

            j_orchid_recall = {
                name = "Recall",
                text = {
                    "At end of round,",
                    "return {C:attention}1{} of the last {C:attention}#1#{}",
                    "{C:red}destroyed{} playing cards",
                    "to your deck",
                },
            },

            j_orchid_3djoker = {
                name = "3D Joker",
                text = {
                    "{C:attention}Mult{} and {C:attention}Bonus{} cards",
                    "count as {C:attention}face{} cards",
                }
            },

            j_orchid_multup = {
                name = "Mult Upgrade Plate",
                text = {
                    "Give each scored",
                    "{C:attention}Mult{} Card {C:mult}+1{} Mult",
                    "permanently"
                }
            },

            j_orchid_chipsup = {
                name = "Chips Upgrade Plate",
                text = {
                    "Give each scored",
                    "{C:attention}Bonus{} Card {C:chips}+8{} Chips",
                    "permanently"
                }
            },

            j_orchid_theend = {
                name = "The End?",
                text = {
                    "Transforms into a random",
                    "{C:legendary}Legendary{} Joker on {C:attention}Ante #1#{}",
                    "{C:inactive}(Cannot appear on Ante #1# or above){}",
                },
            },

            j_orchid_lethaljoke = {
                name = "Lethal Joke",
                text = {
                    "{X:mult,C:white}X#1#{} Mult,",
                    "Scoring {C:attention}#2#{}, {C:attention}#3#{} or {C:attention}#4#{}",
                    "{C:red}destroys{} this Joker",
                    "{C:inactive}(Ranks change each round){}",
                },
            },

            j_orchid_bellbill = {
                name = "Bell Bill",
                text = {
                    "{C:attention}Voucher{} in the shop",
                    "is {C:attention}free",
                },
            },
        },
    },
}

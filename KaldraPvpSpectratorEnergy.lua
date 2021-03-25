for s= 1,4 do

OnEvent
{
    Conditions = {
        EntityHasJustCastedSpell {
            Tag = "spectator_device"..s,
            SpellId = 3040
        }
    },
    Actions = {
        MapFlagSetTrue { Name="spectator_power"..s},
        EntitySpellRemove { Tag = "spectator_device"..s, SpellId = 3040 },
        EntitySpellAdd { Tag = "spectator_device"..s, SpellId = 1914 }
    };
};

OnEvent
{
    Conditions = {
        EntityHasJustCastedSpell {
            Tag = "spectator_device"..s,
            SpellId = 1914
        }
    },
    Actions = {
        MapFlagSetFalse { Name="spectator_power"..s},
        EntitySpellRemove { Tag = "spectator_device"..s, SpellId = 1914 },
        EntitySpellAdd { Tag = "spectator_device"..s, SpellId = 3040 }
    };
};

-- not sure, if the timer is really needed, maybe emmazek knows
OnEvent
{
	Conditions =
	{
		MapTimerIsElapsed {Name = "mt_power_given"..s, Seconds = 0.1}
	}, 
	Actions =
	{
		MapFlagSetFalse { Name="spectator_power_given"..s},
		MapTimerStop {Name = "mt_power_given"..s}
	}
};

-- reset spectators power to 0
for p = 1,500 do

    OnEvent
        {
            Conditions =
            {
                PlayerPowerAmountIsEqual { Player = Spectators[s], Amount = p},
		MapFlagIsFalse { Name="spectator_power_given"..s}
            },
            Actions =
            {
                PlayerPowerGive {Player = Spectators[s], Amount = -p }
            }
        };

end

-- give the spectators power
for p = 1,500 do

    OnEvent
        {
            Conditions =
            {
                PlayerPowerAmountIsEqual { Player = "pl_Player1", Amount = p},
                MapFlagIsTrue { Name="spectator_power"..s}
            },
            Actions =
            {
                PlayerPowerGive {Player = Spectators[s], Amount = p },
		MapFlagSetTrue { Name="spectator_power_given"..s},
		MapTimerStart	{Name = "mt_power_given"..s}
            }
        };

    OnEvent
        {
            Conditions =
            {
                PlayerPowerAmountIsEqual { Player = "pl_Player4", Amount = p},
                MapFlagIsFalse { Name="spectator_power"..s}
            },
            Actions =
            {
                PlayerPowerGive {Player = Spectators[s], Amount = p },
		MapFlagSetTrue { Name="spectator_power_given"..s},
		MapTimerStart	{Name = "mt_power_given"..s}
            }
        };

end
end

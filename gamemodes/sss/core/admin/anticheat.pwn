/*==============================================================================


	Southclaws' Scavenge and Survive

		Copyright (C) 2020 Barnaby "Southclaws" Keene

		This Source Code Form is subject to the terms of the Mozilla Public
		License, v. 2.0. If a copy of the MPL was not distributed with this
		file, You can obtain one at http://mozilla.org/MPL/2.0/.


==============================================================================*/


#include <YSI_Coding\y_hooks>


/*
	Bridge between the open.mp anti-cheat component and the gamemode's own
	admin tools. Every detection is filed as a report and announced to admins.
	When enforcement is enabled, kicks and bans go through KickPlayer and
	BanPlayer so they show up in the ban list and can be lifted with /unban.
	The component's built-in action is always suppressed.

	The component is mandatory: the script calls its natives, so the
	gamemode will not load without anticheat.so in components/.
*/


static
		ac_Enforce,
		ac_BanDuration;


hook OnGameModeInit()
{
	GetSettingInt("anticheat/enforce", 0, ac_Enforce);
	GetSettingInt("anticheat/ban-duration", 0, ac_BanDuration);
}

public OnPlayerCheatDetected(playerid, cheatid, action)
{
	if(action == AC_ACTION_IGNORE)
		return 0;

	new
		name[MAX_PLAYER_NAME],
		cheatname[32],
		reason[64],
		Float:x,
		Float:y,
		Float:z;

	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	GetPlayerPos(playerid, x, y, z);

	if(!AC_GetCheatName(cheatid, cheatname))
		format(cheatname, sizeof(cheatname), "cheat %d", cheatid);

	format(reason, sizeof(reason), "Anti-cheat detected %s", cheatname);

	log("[ANTICHEAT] %p detected %s (action: %d, enforce: %d)", playerid, cheatname, action, ac_Enforce);
	ReportPlayer(name, reason, -1, REPORT_TYPE_ANTICHEAT, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), "");

	if(!ac_Enforce)
		return 0;

	switch(action)
	{
		case AC_ACTION_KICK:
			KickPlayer(playerid, reason);

		case AC_ACTION_BAN:
			BanPlayer(playerid, reason, -1, ac_BanDuration);
	}

	return 0;
}

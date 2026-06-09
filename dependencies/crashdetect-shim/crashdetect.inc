#if defined CRASHDETECT_INC
	#endinput
#endif
#define CRASHDETECT_INC

/*==============================================================================

	crashdetect no-op shim for open.mp

	open.mp has built-in crash handling, so the crashdetect plugin is no longer
	shipped. Its Pawn natives, however, are not provided by open.mp core, and
	several libraries (sqlitei, pawn-errors, samp-logger) as well as a little
	gamemode init code call them. This shim defines that API surface as no-ops
	so those libraries keep compiling and running without the plugin.

	Consequence: backtrace helpers produce empty output and OnRuntimeError never
	fires - error logs fall back to plain text. open.mp still reports crashes.

==============================================================================*/

stock PrintBacktrace() return 0;
stock PrintNativeBacktrace() return 0;

stock GetBacktrace(string[], size = sizeof(string)) {
	if(size > 0) string[0] = EOS;
	return 0;
}
stock GetNativeBacktrace(string[], size = sizeof(string)) {
	if(size > 0) string[0] = EOS;
	return 0;
}

stock PrintAmxBacktrace() return 0;
stock GetAmxBacktrace(string[], size = sizeof(string)) {
	if(size > 0) string[0] = EOS;
	return 0;
}

forward OnRuntimeError(code, &bool:suppress);

stock bool:IsCrashDetectPresent() return false;

stock SetCrashDetectLongCallTime(us_time) {
	#pragma unused us_time
}
stock GetCrashDetectLongCallTime() return 0;
stock DisableCrashDetectLongCall() {}
stock EnableCrashDetectLongCall() {}
stock ResetCrashDetectLongCallTime() {}
stock RestartCrashDetectLongCall() {}
stock bool:IsCrashDetectLongCallEnabled() return false;
stock bool:HasCrashDetectLongCall() return false;
stock GetCrashDetectDefaultTime() return 0;
stock DisableCrashDetectAddr0() {}
stock EnableCrashDetectAddr0() {}
stock bool:IsCrashDetectAddr0Enabled() return false;
stock bool:HasCrashDetectAddr0() return false;

//Default time to allow between phases in a combo
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_COMBO_DEFAULT_PHASE_TIMEOUT  20

//Default time that a combo "charge" verb must be held before passing to the next phase
//This value allows you to reduce the strength of vibration relative to other devices
#macro INPUT_COMBO_DEFAULT_MIN_CHARGE_TIME  60

//Whether to output debug info when using combos
//This can help identify bugs and misconfigurations but should be turned off for production builds
#macro INPUT_COMBO_DEBUG  true
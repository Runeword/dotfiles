#pragma once

#define MOUSEKEY_INTERVAL 16
#define MOUSEKEY_TIME_TO_MAX 40
#define MOUSEKEY_DELAY 100
#define MOUSEKEY_WHEEL_DELAY 100
#define MOUSEKEY_WHEEL_INTERVAL 50
#define MOUSEKEY_WHEEL_TIME_TO_MAX 100

#undef TAPPING_TERM
#define TAPPING_TERM 200
#define IGNORE_MOD_TAP_INTERRUPT
#define TAPPING_FORCE_HOLD

#undef COMBO_COUNT
#undef COMBO_TERM
#define COMBO_PROCESS_KEY_RELEASE
// #define COMBO_COUNT 26
#define COMBO_TERM 30

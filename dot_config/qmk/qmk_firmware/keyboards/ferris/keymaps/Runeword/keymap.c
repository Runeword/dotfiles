#include QMK_KEYBOARD_H

enum custom_keycodes {
    // US layout altgr-intl variant with french special characters
    GRAVEA = SAFE_RANGE,
    GRAVEE,
    GRAVEU,
    CIRCUMFLEXA,
    CIRCUMFLEXO,
    CIRCUMFLEXE,
    CIRCUMFLEXU,
    CIRCUMFLEXI,
    TREMAE,
    TREMAU,
    TREMAI,
    L4LCTL
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
    case L4LCTL :
        if (record->event.pressed) {
          layer_on(4);
          register_code(KC_LCTL);
          set_oneshot_mods(MOD_BIT(KC_LCTL));
          return false;
        } else {
          layer_off(4);
          unregister_code(KC_LCTL);
          return true;
        }
        break;

    case GRAVEA:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("`")"a");
        }
        break;

    case GRAVEE:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("`")"e");
        }
        break;

    case GRAVEU:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("`")"u");
        }
        break;

    case CIRCUMFLEXA:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("6")"a");
        }
        break;

    case CIRCUMFLEXO:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("6")"o");
        }
        break;

    case CIRCUMFLEXE:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("6")"e");
        }
        break;

    case CIRCUMFLEXU:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("6")"u");
        }
        break;

    case CIRCUMFLEXI:
        if (record->event.pressed) {
        SEND_STRING(SS_RALT("6")"i");
        }
        break;

    case TREMAE:
        if (record->event.pressed) {
          SEND_STRING(SS_RALT(SS_RSFT("\""))"e");
        }
        break;

    case TREMAU:
        if (record->event.pressed) {
          SEND_STRING(SS_RALT(SS_RSFT("\""))"u");
        }
        break;

    case TREMAI:
        if (record->event.pressed) {
          SEND_STRING(SS_RALT(SS_RSFT("\""))"i");
        }
        break;
    }
    return true;
};

enum combos {
  L1ALT,
  L1CS,
  L1CTL,
  L1GS,
  L1GUI,
  L1SFT,
  L2ALT,
  L2CS,
  L2CTL,
  L2GS,
  L2GUI,
  L2SFT,
  L2SLSH,
  L2GRV,
  L2MINS,
  L3ACUTEE,
  L3CEDILLAC,
  L3CIRCUMFLEXA,
  L3CIRCUMFLEXE,
  L3CIRCUMFLEXI,
  L3CIRCUMFLEXO,
  L3CIRCUMFLEXU,
  L3GRAVEA,
  L3GRAVEE,
  L3GRAVEU,
  L3TREMAE,
  L3TREMAI,
  L3TREMAU,
};

const uint16_t PROGMEM l1alt[] = { LT(1,KC_TAB), KC_A, COMBO_END};
const uint16_t PROGMEM l1cs[] = { LT(1,KC_TAB), KC_E, KC_U, COMBO_END};
const uint16_t PROGMEM l1ctl[] = { LT(1,KC_TAB), KC_U, COMBO_END};
const uint16_t PROGMEM l1gs[] = { LT(1,KC_TAB), KC_E, KC_O, COMBO_END};
const uint16_t PROGMEM l1gui[] = { LT(1,KC_TAB), KC_O, COMBO_END};
const uint16_t PROGMEM l1sft[] = { LT(1,KC_TAB), KC_E, COMBO_END};
const uint16_t PROGMEM l2alt[] = { LT(2,KC_ENT), KC_S, COMBO_END};
const uint16_t PROGMEM l2cs[] = { LT(2,KC_ENT), KC_T, KC_H, COMBO_END};
const uint16_t PROGMEM l2ctl[] = { LT(2,KC_ENT), KC_H, COMBO_END};
const uint16_t PROGMEM l2gs[] = { LT(2,KC_ENT), KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM l2gui[] = { LT(2,KC_ENT), KC_N, COMBO_END};
const uint16_t PROGMEM l2sft[] = { LT(2,KC_ENT), KC_T, COMBO_END};
const uint16_t PROGMEM l2slsh[] = { LT(2,KC_ENT), KC_R, COMBO_END};
const uint16_t PROGMEM l2grv[] = { LT(2,KC_ENT), KC_QUOT, COMBO_END};
const uint16_t PROGMEM l2mins[] = { LT(2,KC_ENT), KC_COMM, COMBO_END};
const uint16_t PROGMEM l3acutee[] = { LT(3,KC_ESC), KC_E, COMBO_END};
const uint16_t PROGMEM l3cedillac[] = { LT(3,KC_ESC), KC_C, COMBO_END};
const uint16_t PROGMEM l3circumflexa[] = { LT(3,KC_ESC), KC_QUOT, COMBO_END};
const uint16_t PROGMEM l3circumflexe[] = { LT(3,KC_ESC), KC_DOT, COMBO_END};
const uint16_t PROGMEM l3circumflexi[] = { LT(3,KC_ESC), KC_Y, COMBO_END};
const uint16_t PROGMEM l3circumflexo[] = { LT(3,KC_ESC), KC_COMM, COMBO_END};
const uint16_t PROGMEM l3circumflexu[] = { LT(3,KC_ESC), KC_P, COMBO_END};
const uint16_t PROGMEM l3gravea[] = { LT(3,KC_ESC), KC_A, COMBO_END};
const uint16_t PROGMEM l3gravee[] = { LT(3,KC_ESC), KC_O, COMBO_END};
const uint16_t PROGMEM l3graveu[] = { LT(3,KC_ESC), KC_U, COMBO_END};
const uint16_t PROGMEM l3tremae[] = { LT(3,KC_ESC), KC_J, COMBO_END};
const uint16_t PROGMEM l3tremai[] = { LT(3,KC_ESC), KC_X, COMBO_END};
const uint16_t PROGMEM l3tremau[] = { LT(3,KC_ESC), KC_K, COMBO_END};

combo_t key_combos[COMBO_COUNT] = {
  [L1ALT] = COMBO(l1alt, OSM(MOD_LALT)),
  [L1CS] = COMBO(l1cs, OSM(MOD_LCTL|MOD_LSFT)),
  [L1CTL] = COMBO(l1ctl, OSM(MOD_LCTL)),
  [L1GS] = COMBO(l1gs, OSM(MOD_LGUI|MOD_LSFT)),
  [L1GUI] = COMBO(l1gui, OSM(MOD_LGUI)),
  [L1SFT] = COMBO(l1sft, OSM(MOD_LSFT)),
  [L2ALT] = COMBO(l2alt, OSM(MOD_RALT)),
  [L2CS] = COMBO(l2cs, OSM(MOD_RCTL|MOD_RSFT)),
  // [L2CTL] = COMBO(l2ctl, OSM(MOD_RCTL)),
  [L2CTL] = COMBO(l2ctl, L4LCTL),
  [L2GS] = COMBO(l2gs, OSM(MOD_RGUI|MOD_RSFT)),
  [L2GUI] = COMBO(l2gui, OSM(MOD_RGUI)),
  [L2SFT] = COMBO(l2sft, OSM(MOD_RSFT)),
  [L2SLSH] = COMBO(l2slsh, KC_SLSH),
  [L2GRV] = COMBO(l2grv, KC_GRV),
  [L2MINS] = COMBO(l2mins, KC_MINS),
  [L3ACUTEE] = COMBO(l3acutee, RALT(KC_E)),
  [L3CEDILLAC] = COMBO(l3cedillac, RALT(KC_COMM)),
  [L3CIRCUMFLEXA] = COMBO(l3circumflexa, CIRCUMFLEXA),
  [L3CIRCUMFLEXE] = COMBO(l3circumflexe, CIRCUMFLEXE),
  [L3CIRCUMFLEXI] = COMBO(l3circumflexi, CIRCUMFLEXI),
  [L3CIRCUMFLEXO] = COMBO(l3circumflexo, CIRCUMFLEXO),
  [L3CIRCUMFLEXU] = COMBO(l3circumflexu, CIRCUMFLEXU),
  [L3GRAVEA] = COMBO(l3gravea, GRAVEA),
  [L3GRAVEE] = COMBO(l3gravee, GRAVEE),
  [L3GRAVEU] = COMBO(l3graveu, GRAVEU),
  [L3TREMAE] = COMBO(l3tremae, TREMAE),
  [L3TREMAI] = COMBO(l3tremai, TREMAI),
  [L3TREMAU] = COMBO(l3tremau, TREMAU),
};

/* THIS FILE WAS GENERATED!
 *
 * This file was generated by qmk json2c. You may or may not want to
 * edit it directly.
 */

// const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
// 	[0] = LAYOUT_split_3x5_2(KC_QUOT, KC_COMM, KC_DOT, KC_P, KC_Y, KC_F, KC_G, KC_C, KC_R, KC_L, KC_A, KC_O, KC_E, KC_U, KC_I, KC_D, KC_H, KC_T, KC_N, KC_S, KC_SCLN, KC_Q, KC_J, KC_K, KC_X, KC_B, KC_M, KC_W, KC_V, KC_Z, LT(3,KC_ESC), LT(1,KC_TAB), LT(2,KC_ENT), KC_SPC),
// 	[1] = LAYOUT_split_3x5_2(KC_GRV, KC_MINS, KC_EQL, KC_PLUS, KC_NO, KC_AT, KC_LBRC, KC_RBRC, KC_SLSH, KC_BSLS, KC_EXLM, KC_QUES, KC_HASH, KC_ASTR, KC_NO, KC_TILD, KC_LPRN, KC_RPRN, KC_CIRC, KC_DLR, KC_AMPR, KC_PIPE, KC_UNDS, KC_PERC, KC_NO, KC_NO, KC_LCBR, KC_RCBR, KC_NO, KC_NO, KC_TRNS, KC_TRNS, LT(3,KC_ENT), KC_TRNS),
// 	[2] = LAYOUT_split_3x5_2(KC_HOME, KC_END, KC_PGDN, KC_PGUP, KC_INS, KC_NO, KC_MPRV, KC_MNXT, KC_MPLY, KC_MUTE, KC_LEFT, KC_RGHT, KC_DOWN, KC_UP, KC_DEL, KC_CAPS, KC_RCTL, KC_RSFT, KC_RGUI, KC_RALT, KC_WH_L, KC_WH_R, KC_WH_D, KC_WH_U, KC_NO, KC_NO, KC_BRIU, KC_BRID, KC_VOLU, KC_VOLD, KC_BSPC, LT(3,KC_TAB), KC_TRNS, KC_TRNS),
// 	[3] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_9, KC_5, KC_6, KC_7, KC_8, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_0, KC_1, KC_2, KC_3, KC_4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_PEQL, KC_PPLS, KC_PMNS, KC_PSLS, KC_PAST, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS)
// };

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_2(KC_QUOT, KC_COMM, KC_DOT, KC_P, KC_Y, KC_F, KC_G, KC_C, KC_R, KC_L, KC_A, KC_O, KC_E, KC_U, KC_I, KC_D, KC_H, KC_T, KC_N, KC_S, KC_SCLN, KC_Q, KC_J, KC_K, KC_X, KC_B, KC_M, KC_W, KC_V, KC_Z, LT(3,KC_ESC), LT(1,KC_TAB), LT(2,KC_ENT), KC_SPC),
    [1] = LAYOUT_split_3x5_2(KC_GRV, KC_MINS, KC_EQL, KC_PLUS, KC_NO, KC_AT, KC_LBRC, KC_RBRC, KC_SLSH, KC_BSLS, KC_EXLM, KC_QUES, KC_HASH, KC_ASTR, KC_NO, KC_TILD, KC_LPRN, KC_RPRN, KC_CIRC, KC_DLR, KC_AMPR, KC_PIPE, KC_UNDS, KC_PERC, KC_NO, KC_NO, KC_LCBR, KC_RCBR, KC_NO, KC_NO, KC_TRNS, KC_TRNS, LT(3,KC_ENT), KC_TRNS),
    [2] = LAYOUT_split_3x5_2(KC_HOME, KC_END, KC_PGDN, KC_PGUP, KC_INS, KC_NO, KC_MPRV, KC_MNXT, KC_MPLY, KC_MUTE, KC_LEFT, KC_RGHT, KC_DOWN, KC_UP, KC_CAPS, KC_NO, KC_RCTL, KC_RSFT, KC_RGUI, KC_RALT, KC_WH_L, KC_WH_R, KC_WH_D, KC_WH_U, KC_NO, KC_NO, KC_BRIU, KC_BRID, KC_VOLU, KC_VOLD, KC_DEL, LT(3,KC_BSPC), KC_TRNS, KC_TRNS),
    [3] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_9, KC_5, KC_6, KC_7, KC_8, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_0, KC_1, KC_2, KC_3, KC_4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_PEQL, KC_PPLS, KC_PMNS, KC_PSLS, KC_PAST, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
    [4] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_NO, KC_NO),
    [5] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_TRNS, KC_TRNS)
};

// layer_state_t layer_state_set_user(layer_state_t state) {
//   return update_tri_layer_state(state, 1, 2, 3);
// }

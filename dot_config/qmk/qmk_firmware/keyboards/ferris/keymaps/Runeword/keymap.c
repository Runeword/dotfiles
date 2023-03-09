#include QMK_KEYBOARD_H

// ________________________ KEYCODES ________________________

enum custom_keycodes {

    // french special characters
    GRAVEA = SAFE_RANGE,
    // GRAVEE,
    // GRAVEU,
    CIRCUMFLEXA,
    CIRCUMFLEXO,
    CIRCUMFLEXE,
    CIRCUMFLEXU,
    CIRCUMFLEXI,
    TREMAE,
    TREMAU,
    TREMAI,

    // custom modifiers
    right_ctrl,
    right_ctrl_shift,
    left_ctrl,
    left_ctrl_shift,
    left_ctrl_3,
    left_gui_3
};

// ________________________ define the behavior of custom keycodes

bool custom_mod(int layer, bool pressed) {
  if (pressed) {
      layer_on(layer);
      register_code(KC_LCTL);
      set_oneshot_mods(MOD_BIT(KC_LCTL));
      return false;
  } else {
      layer_off(layer);
      unregister_code(KC_LCTL);
      return true;
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {

    // hold layer, hold modifier + one shot modifier
    case right_ctrl:
        return custom_mod(4, record->event.pressed);
        break;

    case left_ctrl_3:
        return custom_mod(3, record->event.pressed);
        break;

    case left_ctrl:
        return custom_mod(5, record->event.pressed);
        break;

    case left_gui_3:
    if (record->event.pressed) {
        layer_on(3);
        register_code(KC_LGUI);
        set_oneshot_mods(MOD_BIT(KC_LGUI));
        return false;
    } else {
        layer_off(3);
        unregister_code(KC_LGUI);
        return true;
    }
    break;

    // hold layer 4, control+shift and control+shift for one keypress
    case right_ctrl_shift:
        if (record->event.pressed) {
            layer_on(4);
            register_code(KC_LCTL);
            register_code(KC_LSFT);
            set_oneshot_mods(MOD_LCTL | MOD_LSFT);
            return false;
        } else {
            layer_off(4);
            unregister_code(KC_LCTL);
            unregister_code(KC_LSFT);
            return true;
        }
        break;

    case left_ctrl_shift:
        if (record->event.pressed) {
            layer_on(5);
            register_code(KC_LCTL);
            register_code(KC_LSFT);
            set_oneshot_mods(MOD_LCTL | MOD_LSFT);
            return false;
        } else {
            layer_off(5);
            unregister_code(KC_LCTL);
            unregister_code(KC_LSFT);
            return true;
        }
        break;

    // holding the right alt key while pressing another key on the US (altgr-intl) layout yields special characters
    case GRAVEA:
        if (record->event.pressed) SEND_STRING(SS_RALT("`") "a");
        break;
    // case GRAVEE:
    //     if (record->event.pressed) SEND_STRING(SS_RALT("`") "e");
    //     break;
    // case GRAVEU:
    //     if (record->event.pressed) SEND_STRING(SS_RALT("`") "u");
    //     break;
    case CIRCUMFLEXA:
        if (record->event.pressed) SEND_STRING(SS_RALT("6") "a");
        break;
    case CIRCUMFLEXO:
        if (record->event.pressed) SEND_STRING(SS_RALT("6") "o");
        break;
    case CIRCUMFLEXE:
        if (record->event.pressed) SEND_STRING(SS_RALT("6") "e");
        break;
    case CIRCUMFLEXU:
        if (record->event.pressed) SEND_STRING(SS_RALT("6") "u");
        break;
    case CIRCUMFLEXI:
        if (record->event.pressed) SEND_STRING(SS_RALT("6") "i");
        break;
    case TREMAE:
        if (record->event.pressed) SEND_STRING(SS_RALT(SS_RSFT("\"")) "e");
        break;
    case TREMAU:
        if (record->event.pressed) SEND_STRING(SS_RALT(SS_RSFT("\"")) "u");
        break;
    case TREMAI:
        if (record->event.pressed) SEND_STRING(SS_RALT(SS_RSFT("\"")) "i");
        break;
    }
    return true;
};

// ________________________ COMBOS ________________________

enum combos {
    MOD_LA,
    MOD_LCS,
    MOD_LC,
    MOD_LGS,
    MOD_LG,
    MOD_LS,
    MOD_RA,
    MOD_RCS,
    MOD_RC,
    MOD_RGS,
    MOD_RG,
    MOD_RS,
    SPE_ACUTEE,
    SPE_CEDILLAC,
    SPE_CIRCUMFLEXA,
    SPE_CIRCUMFLEXE,
    SPE_CIRCUMFLEXI,
    SPE_CIRCUMFLEXO,
    SPE_CIRCUMFLEXU,
    SPE_GRAVEA,
    // SPE_GRAVEE,
    // SPE_GRAVEU,
    MOD_LC_3,
    MOD_LG_3,
    SPE_TREMAE,
    SPE_TREMAI,
    SPE_TREMAU,
    ESC,
    DEL,
    CAPS,
    BOOT,
    COMBO_LENGTH
};

uint16_t COMBO_LEN = COMBO_LENGTH;

// ________________________ define sequences of keys for combos

// thumb + homerow key(s) combinations (left side)
const uint16_t PROGMEM thumb1_a[]  = {LT(1, KC_BSPC), KC_A, COMBO_END};
const uint16_t PROGMEM thumb1_o[]  = {LT(1, KC_BSPC), KC_O, COMBO_END};
const uint16_t PROGMEM thumb1_e[]  = {LT(1, KC_BSPC), KC_E, COMBO_END};
const uint16_t PROGMEM thumb1_u[]  = {LT(1, KC_BSPC), KC_U, COMBO_END};
const uint16_t PROGMEM thumb1_oe[] = {LT(1, KC_BSPC), KC_O, KC_E, COMBO_END};
const uint16_t PROGMEM thumb1_eu[] = {LT(1, KC_BSPC), KC_E, KC_U, COMBO_END};

// thumb + homerow key(s) combinations (right side)
const uint16_t PROGMEM thumb2_h[]  = {LT(2, KC_TAB), KC_H, COMBO_END};
const uint16_t PROGMEM thumb2_t[]  = {LT(2, KC_TAB), KC_T, COMBO_END};
const uint16_t PROGMEM thumb2_n[]  = {LT(2, KC_TAB), KC_N, COMBO_END};
const uint16_t PROGMEM thumb2_s[]  = {LT(2, KC_TAB), KC_S, COMBO_END};
const uint16_t PROGMEM thumb2_ht[] = {LT(2, KC_TAB), KC_H, KC_T, COMBO_END};
const uint16_t PROGMEM thumb2_tn[] = {LT(2, KC_TAB), KC_T, KC_N, COMBO_END};

// thumb + key combinations
const uint16_t PROGMEM thumb3_e[]    = {LT(3, KC_ENT), KC_E, COMBO_END};
const uint16_t PROGMEM thumb3_c[]    = {LT(3, KC_ENT), KC_C, COMBO_END};
const uint16_t PROGMEM thumb3_quot[] = {LT(3, KC_ENT), KC_QUOT, COMBO_END};
const uint16_t PROGMEM thumb3_dot[]  = {LT(3, KC_ENT), KC_DOT, COMBO_END};
const uint16_t PROGMEM thumb3_y[]    = {LT(3, KC_ENT), KC_Y, COMBO_END};
const uint16_t PROGMEM thumb3_comm[] = {LT(3, KC_ENT), KC_COMM, COMBO_END};
const uint16_t PROGMEM thumb3_p[]    = {LT(3, KC_ENT), KC_P, COMBO_END};
const uint16_t PROGMEM thumb3_a[]    = {LT(3, KC_ENT), KC_A, COMBO_END};
const uint16_t PROGMEM thumb3_o[]    = {LT(3, KC_ENT), KC_O, COMBO_END};
const uint16_t PROGMEM thumb3_u[]    = {LT(3, KC_ENT), KC_U, COMBO_END};
const uint16_t PROGMEM thumb3_j[]    = {LT(3, KC_ENT), KC_J, COMBO_END};
const uint16_t PROGMEM thumb3_x[]    = {LT(3, KC_ENT), KC_X, COMBO_END};
const uint16_t PROGMEM thumb3_k[]    = {LT(3, KC_ENT), KC_K, COMBO_END};

// homerow keys combinations
const uint16_t PROGMEM eu[]  = {KC_E, KC_U, COMBO_END};
const uint16_t PROGMEM htn[] = {KC_H, KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM oeu[] = {KC_O, KC_E, KC_U, COMBO_END};

// other combinations
const uint16_t PROGMEM gcr[] = {KC_G, KC_C, KC_R, COMBO_END};

// ________________________ list sequences of keys and their resulting action

combo_t key_combos[] = {
    // [name] = COMBO(sequence , action)

    // modifiers
    [MOD_LA]  = COMBO(thumb1_a, OSM(MOD_LALT)),
    [MOD_LG]  = COMBO(thumb1_o, OSM(MOD_LGUI)),
    [MOD_LS]  = COMBO(thumb1_e, OSM(MOD_LSFT)),
    [MOD_LC]  = COMBO(thumb1_u, left_ctrl),
    [MOD_LGS] = COMBO(thumb1_oe, OSM(MOD_LGUI | MOD_LSFT)),
    [MOD_LCS] = COMBO(thumb1_eu, left_ctrl_shift),
    [MOD_RC]  = COMBO(thumb2_h, right_ctrl),
    [MOD_RS]  = COMBO(thumb2_t, OSM(MOD_RSFT)),
    [MOD_RG]  = COMBO(thumb2_n, OSM(MOD_RGUI)),
    [MOD_RA]  = COMBO(thumb2_s, OSM(MOD_RALT)),
    [MOD_RCS] = COMBO(thumb2_ht, right_ctrl_shift),
    [MOD_RGS] = COMBO(thumb2_tn, OSM(MOD_RGUI | MOD_RSFT)),

    // french special characters
    [SPE_ACUTEE]      = COMBO(thumb3_e, RALT(KC_E)),
    [SPE_CEDILLAC]    = COMBO(thumb3_c, RALT(KC_COMM)),
    [SPE_CIRCUMFLEXA] = COMBO(thumb3_quot, CIRCUMFLEXA),
    [SPE_CIRCUMFLEXE] = COMBO(thumb3_dot, CIRCUMFLEXE),
    [SPE_CIRCUMFLEXI] = COMBO(thumb3_y, CIRCUMFLEXI),
    [SPE_CIRCUMFLEXO] = COMBO(thumb3_comm, CIRCUMFLEXO),
    [SPE_CIRCUMFLEXU] = COMBO(thumb3_p, CIRCUMFLEXU),
    [SPE_GRAVEA]      = COMBO(thumb3_a, GRAVEA),
    // [SPE_GRAVEE]      = COMBO(thumb3_o, GRAVEE),
    // [SPE_GRAVEU]      = COMBO(thumb3_u, GRAVEU),
    [MOD_LC_3]      = COMBO(thumb3_u, left_ctrl_3),
    [MOD_LG_3]      = COMBO(thumb3_o, left_gui_3),
    [SPE_TREMAE]      = COMBO(thumb3_j, TREMAE),
    [SPE_TREMAI]      = COMBO(thumb3_x, TREMAI),
    [SPE_TREMAU]      = COMBO(thumb3_k, TREMAU),

    [ESC]  = COMBO(eu, KC_ESC),
    [DEL]  = COMBO(htn, KC_DEL),
    [CAPS] = COMBO(oeu, KC_CAPS),
    [BOOT] = COMBO(gcr, QK_BOOT),
};

uint16_t get_combo_term(uint16_t index, combo_t *combo) {

    switch (index) {
    case ESC: return 10;
    case DEL: return 10;
    case CAPS: return 10;
    case BOOT: return 10;
    }

    return COMBO_TERM;
}

// ________________________ define the behavior of each key release after a combo was activated

bool process_combo_key_release(uint16_t combo_index, combo_t *combo, uint8_t key_index, uint16_t keycode) {
    switch (combo_index) {

    // disable control or shift keys depending on whether h or t keys of the MOD_RCS combo are released
    case MOD_RCS:
        switch (keycode) {
        case KC_T: unregister_code(KC_LSFT); break;
        case KC_H: unregister_code(KC_LCTL); break;
        }
        return false;

    case MOD_LCS:
        switch (keycode) {
        case KC_E: unregister_code(KC_LSFT); break;
        case KC_U: unregister_code(KC_LCTL); break;
        }
        return false;

    // disable control key when h key of the MOD_RC combo is released
    case MOD_RC:
        switch (keycode) {
        case KC_H: unregister_code(KC_LCTL); break;
        }
        return false;

    case MOD_LC:
        switch (keycode) {
        case KC_U: unregister_code(KC_LCTL); break;
        }
        return false;
    }
    return false;
}

// ________________________ TRI LAYER STATE ________________________

// layer_state_t layer_state_set_user(layer_state_t state) { return update_tri_layer_state(state, 1, 2, 3); }

// ________________________ KEYMAPS ________________________

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[0] = LAYOUT_split_3x5_2(KC_QUOT, KC_COMM, KC_DOT, KC_P, KC_Y, KC_F, KC_G, KC_C, KC_R, KC_L, KC_A, KC_O, KC_E, KC_U, KC_I, KC_D, KC_H, KC_T, KC_N, KC_S, KC_SCLN, KC_Q, KC_J, KC_K, KC_X, KC_B, KC_M, KC_W, KC_V, KC_Z, LT(3,KC_ENT), LT(1,KC_BSPC), LT(2,KC_TAB), KC_SPC),
	[1] = LAYOUT_split_3x5_2(KC_GRV, KC_MINS, KC_EQL, KC_PLUS, KC_NO, KC_AT, KC_LBRC, KC_RBRC, KC_SLSH, KC_BSLS, KC_EXLM, KC_QUES, KC_HASH, KC_ASTR, KC_NO, KC_TILD, KC_LPRN, KC_RPRN, KC_CIRC, KC_DLR, KC_AMPR, KC_PIPE, KC_UNDS, KC_PERC, KC_NO, KC_NO, KC_LCBR, KC_RCBR, KC_NO, KC_NO, KC_NO, KC_NO, KC_TAB, KC_SPC),
	[2] = LAYOUT_split_3x5_2(KC_HOME, KC_END, KC_PGDN, KC_PGUP, KC_INS, KC_NO, KC_MPRV, KC_MNXT, KC_MPLY, KC_MUTE, KC_LEFT, KC_RGHT, KC_DOWN, KC_UP, KC_NO, KC_NO, KC_RCTL, KC_RSFT, KC_RGUI, KC_RALT, KC_WH_L, KC_WH_R, KC_WH_D, KC_WH_U, KC_NO, KC_NO, KC_BRIU, KC_BRID, KC_VOLU, KC_VOLD, KC_ENT, KC_BSPC, KC_NO, KC_NO),
	[3] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_9, KC_5, KC_6, KC_7, KC_8, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_0, KC_1, KC_2, KC_3, KC_4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_PEQL, KC_PPLS, KC_PMNS, KC_PSLS, KC_PAST, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
	[4] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_LCTL, KC_LSFT, KC_LGUI, KC_LALT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_NO, KC_NO),
	[5] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, KC_NO, KC_TRNS, KC_TRNS),
	[6] = LAYOUT_split_3x5_2(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_F5, KC_F6, KC_F7, KC_F8, KC_LALT, KC_LGUI, KC_LSFT, KC_LCTL, KC_NO, KC_NO, KC_F1, KC_F2, KC_F3, KC_F4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_F9, KC_F10, KC_F11, KC_F12, KC_NO, KC_NO, KC_NO, KC_NO)
};

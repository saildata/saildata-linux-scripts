#!/bin/sh
#
# Startup script - set main monitor resolution, fix keyboard repeat rate, adjust mouse sensitivity

# (2160LG) 4k settings (Main 2160p monitor, laptop monitor disabled) #
set4kMode(){
  nvidia-settings --assign "CurrentMetaMode = DP-4: nvidia-auto-select @3840x2160 +0+0 {ViewPortIn=3840x2160,
  ViewPortOut=3840x2160+0+0}" > /dev/null 2>&1
}

# Keyboard repeat rate
setkeyboard(){
  xset r rate 230 30 || true
}

# Mouse sensitivity
setmouse(){
  DEV_N=$( xinput | grep -i logitech | cut --f=2 | cut --d='=' --f=2 )

  DEV_N_ATTR=$( xinput list-props "$DEV_N" | grep 'Device Accel Constant Deceleration' | awk '{ print $5 }' | tr -d '(): ' )

  xinput set-prop "$DEV_N" "$DEV_N_ATTR" 0.80 || echo 'Error: correct-mouse-sensitivity' 2>/dev/null || true
}

set4kMode && setkeyboard && echo "(2160LG_D) Set 2160p LG [Home] mode"


# Other

Other steps to get the machine working like I want it :)

## Invert scroll Windows 11

1. Device Manager -> Find device -> Properties -> Details -> Device instance path -> Copy value
2. Registry editor -> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID -> Go to path -> Device Parameters -> FlipFlopWheel = 1
3. Unplug device and plug it back in

## Upgrade AdBlock Plus

1. https://accounts.adblockplus.org/en/premium
2. "Activate here"
3. Follow instructions

## Snipaste

1. Update preferences:

    ![new preferences](https://github.com/user-attachments/assets/f3e6199e-f7e4-4c8e-b45f-83272b3e6ffa)

## Remove recycle bin desktop icon

Settings > Personalization > Themes > Desktop icon settings > uncheck "Recycle Bin"

## Other programs

`winget install Git.Git vscodium voidtools.Everything snipaste devcom.luajit`

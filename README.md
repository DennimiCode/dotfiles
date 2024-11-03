# Additional info about dotfiles

## Games

### Recommended options for launching games

#### Counter-Strike 2 (CS:GO)

```text
HOST_LC_ALL=ru_RU.UTF-8 ENABLE_VKBASALT=1 LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libgamemodeauto.so.0 mangohud %command%
```

#### Counter-Strike: Source

```text
HOST_LC_ALL=ru_RU.UTF-8 LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libgamemodeauto.so.0 mangohud --dlsym %command%
```

#### Counter-Strike 1.6

```text
HOST_LC_ALL=ru_RU.UTF-8 LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libgamemodeauto.so.0 mangohud --dlsym %command%
```

#### Battlefield 1

NOTE: After EA update with EA Anti-cheat game is broken

```text
DXVK_ENABLE_NVAPI=1 PROTON_ENABLE_NVAPI=1 PROTON_HIDE_NVIDIA_GPU=0 DXVK_ASYNC=1 HOST_LC_ALL=ru_RU.UTF-8 ENABLE_VKBASALT=1 LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libgamemodeauto.so.0 MANGOHUD=1 %command%
```

## Linux optimization

### Grub settings

Add 'fsck.mode=skip' only if you using LVM drive encryption & want to auto skip disk checking at every boot

```text
GRUB_CMDLINE_LINUX_DEFAULT="fsck.mode=skip quiet splash loglevel=3 rootfstype=ext4 libahci.ignore_sss=1 raid=noautodetect lpj=SET_YOUR_VALUE_HERE"
```

How to get lpj value:

```shell
sudo dmesg | grep lpj
```

Also, if you have problems with powering off your PC or laptop, add to GRUB_CMDLINE_LINUX_DEFAULT 'acpi=force' & 'apm=power_off'

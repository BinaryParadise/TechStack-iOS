# Hackintosh

Tool: UniBeast 8.2

## Args

```bash
dart=0 nv_disable=1 -v darkwake=0
```



## Q&A

> Couldn't copy apfs.efi to destination ESP folder

```bash
sudo diskutil partitionDisk USB-Device GPT JHFS+ VOLUME-NAME R

Replace USB-Device with the device name of your destination volume, i.e. /dev/disk2
Replace VOLUME-NAME with the volume name you want.
```


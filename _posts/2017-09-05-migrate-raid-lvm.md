---
layout: post
date:   2017-09-05 14:15:00 +0100
title:  "Migrating to RAID + LVM"
---

These are my notes from migrating a Debian Stretch system to RAID1 + LVM.

I found several guides for adding redundant storage to an existing system.
However none of them did quite what I wanted.

The specific commands are for a BIOS boot system.
To use UEFI, they would need some adjustment.
I include /boot inside the LVM.


## Questions

1. Can I put /boot on RAID and/or LVM?
2. Can I switch between UEFI and BIOS boot?
3. Can I put EFI System Partition on RAID?
4. Do I need to avoid changing the hostname if I have MD RAID?


### Q1: Can I put /boot on RAID and/or LVM?

[GRUB2 claims support for /boot on LVM][grub2-manual].
The Debian wiki [claims their installer can configure RAID1 + LVM][debian-installer],
apparently including /boot.  On the other hand when you look at Fedora documentation,
[they don't support this][fedora-installer-part-rec].  Perhaps Fedora have reasons to
consider this a corner case which is not well supported.  The same Fedora section does
however imply support for /boot on RAID.

[debian-installer]: https://wiki.debian.org/DebianInstaller/SoftwareRaidRoot
[fedora-installer-part-rec]: https://docs.fedoraproject.org/f26/install-guide/install/Installing_Using_Anaconda.html#sect-installation-gui-manual-partitioning-recommended
[grub2-manual]: https://www.gnu.org/software/grub/manual/grub.html#Changes-from-GRUB-Legacy

Setting it up on Debian, I didn't see warnings of any issue or caveat.
That said, if you ever want to use the GRUB2 command line to select and access an LVM volume,
[I found an undocumented bug][stackexchange-grub-lvm] which affects how you do this.

[stackexchange-grub-lvm]: https://unix.stackexchange.com/questions/390219/grub-boot-on-lvm-on-md-raid/390229


### Q2: Can I switch between UEFI and BIOS boot?

I'm following the current Fedora installer,
and using GPT disklabels even though this
system uses BIOS boot.

When switching from UEFI to BIOS boot,
grub will need a very small GPT partition.
This replaces the 31 "reserved sectors" in MBR.
I use 1MB to keep things simple and even.

This means it's not _too_ hard to switch between
grub-efi and grub-pc, if you needed to in future.

If you want to be able to switch from grub-pc to grub-efi,
just remember you'll need to leave enough space
for an EFI System Partition (ESP).


### Q3: Can I put EFI System Partition on RAID?

To get UEFI to boot from a disk, you need an ESP.
So how would you set this up for redundancy, when one of the RAID disks fails?

One answer is to depend on specific motherboard firmware support,
aka fakeRAID.  [This is just software RAID][sata-raid-faq]
where the specific format is also supported by the boot firmware.
(Equally, if you already have a real hardware RAID which is
supported by firmware, then you're done).  As far as I could tell
no-one really likes fakeraid, except the companies who sell it.
I'd much rather stick with the reliable `mdadm`.

[sata-raid-faq]: https://ata.wiki.kernel.org/index.php/SATA_RAID_FAQ

The other answer is to just clone the ESP to each disk.
This assumes the ESP is not changed e.g. for kernel updates.
I believe this works correctly on Debian.

It's not so easy on Fedora, as they decided to put `grub.cfg` on the ESP.
[At the same time as RedHat are promoting UEFI on servers][redhat-pro-uefi].
Technically this is more elegant and robust against other types
of change.  However I haven't seen any suggestions about replicatating
updates to multiple ESPs.

[redhat-pro-uefi]: https://developers.redhat.com/blog/2014/07/30/importance-of-standardization-emerging-64-bit-arm-servers/


### Q4: Do I need to avoid changing the hostname if I have MD RAID?

The full "name" of an MD is structured as `hostname:devname`.
`hostname` should match any HOMEHOST in /etc/mdadm/mdadm.conf AND
the same in the initrd.  If not, auto-assembly will rename the array
to a "remote" name (append `_0`).  If you mount based on the
device name e.g. `/dev/md/0`, this is what will break your boot.

names can be updated manually to different values while assembling
(`-U homehost` or `-U name`).

An example of updating the device name on Debian:

    mdadm --stop /dev/md/debian
    mdadm --assemble -U name --name lair /dev/md/lair /dev/vdb1

    # write a new ARRAY line for "lair"
    mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
    
    # remove old ARRAY line for "debian"
    vi /etc/mdadm/mdadm.conf  
    update-initramfs -u -k all

This can be adapted to change the homehost by instead using
`hosthost:devname`, or `-U homehost --homehost hostname`.


## Process

Outline:

1. Copy the current system to a degraded RAID on the new disk.
2. Boot the system from RAID.
3. Very carefully double-check, then have the RAID swallow the old disk.

I tested this inside a VM.
On a physical machine, it will show `sda` instead of `vda`, etc.

    # lsblk
    NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    vda    254:0    0   10G  0 disk
    └─vda1 254:1    0   10G  0 part /
    vdb    254:16   0   11G  0 disk


### Step 1: Create degraded RAID on the new disk

Partition the extra disk with GPT:
        
    # fdisk /dev/vdb
                                                    
    Welcome to fdisk (util-linux 2.29.2).             
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.
                    
    Command (m for help): g                    
            
    Created a new GPT disklabel (GUID: 1C6EB8C4-B40A-4C9C-98AE-BA7E33F1A549).

    Command (m for help): n
    Partition number (1-128, default 1):
    First sector (2048-23068638, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-23068638, default 23068638): +9G

    Created a new partition 1 of type 'Linux filesystem' and of size 9 GiB.

    Command (m for help): n                                                
    Partition number (2-128, default 2):                                   
    First sector (18876416-23068638, default 18876416):                    
    Last sector, +sectors or +size{K,M,G,T,P} (18876416-23068638, default 23068638): +1M                                          
                                                                    
    Created a new partition 2 of type 'Linux filesystem' and of size 1 MiB.

    Command (m for help): t
    Partition number (1,2, default 2): 2
    Hex code (type L to list all codes): L
    1 EFI System                     C12A7328-F81F-11D2-BA4B-00A0C93EC93B
    2 MBR partition scheme           024DEE41-33E7-11D3-9D69-0008C781F39F
    3 Intel Fast Flash               D3BFE2DE-3DAF-11DF-BA40-E3A556D89593
    4 BIOS boot                      21686148-6449-6E6F-744E-656564454649
    ...

    Hex code (type L to list all codes): 4

    Changed type of partition 'Linux filesystem' to 'BIOS boot'.

    Command (m for help): p
    Disk /dev/vdb: 11 GiB, 11811160064 bytes, 23068672 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: 1C6EB8C4-B40A-4C9C-98AE-BA7E33F1A549

    Device        Start      End  Sectors Size Type
    /dev/vdb1      2048 18876415 18874368   9G Linux filesystem
    /dev/vdb2  18876416 18878463     2048   1M BIOS boot

    Command (m for help): w
    The partition table has been altered.
    Calling ioctl() to re-read partition table.

Create a RAID1, in a degraded state as if one of the two disks had been removed:
        
    # apt-get install mdadm

    # mdadm --create /dev/md/lair --level=1 --raid-devices=2 missing /dev/vdb1
    mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
    Continue creating array? y
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md/debian_root started.

    # mdadm --detail /dev/md/lair
    /dev/md/debian_root:
            Version : 1.2
    Creation Time : Mon Sep  4 09:51:57 2017
    Raid Level : raid1
    Array Size : 9428992 (8.99 GiB 9.66 GB)
    Used Dev Size : 9428992 (8.99 GiB 9.66 GB)
    Raid Devices : 2
    Total Devices : 1
    Persistence : Superblock is persistent

    Update Time : Mon Sep  4 09:51:57 2017
            State : clean, degraded
    Active Devices : 1
    Working Devices : 1
    Failed Devices : 0
    Spare Devices : 0

            Name : debian9-vm:lair  (local to host debian9-vm)
            UUID : 9dbcb6f5:988d6450:cbac9699:ee8bb59c
            Events : 0

    Number   Major   Minor   RaidDevice State
    -       0        0        0      removed
    1     254       17        1      active sync   /dev/vdb1

Enter the array in `mdadm.conf`:

    # mdadm --detail --scan | tee --append /etc/mdadm/mdadm.conf
    ARRAY /dev/md/lair metadata=1.2 name=debian9-vm:lair UUID=9dbcb6f5:988d6450:cbac9699:ee8bb59c

I configured mdadm with a monthly scrub, and a monitoring daemon.  Finally,
rebuild the initramfs now we have updated `mdadm.conf`.  Apparently this is
necessary to activate the array at boot time.  (There's an
[alternative approach][dracut-mdadm] if you use Fedora's `dracut` initramfs,
which also ignores the homehost).

[dracut-mdadm]: https://bugzilla.redhat.com/show_bug.cgi?id=1201962
        
    # dpkg-reconfigure mdadm  

The monitoring daemon sends mail if something happens to the array
(by default, to `root`).  This isn't necessarily going to reach you.

For the time being, I redirected `root` mail to my normal user.
Note Debian's MDA does not actually support sending mail to `root`.
It recommends that you always reconfigure you mail server to
redirect it somewhere more sensible.  It asks if you want to
change several other settings, but I left those all alone.
Whenever you have a shell open, Debian will let you know if
you have any unix mail.

    # dpkg-reconfigure exim4-config

Set up LVM on the RAID volume:

    # pvcreate /dev/md/lair
    Physical volume "/dev/md/lair" successfully created.

    # vgcreate vg_lair /dev/md/lair
    Volume group "vg_lair" successfully created

    # lvcreate vg_lair -n lv_debian -L 8G
    Logical volume "lv_debian" created.

    # mkfs.ext4 /dev/mapper/vg_lair-lv_debian
    mke2fs 1.43.4 (31-Jan-2017)
    Creating filesystem with 2097152 4k blocks and 524288 inodes
    Filesystem UUID: 5e90a94c-a5b3-4d14-a5d5-d20d6dd97e2a
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

    Allocating group tables: done 
    Writing inode tables: done 
    Creating journal (16384 blocks): done
    Writing superblocks and filesystem accounting information: done 

Copy the `/` filesystem to the Logical Volume.
(Note that I didn't have any other filesystems).

Ideally you would do this from a live system,
to avoid data changing in the middle of the copy!
You can also shut the system down and enter
"single user mode".  E.g. boot to the GRUB menu,
then edit the line with `linux` / `vmlinuz` to include
`systemd.unit=rescue.target`, before booting it.

    # mount /dev/mapper/vg_lair-lv_debian /mnt
    # time cp -ax /. /mnt/


#### Step 1.5: Adjust the copied system for booting

Chroot into the new system.  Update `/etc/fstab` so it points to the new
device.  I use `/dev/mapper/vg_lair-lv_debian` just because it's convenient.
It should be equally fine to use a UUID.

Make sure fstab doesn't rely on any filesystems OR swap partitions on the old
device.

    # cd /mnt
    # mount --bind /dev dev
    # mount --bind /proc proc
    # mount --bind /sys sys
    # chroot .
    # vi /etc/fstab

Regenerate the GRUB configuration file on the new system,
so it refers to the new device.
        
    # update-grub

Apparently we can ignore this message:

    /usr/sbin/grub-probe: warning: Couldn't find physical volume `(null)'. Some modules may be missing from core image..

as it just means the RAID is degraded.  You will also see

    WARNING: Failed to connect to lvmetad. Falling back to device scanning.

Now we leave the chroot:

    # exit

Next, run os-prober on the original system, and the original GRUB
will pick up the new configuration as an extra item in its boot menu!

    # apt-get install os-prober
    # update-grub

It is also possible to boot into the RAID manually using the GRUB prompt.
This would avoid hacking around with chroot - or you might want to resort
to this if something went wrong.  This requires several more details, and
a specific sequence to ensure that GRUB scans for LVM on the RAID array.
For the latter, see "undocumented bug" above.


### Step 2: Reboot into the new system.

    # lsblk
    NAME                    MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    vda                     254:0    0   11G  0 disk  
    vdb                     254:16   0   11G  0 disk  
    ├─vdb1                  254:17   0    9G  0 part  
    │ └─md127                 9:127  0    9G  0 raid1 
    │   └─vg_lair-lv_debian 252:0    0    8G  0 lvm   /
    └─vdb2                  254:18   0    1M  0 part 

Install GRUB with the new system.  This is what populates
the BIOS boot partition.  At this point you could choose
to only install to the new disk (vdb), keeping the old GRUB
(on vda).  Then you could have two system disks, each
independent of the other.  (Except for what we've done to
mdadm.conf... the Arch Wiki suggests updating that in the
chroot step instead).

    # apt-get install os-prober
    # update-grub
    # dpkg-reconfigure grub-pc

If you had a swap partition which has been moved, you will need
need to regenerate Debian's initramfs.  Otherwise it will look
for hibernation resume image in the wrong place, and there may
be a delay during boot.

    # vi /etc/initramfs-tools/conf.d/resume
    # update-initramfs -u -k all


### Step 3: Overwrite the old system with the RAID

You should double-check that the new system disk you created
is independent.  Try booting with the old disk removed before
continuing.  Then

Replace the old disk's partitioning with GPT, if necessary.

Create a partition for RAID, using the exact same size.
You may be prompted to erase an old filesystem signature.
Also create the necessary BIOS boot partition.

Add the RAID partition.

    # mdadm --add /dev/md/lair /dev/vda1
    mdadm: added /dev/vda1

    # cat /proc/mdstat 
    Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10] 
    md127 : active raid1 vda1[2] vdb1[1]
        9428992 blocks super 1.2 [2/1] [_U]
        [===========>.........]  recovery = 57.4% (5421440/9428992) finish=1.4min speed=46151K/sec
        
    unused devices: <none>

    # cat /sys/class/block/md127/md/sync_speed_max 
    200000 (system)

    # mdadm --detail /dev/md/vg_lair
    /dev/md/vg_lair:
            Version : 1.2
    Creation Time : Mon Sep  4 09:51:57 2017
        Raid Level : raid1
        Array Size : 9428992 (8.99 GiB 9.66 GB)
    Used Dev Size : 9428992 (8.99 GiB 9.66 GB)
    Raid Devices : 2
    Total Devices : 2
        Persistence : Superblock is persistent

        Update Time : Tue Sep  5 12:39:53 2017
            State : clean, degraded, recovering 
    Active Devices : 1
    Working Devices : 2
    Failed Devices : 0
    Spare Devices : 1

    Rebuild Status : 69% complete

            Name : debian9-vm:vg_lair  (local to host debian9-vm)
            UUID : 9dbcb6f5:988d6450:cbac9699:ee8bb59c
            Events : 1035

        Number   Major   Minor   RaidDevice State
        2     254        1        0      spare rebuilding   /dev/vda1
        1     254       17        1      active sync   /dev/vdb1

Finally, make sure GRUB is installed on both disks.

    # dpkg-reconfigure grub-pc

When you test booting with only one disk, remember you will then
need to manually add the disk back again using `mdadm --add`.
Note that this is exactly the same command as before.  It does
not check for a matching RAID superblock.  It will immediately
start overwriting the entire partition.  Type carefully!

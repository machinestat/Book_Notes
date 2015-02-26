---
title: "Linux Structure and Installation"
output: pdf_document
---

**Linux Filesystems**

A **filesystem** is the embodiment of a method of storing and organizing arbitrary collections of data in human-usable form.

**Different Types of Filesystems Supported by Linux**

  * Conventional disk filesystem: $ext2, ext3, ext4, XFS, Btrfs, JFS, NTFS$, etc.
  * Flash storage filesystem: $ubifs JFFS2, YAFFS$, etc.
  * Database filesystems
  * Special purpose filesystem: $procfs, sysfs, tmpfs, debugfs$, etc
  
**Partitions and Filesystems**

A **partition** is a logical part of the disk, whereas a **filesystem** is a method of storing/finding files on a hard disk(usually in a partition). A comparison between filesystems in Windows and Linux is given in the following table:

|                | Windows             |  Linux           |
|:----------------|:-------------------|:-----------------|
|Partition        |Disk1               |/dev/sda1        |
|Filesystem type  |NTFS/FAT32          |EXT3/EXT4/XFS... |
|Mounting Paramters |DriverLetter      |MountPoint        |
|Base Folder where OS is stored |C dirve     | /        |

**The Filesystme Hierarchy Standard**

**Linux** system store their important files according to a standard layout called the **Filesystem Hierarchy Standard**, or **FHS**. This standard ensures that users can move between distributions without having to re-learn how teh system is organized.

**Linux** uses the '/' character to separate paths, and does not have drive letters. New drives are mounted as directories in teh single filesystem, often under */mdeia* . For example, a CD-ROM disc labeled **FEDORA** might end up being found at */media/FEDORA*, and a file **README.txt** on that disc would be at */media/FEDORA/README.txt*.

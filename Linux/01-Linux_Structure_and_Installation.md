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

**The Boot Process**

The Linux **boot process** is the procedure for initializing the system. It consists of everything that happens from when the computer power is first switched on until the user interface is fully operational.

**BIOS-The First Step** 

Starting an **x86**-based Linux system involves a number of steps. When the comuter is powered on, the **Basic Input/Output System (BIOS)** initializes the hardware, including the screen and keyboard, and tests the main memory. This process is also called **POST(Power On Self Test)**.

The BIOS software is stored on a ROM chip on the motherboard. After this, the remainder of the boot process is completely controlled by the operating system.

**Master Boot Records (MBR) and Boot Loader**

Once the **POST** is completed, the system control passes from the **BIOS** to the boot loader. The boot loader is usually stored on one of the hard disks in the system, either in the boot sector (for traditional **BIOS/MBR** system) or the **EFI** partition (for more recent **(Unified) Extensible Firmware Interface** or **EFI/UEFI** systems). Up to this stage, the machine does not access any mass storage media. Thereafter, information on the date, time, and the most important peripherals are loaded from the **CMOS values** (after a techonolgy used for the battery powered memory store - which allows the system to keep track fo the date and time even when it is powered off).

A number of boot loaders exist for Linux; the most common ones are **GRUB** (for **GRand Unified Boot loader**) and **ISOLINUX** (for booting from removeble media). Most Linux boot loaders can present a user interface for choosing alternative options for booting Linux, and even other operating systems that might be installed. When booting Linux, the boot loader is responsible for laoding hte kernel image and the inital RAM disk (which contains some critical files and drivers needed to start the system)into memeory.

**Boot Loader in Action**

The boot loader has two distinct stages:

**First Stage**

For systems using the BIOS/MBR method, the boot loader resides at the first sector of the hard disk also known as the **Master Boot Record(MBR)**. The size of the MBR is just 512 bytes. In this stage, the boot loader examines the partition table and finds a bootable partition. Once it finds a bootable partition, it then searches for the second stage boot loader e.g, **GRUB**, and loads it into **RAM(Random Access Memory)** 

For system using the **EFI/UEFI** method, **UEFI firmware** reads its **Boot Manager** data to determine which **UEFI** application is to be launched and from where(i.e., from which disk and partition the **EFI** partition can be found). The firmware then launches the **UEFI** appplication, for example, **GRUB**, as defined in teh boot entry in the firmware's boot manager. This procedure is more complicated but more versatile than the older MBR methods.

**Second Stage**

The second stage boot loader resides under_/boot_. A **splash screen** is displayed which allows us to choose which Operating System(OS) to boot. After choosing the OS, the boot loader loads the kernel of the selected operating system into RAM and passes control to it.

The boot loader loads the selected kernel image(in the case of Linux) and passes control to it. Kernels are almost always compressed, so its first job is to uncompress itself. After this, it will check and analyze the system hardware and initalize any hardware device drivers built into the kernel.

**The Linux Kernel**

The boot loader loads both the kernel and an inital RAM-based file system(**initramfs**) into memory so it can be used directly by the kernel.

When the kernel is loaded in RAM, it immediately initializes and configures the computer's memeory and also configures all the hardware attached to the system. This includes all processors, I/O subsystems, storage devices, etc. The kernel also laods some necessary uer space applications.


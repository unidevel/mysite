# Fix crash of linux kernel 5.7 in qemu

I installed debian 10 with backports in qemu on my mac laptop, the default kernel is 4.19 which works fine with the command below:
```
qemu-system-x86_64 -m 2048 \
  -smp 2 \
  -display default,show-cursor=on \
  -vga virtio \
  -usb \
  -enable-kvm \
  -device usb-tablet \
  -cdrom ./iso/debian-mac-10.5.0-amd64-netinst.iso \
  -drive file=./fs/debian10.qcow2 \
  -machine accel=hvf \
  -cpu max \
  -net nic,model=virtio \
  -net user,hostfwd=tcp::2222-:22
```

But it crashed after installed kernel 5.7, the boot log is hard to view because of the screen size.

After digging with google, I added the parameter `-serial stdio 
` to qemu and append `console=ttyS0` to linux kernel in grub, so that I can redirect the log to a file. The boot log is: 
```
[    0.114300] .... node  #0, CPUs:      #1
[    0.114419] invalid opcode: 0000 [#1] SMP PTI
[    0.116007] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-0.bpo.2-amd64 #1 Debian 5.7.10-1~bpo10+1
[    0.116007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[    0.116007] RIP: 0010:delay_tsc+0xd/0x60
[    0.116007] Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 ff c8 75 fb 48 ff c8 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 65 44 8b 0d c3 28 5b 50 <0f> 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 11 f3 90 65 8b 35
[    0.116007] RSP: 0000:ffffb8c5c0013dc8 EFLAGS: 00010206
[    0.116007] RAX: ffffffffafa5fb70 RBX: 0000000000000001 RCX: 00000000009e33bc
[    0.116007] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    0.116007] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[    0.116007] R10: ffffffffb0c4a2a0 R11: 0000000000000001 R12: 0000000000000001
[    0.116007] R13: 0000000000000000 R14: 000000000009a000 R15: 0000000000000005
[    0.116007] FS:  0000000000000000(0000) GS:ffff9693bdc00000(0000) knlGS:0000000000000000
[    0.116007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.116007] CR2: ffff969398801000 CR3: 000000005800a001 CR4: 00000000003606f0
[    0.116007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.116007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.116007] Call Trace:
[    0.116007]  native_cpu_up+0x54f/0x820
[    0.116007]  ? cpus_read_trylock+0x40/0x40
[    0.116007]  bringup_cpu+0x2b/0xc0
[    0.116007]  cpuhp_invoke_callback+0x94/0x550
[    0.116007]  ? ring_buffer_record_is_set_on+0x10/0x10
[    0.116007]  _cpu_up+0xa9/0x140
[    0.116007]  cpu_up+0x7b/0xc0
[    0.116007]  bringup_nonboot_cpus+0x4f/0x60
[    0.116007]  smp_init+0x26/0x74
[    0.116007]  kernel_init_freeable+0xd6/0x221
[    0.116007]  ? rest_init+0xaa/0xaa
[    0.116007]  kernel_init+0xa/0x106
[    0.116007]  ret_from_fork+0x35/0x40
[    0.116007] Modules linked in:
[    0.116017] ---[ end trace 490cb2669fed3b7d ]---
[    0.116739] RIP: 0010:delay_tsc+0xd/0x60
[    0.117490] Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 ff c8 75 fb 48 ff c8 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 65 44 8b 0d c3 28 5b 50 <0f> 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 11 f3 90 65 8b 35
[    0.120012] RSP: 0000:ffffb8c5c0013dc8 EFLAGS: 00010206
[    0.120828] RAX: ffffffffafa5fb70 RBX: 0000000000000001 RCX: 00000000009e33bc
[    0.121933] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    0.124012] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[    0.125102] R10: ffffffffb0c4a2a0 R11: 0000000000000001 R12: 0000000000000001
[    0.126183] R13: 0000000000000000 R14: 000000000009a000 R15: 0000000000000005
[    0.127280] FS:  0000000000000000(0000) GS:ffff9693bdc00000(0000) knlGS:0000000000000000
[    0.128013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.128923] CR2: ffff969398801000 CR3: 000000005800a001 CR4: 00000000003606f0
[    0.130023] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.131113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.132028] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.133431] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
```

It seems that the CPU settings caused this issue, after tried with several types listed by command `qemu -cpu help`, finally found a usable type - `-cpu qemu64`, the final workable command is as below:

```
qemu-system-x86_64 -m 2048 \
  -smp 2 \
  -display default,show-cursor=on \
  -vga virtio \
  -usb \
  -enable-kvm \
  -device usb-tablet \
  -cdrom ./iso/debian-mac-10.5.0-amd64-netinst.iso \
  -drive file=./fs/debian10.qcow2 \
  -machine accel=hvf \
  -cpu qemu64 \
  -net nic,model=virtio \
  -net user,hostfwd=tcp::2222-:22 \
  -serial stdio 
```




---
layout: post
date:   2018-04-21 17:00:00 +0100
title:  "Bug hunting part 1: coredumps"
---

I want to write about my experience with [Fedora bug report 1553979](https://bugzilla.redhat.com/show_bug.cgi?id=1553979). This post introduces the coredump. I plan to show how useful this was in a future post.

> 2018-03-10<br>
> Xwayland server crashes unexpectedly.<br>
> [https://retrace.fedoraproject.org/faf/reports/2055378/](https://retrace.fedoraproject.org/faf/reports/2055378/)

The link here goes to a backtrace, captured by [ABRT](https://abrt.readthedocs.io/en/latest/howitworks.html) and submitted to "[Fedora Analysis Framework](https://retrace.fedoraproject.org/faf/)". In other words, it shows the chain of function calls leading to the crash.

Unfortunately the information we see in FAF is relatively basic. It's mostly useful for collecting statistics, like what the most common crashes are, as opposed to analyzing exactly why a crash happened.

*Ideally,* the ABRT app which pops up in Gnome is expected to let users submit a fully detailed report in the Fedora bug database. ABRT saves a "coredump", which includes most of the processes memory, and additional data e.g. about what files it has open. I think it never publishes the coredump online, but it uses it to generate a `bt full` backtrace. This full backtrace includes values of parameters and local variables for each function. ABRT checks with the user if this includes private information, before submitting the backtrace and additional data to the bug database. It also asks the user what they were doing that might have caused the crash.

This full backtrace was not included in this initial bug report, however.

In some cases, even though ABRT was able to generate a backtrace for FAF statistics, it fails some check. ABRT decides that there is not enough information to be useful, so it avoids creating a detailed report in the bug database. I don't really know how this works. I think one case may be if a debuginfo package for the crashing program is not available, because the installed version of the program is older than the currently available one.

What I do know is that the ABRT app will still show the link to the FAF backtrace, as "Reports: [ABRT Server](https://retrace.fedoraproject.org/faf/reports/2055378/)". This means when some determined users are repeatedly unable to get ABRT create a bug report, they might go to the Fedora bug database, create a bug report themselves, and include a link to the FAF report. Xwayland is quite a critical process, so it's not surprising if our user was determined to report this crash.

The user seems in luck, as a Fedora developer appears and examines their report.

For some reason this particular FAF backtrace is even missing all the interesting line numbers. The developer had to [reconstruct them by looking for a plausible call chain](https://bugzilla.redhat.com/show_bug.cgi?id=1553979#c4). This still didn't pin down the problem, so they asked for a full backtrace.

It might have been possible to extract this from ABRT. However the suggested method was to use the original coredump saved by `systemd-coredump`. 

> Xwayland generate a core file in case of a crash, could you please provide a full backtrace from that core file?
> 
> 1. Make sure you have the debuginfo installed.
>    `dnf debuginfo-install xorg-x11-server-Xwayland`
> 2. Use `coredumpctl list` to get the list of available core files.
> 3. Find the one for Xwayland in the list
> 4. Use `coredumpctl gdb <pid>` to attach gdb to that core file
> 5. Run `bt full` and post the output in this bug.

Note that both ABRT and `systemd-coredump` will delete old coredumps to avoid taking up too much disk space. Fortunately it's not hard to make your own copy, e.g. `coredumpctl dump <pid> -o 2018-03-10-X.core`.

---
## Basic backtrace in the FAF report

<table>
    <tr>
    <th>Frame #</th>
    <th>Function</th>
      <th>Binary</th>
    <th>Source or offset</th>
    <th>Line</th>
  </tr>
    <tr>
      <td>
  1
</td>
<td>
    _dl_fixup
</td>
  <td>/lib64/ld-linux-x86-64.so.2</td>
<td>
    <abbr title="0x102f9 Build id: 0fbfb698fb8e...">../elf/dl-runtime.c</abbr>
</td>
<td>
      73
</td>
    </tr>
    <tr>
      <td>
  2
</td>
<td>
    _dl_runtime_resolve_xsave
</td>
  <td>/lib64/ld-linux-x86-64.so.2</td>
<td>
    <abbr title="0x181ba Build id: 0fbfb698fb8e...">../sysdeps/x86_64/dl-trampoline.h</abbr>
</td>
<td>
      126
</td>
    </tr>
    <tr>
      <td>
  3
</td>
<td>
    xorg_backtrace
</td>
  <td>/usr/bin/Xwayland</td>
<td>
    0x18e2cd
      <br/>Build id: 6ff16da59898...
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  4
</td>
<td>
    OsSigHandler
</td>
  <td>/usr/bin/Xwayland</td>
<td>
    0x191eb9
      <br/>Build id: 6ff16da59898...
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  5
</td>
<td>
    __restore_rt
</td>
  <td>/lib64/libpthread.so.0</td>
<td>
    <abbr title="0x12af0 Build id: f0701f554a92e5dc038f2f34118ca5e186824d27">??</abbr>
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  6
</td>
<td>
</td>
  <td>/usr/bin/Xwayland</td>
<td>
    0x120010
      <br/>Build id: 6ff16da59898...
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  7
</td>
<td>
    XkbDeviceApplyKeymap
</td>
  <td>/usr/bin/Xwayland</td>
<td>
    0x123e5c
      <br/>Build id: 6ff16da59898...
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  8
</td>
<td>
    CopyKeyClass
</td>
  <td>/usr/bin/Xwayland</td>
<td>
    0xfd052
      <br/>Build id: 6ff16da59898...
</td>
<td>
    -</td>
    </tr>
    <tr>
      <td>
  ...
</td>
<td>
    ...
</td>
  <td>...</td>
<td>
    ...
</td>
<td>
    ...</td>
    </tr>
</table>

## Full backtrace

{% comment %}
1. Markdown preformat section - escapes HTML special chars.
2. Liquid raw section - escapes double curly braces (nested C structs).
{% endcomment %}
{% raw %}
    $ coredumpctl gdb 1564


            PID: 1564 (Xwayland)
            UID: 1000 (brent)
            GID: 1000 (brent)
            Signal: 7 (BUS)
        Timestamp: Mon 2018-03-12 18:25:20 EDT (20min ago)
    Command Line: /usr/bin/Xwayland :0 -rootless -terminate -core -listen 4 -listen 5 -displayfd 6
        Executable: /usr/bin/Xwayland
    Control Group: /user.slice/user-1000.slice/session-2.scope
            Unit: session-2.scope
            Slice: user-1000.slice
        Session: 2
        Owner UID: 1000 (brent)
        Boot ID: be21250582a341c8b4247ba353e39375
        Machine ID: 0578ab4b5f19406598a5d8ea512ba7a0
        Hostname: brent-laptop
        Storage: /var/lib/systemd/coredump/core.Xwayland.1000.be21250582a341c8b4247ba353e39375.1564.1520893520000000.lz4
        Message: Process 1564 (Xwayland) of user 1000 dumped core.
    ...

    GNU gdb (GDB) Fedora 8.0.1-36.fc27
    Copyright (C) 2017 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
    and "show warranty" for details.
    This GDB was configured as "x86_64-redhat-linux-gnu".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <http://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.
    For help, type "help".
    Type "apropos word" to search for commands related to "word"...
    ...

    Core was generated by `/usr/bin/Xwayland :0 -rootless -terminate -core -listen 4 -listen 5 -displayfd'.
    Program terminated with signal SIGBUS, Bus error.
    #0  0x00007f6f027b42f9 in _dl_fixup () from /lib64/ld-linux-x86-64.so.2
    [Current thread is 1 (Thread 0x7f6f02997a80 (LWP 1564))]
    ...

    (gdb) bt full
    #0  0x00007f6f027b42f9 in _dl_fixup () from /lib64/ld-linux-x86-64.so.2
    No symbol table info available.
    #1  0x00007f6f027bc1ba in _dl_runtime_resolve_xsave () from /lib64/ld-linux-x86-64.so.2
    No symbol table info available.
    #2  0x000000000058e2cd in xorg_backtrace () at backtrace.c:56
    ...

    #3  0x0000000000591eb9 in OsSigHandler (signo=7, sip=0x7fff5f5c43f0, unused=<optimized out>) at osinit.c:136
            unused = <optimized out>
            sip = 0x7fff5f5c43f0
            signo = 7
    #4  <signal handler called>
    No symbol table info available.
    #5  XkbCopyKeymap (dst=0x12df5c0, src=0x13e0fd0) at xkbUtils.c:1957
    No locals.
    #6  0x0000000000523e5c in XkbCopyKeymap (src=<optimized out>, dst=<optimized out>) at xkbUtils.c:1965
    No locals.
    #7  XkbDeviceApplyKeymap (dst=dst@entry=0x137ebb0, desc=<optimized out>) at xkbUtils.c:2025
            nkn = {type = 0 '\000', xkbType = 0 '\000', sequenceNumber = 0, time = 0, deviceID = 3 '\003', oldDeviceID = 3 '\003', minKeyCode = 8 '\b', 
            maxKeyCode = 255 '\377', oldMinKeyCode = 8 '\b', oldMaxKeyCode = 255 '\377', requestMajor = 135 '\207', requestMinor = 9 '\t', 
            changed = 3, detail = 0 '\000', pad1 = 0 '\000', pad2 = 0, pad3 = 0, pad4 = 0}
            ret = <optimized out>
    #8  0x00000000004fd052 in CopyKeyClass (device=device@entry=0x1391c50, master=master@entry=0x137ebb0) at exevents.c:233
            mk = <optimized out>
    #9  0x00000000004fd45a in DeepCopyKeyboardClasses (to=0x137ebb0, from=0x1391c50) at exevents.c:427
            classes = <optimized out>
    #10 DeepCopyDeviceClasses (from=0x1391c50, to=0x137ebb0, dce=0x7fff5f5c5580) at exevents.c:670
    No locals.
    #11 0x0000000000500446 in ChangeMasterDeviceClasses (device=0x137ebb0, dce=0x7fff5f5c5580) at exevents.c:727
            slave = 0x1391c50
            rc = <optimized out>
    #12 0x0000000000500684 in UpdateDeviceState (device=0x137ebb0, event=0x7fff5f5c5580) at exevents.c:807
    No locals.
    #13 0x0000000000500b1c in ProcessDeviceEvent (ev=ev@entry=0x7fff5f5c5580, device=device@entry=0x137ebb0) at exevents.c:1709
            grab = <optimized out>
            deactivateDeviceGrab = 0
            key = 0
            rootX = 0
            rootY = 5056574
            b = <optimized out>
            ret = 0
    ---Type <return> to continue, or q <return> to quit---
            corestate = 16
            mouse = 0x137e430
            kbd = 0x137ebb0
            event = 0x7fff5f5c5580
            __func__ = "ProcessDeviceEvent"
    #14 0x0000000000501353 in ProcessOtherEvent (ev=0x7fff5f5c5580, device=0x137ebb0) at exevents.c:1873
    No locals.
    #15 0x000000000052e6f2 in ProcessKeyboardEvent (ev=<optimized out>, keybd=0x137ebb0) at xkbPrKeyEv.c:165
            keyc = <optimized out>
            xkbi = 0x0
            backup_proc = 0x52e690 <ProcessKeyboardEvent>
            event = <optimized out>
            is_press = <optimized out>
            is_release = <optimized out>
    #16 0x0000000000470e83 in mieqProcessDeviceEvent (dev=0x1391c50, event=0x7f6f02894010, screen=0x8736c0) at mieq.c:496
            handler = 0x0
            master = 0x137ebb0
            mevent = {any = {header = 255 '\377', type = ET_DeviceChanged, length = 3088, time = 33557482}, device_event = {header = 255 '\377', 
                type = ET_DeviceChanged, length = 3088, time = 33557482, deviceid = 3, sourceid = 10, detail = {button = 3, key = 3}, touchid = 5, 
                root_x = 0, root_x_frac = 0, root_y = 0, root_y_frac = 0, buttons = '\000' <repeats 31 times>, valuators = {mask = "\000\000\000\000", 
                mode = "\000\000\000\000", data = {0 <repeats 36 times>}}, mods = {base = 0, latched = 0, locked = 16, effective = 16}, group = {
                base = 0 '\000', latched = 0 '\000', locked = 0 '\000', effective = 0 '\000'}, root = 0, corestate = 0, key_repeat = 0, flags = 0, 
                resource = 0, source_type = EVENT_SOURCE_NORMAL}, changed_event = {header = 255 '\377', type = ET_DeviceChanged, length = 3088, 
                time = 33557482, deviceid = 3, flags = 10, masterid = 3, sourceid = 5, buttons = {num_buttons = 0, names = {0 <repeats 89 times>, 16, 
                    16, 0 <repeats 165 times>}}, num_valuators = 0, valuators = {{min = 0, max = 0, value = 0, resolution = 0, mode = 0 '\000', 
                    name = 0, scroll = {type = SCROLL_TYPE_NONE, increment = 0, flags = 0}} <repeats 36 times>}, keys = {min_keycode = 8, 
                max_keycode = 255}}, touch_ownership_event = {header = 255 '\377', type = ET_DeviceChanged, length = 3088, time = 33557482, 
                deviceid = 3, sourceid = 10, touchid = 3, reason = 5 '\005', resource = 0, flags = 0}, barrier_event = {header = 255 '\377', 
                type = ET_DeviceChanged, length = 3088, time = 33557482, deviceid = 3, sourceid = 10, barrierid = 3, window = 5, root = 0, dx = 0, 
                dy = 0, root_x = 0, root_y = 0, dt = 0, event_id = 0, flags = 0}, dga_event = {header = 255 '\377', type = ET_DeviceChanged, 
                length = 3088, time = 33557482, subtype = 3, detail = 10, dx = 3, dy = 5, screen = 0, state = 0}, raw_event = {header = 255 '\377', 
                type = ET_DeviceChanged, length = 3088, time = 33557482, deviceid = 3, sourceid = 10, detail = {button = 3, key = 3}, valuators = {
                mask = "\000\000\000\000", data = {0 <repeats 36 times>}, data_raw = {0, 0, 0, 0, 0, 0, 0, 0, 3.3951932663349407e-313, 
                    0 <repeats 27 times>}}, flags = 0}}
    #17 0x0000000000470f52 in mieqProcessDeviceEvent (dev=<optimized out>, event=<optimized out>, screen=<optimized out>) at mieq.c:498
    No locals.
    ---Type <return> to continue, or q <return> to quit---
    #18 0x000000000048af20 in ProcXTestFakeInput (client=0x1594bf0) at xtest.c:429
            stuff = <optimized out>
            nev = <optimized out>
            n = <optimized out>
            type = 2
            rc = <optimized out>
            ev = <optimized out>
            dev = 0x1391c50
            root = 0xd
            extension = <optimized out>
            mask = {last_bit = -64 '\300', has_unaccelerated = -75 '\265', mask = "\257\001\000\000", valuators = {6.9225881497604434e-310, 
                4.3607893962518447e-317, -4.491207147667509e-276, 4.4606025142872766e-317, 1.2164552319789167e-316, 4.4606025142872766e-317, 
                1.5918980907331739e-314, 6.9532226533363779e-310, 2.121995791459338e-314, 8.0947715414629834e-320, 6.9225834135790307e-310, 
                1.2164611607666668e-316, 4.5198982968385597e-317, 0, 4.4605432264097757e-317, 4.4605471789349424e-317, 8.0947715414629834e-320, 
                8.0947715414629834e-320, 6.922583570139096e-310, 1.5644421373077814e-313, 2.121995791459338e-314, 5.434722104253712e-323, 
                4.9406564584124654e-324, 4.4605471789349424e-317, 6.9225889864614051e-310, 8.7047935248276338e-315, 4.4571598648670548e-317, 0, 
                6.9225834162688723e-310, 6.9225889939945229e-310, 6.9225889864614051e-310, 0, 8.624169605215319e-315, 0, 6.9225834162925381e-310, 
                6.9225889864614051e-310}, unaccelerated = {3.9525251667299724e-323, 4.9406564584124654e-324, 6.9225834207602749e-310, 
                7.9045100232696527e-315, 1.5810100666919889e-322, 6.1890378171731268e-317, 4.9406564584124654e-324, 1.9762625833649862e-322, 0, 0, 
                1.3255237805710219e-318, 0, 0, 1.5810100666919889e-322, -4.491207147667509e-276, 1.3978374023851885e-316, 6.9225889864614051e-310, 
                4.3781014564821219e-317, 6.9532226533563381e-310, 4.2527945511212816e-317, 6.9225890235799642e-310, 4.2342453505138179e-317, 
                6.9225834140264566e-310, 6.2153458246828815e-317, 2.8914169206972063e-317, 0, -4.491207147667509e-276, 0, 1.1180389363374071e-316, 
                1.1046604291530595e-316, 1.9762625833649862e-323, 1.1186816169295174e-316, 6.4228533959362051e-323, 0, 2.8835192813484339e-317, 
                2.1388652953517468e-314}}
            valuators = {0 <repeats 36 times>}
            numValuators = 0
            firstValuator = <optimized out>
            nevents = <optimized out>
            i = <optimized out>
            base = <optimized out>
            flags = 0
            need_ptr_update = <optimized out>
    #19 0x0000000000558208 in Dispatch () at dispatch.c:479
            result = <optimized out>
            start_tick = 287420
    #20 0x000000000055c250 in dix_main (argc=11, argv=0x7fff5f5c66b8, envp=<optimized out>) at main.c:287
    ---Type <return> to continue, or q <return> to quit---
            i = <optimized out>
            alwaysCheckForInput = {0, 1}
    #21 0x00007f6eff65400a in __libc_start_main () from /lib64/libc.so.6
    No symbol table info available.
    #22 0x0000000000422aaa in _start ()
    No symbol table info available.
{% endraw %}

---

> This post was written using [StackEdit](https://stackedit.io/).


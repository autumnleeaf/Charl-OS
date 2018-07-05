# Charl-OS
I'm building an operating system from scratch because I want to learn new things. I'm starting to think I'm a masochist...

## Requirements
Development of the operating system requires Netwide Assembler (nasm) and a cpu emulator (I'm using QEmu). These can be installed on Mac OSX or Linux following the instructions below:

Mac OSX (Through Homebrew):
```
brew install nasm qemu
```

Linux (using apt):
```
sudo apt-get update
sudo apt-get install nasm qemu
```
> Install instructions should be similar for non debian based distros.

The operating system may also be run in other cpu emulators such as Bochs, virtual machines such as VMWare or VirtualBox, or any computer after formatting it onto a boot disk. Virtual machines and running as a host OS are better optimized ways of running the OS; however, it takes longer to set up the OS in these environments, so for development purposes I strongly reccomend using an emulator.

## Building and Running
The main .asm file that needs to be compiled is `boot_sector.asm`, this can be done with the following command:
```
nasm boot_sector.asm -f bin -o boot_sector.bin
```
> Replace 'boot_sector.bin' with whatever you want the binary to be called

To run this with qemu (assuming you are running the latest version), use the command:
```
qemu-system-x86_64 boot_sector.bin
```
> If you named your binary something different, use that name instead

## Resources and Inspirations
* https://github.com/cfenollosa/os-tutorial
* http://www.cs.bham.ac.uk/%7Eexr/lectures/opsys/10_11/lectures/os-dev.pdf
* https://github.com/pervognsen/bitwise
* https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
* https://wiki.osdev.org/Main_Page
* https://littleosbook.github.io/
* https://web.archive.org/web/20160412174753/http://www.jamesmolloy.co.uk/tutorial_html/index.html
* https://www.reddit.com/r/osdev/

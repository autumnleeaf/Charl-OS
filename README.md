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

## Resources and Inspirations
* https://github.com/cfenollosa/os-tutorial
* http://www.cs.bham.ac.uk/%7Eexr/lectures/opsys/10_11/lectures/os-dev.pdf
* https://github.com/pervognsen/bitwise

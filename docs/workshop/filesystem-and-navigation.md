## Navigation & exploration
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- http://www.yourownlinux.com/2014/01/linux-ls-command-tutorial-with-examples.html -->
<!-- https://linuxize.com/post/linux-cd-command/ -->
<!-- https://automaticaddison.com/the-complete-guide-to-linux-fundamentals-for-robotics/#navigate_folders -->

Let's start with looking around:

```
$ ls   
```

Now let's move into one of these directories:
```
$ cd ...
```

```
pwd
```

### Directories with spaces

Easy: 

```
cd "Directory with a space or two in the name"
```
```
cd Directory\ with\ a\ space\ or\ two\ in the name"
```


## The file system
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!--  https://www.linux.com/training-tutorials/linux-filesystem-explained/ -->
Let's look how the root directory is organized:

```
user@Ubuntu:~/# ls /

bin/   dev/  home/       init@  lib64/  opt/   root/  sbin/  tmp/  var/
boot/  etc/  hugetlbfs/  lib/   mnt/    proc/  run/   sys/   usr/
```
![Linux file system topology (Credit: Linux.com)](../assets/images/linux-topology.png)


## File manipulation

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://automaticaddison.com/the-complete-guide-to-linux-fundamentals-for-robotics/#create_folders -->

```
$ cat
```
```
$ cp
```
```
$ touch
```
```
$ mkdir
```
```
$ mkdir -P
```
## Exercise

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!--  -->
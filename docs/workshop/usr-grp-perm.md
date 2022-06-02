Let's start this section of the workshop with something extremely daring: peaking into the `/root` directory! Type the following command:
```
$ ls /root
ls: cannot open directory '/root/': Permission denied
```
What the heck?!

## Permissions
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxfoundation.org/blog/classic-sysadmin-understanding-linux-file-permissions/ -->

Inspect the output of the following command:
```
$ ls /
total 1584
drwxr-xr-x   2 root root    4096 Oct 29  2021 bin
drwxr-xr-x   2 root root    4096 Aug 21  2020 boot
drwxr-xr-x   9 root root    2900 Jun  1 09:06 dev
drwxr-xr-x 122 root root   12288 Jun  1 09:06 etc
drwxr-xr-x   3 root root    4096 Jan 12  2021 home
-rwxr-xr-x   4 root root 1392928 Oct 27  2021 init
drwxr-xr-x  20 root root    4096 Jan 19  2021 lib
drwxr-xr-x   2 root root    4096 Jan 19  2021 lib64
drwx------   2 root root   16384 Apr 10  2019 lost+found
drwxr-xr-x   2 root root    4096 Aug 21  2020 media
drwxr-xr-x   5 root root    4096 Oct 26  2021 mnt
drwxr-xr-x   3 root root    4096 Jan 20  2021 opt
dr-xr-xr-x 344 root root       0 Jun  1 09:06 proc
drwx------   4 root root    4096 May  4 11:25 root
drwxr-xr-x   7 root root     200 Jun  2 14:27 run
drwxr-xr-x   2 root root   12288 Oct 29  2021 sbin
drwxr-xr-x   2 root root    4096 Jul 10  2020 snap
drwxr-xr-x   2 root root    4096 Aug 21  2020 srv
dr-xr-xr-x  11 root root       0 Jun  1 09:06 sys
drwxrwxrwt  44 root root  126976 Jun  2 19:54 tmp
drwxr-xr-x  12 root root    4096 Aug 25  2021 usr
drwxr-xr-x  13 root root    4096 Aug 21  2020 var
```
What is all this information?

We are going to take the `/home` directory from this list and analyze it:
```
drwxr-xr-x   3 root root    4096 Jan 12  2021 home
```
![https://www.liquidweb.com](../assets/images/permissions.png)


Try executing the following command:
```
apt install sl
```

What is the outcome?

Now try with an elevated user:
```
sudo apt install sl
```
## Users & Groups

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://www.linux.com/topic/desktop/how-manage-users-groups-linux/ -->
```
sudo useradd
```

```
addgroups readers
```

```
sudo usermod -a -G ...
```

## Exercise
1. Create a user for your neighbor
2. Let the neighbor chose their password (use simple passwords, used for this exercise)
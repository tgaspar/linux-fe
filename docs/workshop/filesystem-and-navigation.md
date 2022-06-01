Now that you're familiar with the terminal we can step back into the desktop environment:
- Press `Ctrl+Alt+F7`

Tadaaah, we are welcomed by a friendly beaver:

![Linux desktop](../assets/images/linux-desktop.png)

Sadly, we are going back to the terminal. This time, however, we are going to do it within the desktop environment. To open up the terminal you press the following keys: `Ctrl+Alt+T`. We can now proceed with the next chapter of this workshop.
## Navigation & exploration
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- http://www.yourownlinux.com/2014/01/linux-ls-command-tutorial-with-examples.html -->
<!-- https://linuxize.com/post/linux-cd-command/ -->
<!-- https://automaticaddison.com/the-complete-guide-to-linux-fundamentals-for-robotics/#navigate_folders -->

In the previous chapter we learned how to interact with the command line and we learned our first two commands. Let's now learn how to navigate around the Linux file system.

We start this by looking around:

```
$ ls
Documents  examples.desktop  Music  Public  Desktop  Downloads  Pictures  Templates  Videos
```
The `ls` command listed something. What did it list?

That's right, these are all (non-hidden) directories. However, **where** are all of these directories? Where are we?! Let's find this out by `p`rinting the `w`orking `d`irecotry - `pwd`:
```
$ pwd
/home/user
```
Helpful, right? We explain what this directory is in one of the chapters below. For now, let's try to move into one of the directories that we saw before:

```
$ cd Desktop
```

As the name suggests, this is the directory that contains all the files that you can see on the desktop.

> **Questions**: what do you expect to see if you now execute the `pwd` command?


## The file system
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!--  https://www.linux.com/training-tutorials/linux-filesystem-explained/ -->
As promised before we will now look into how the Linux file system (Ubuntu, to be precise) is organized.

Type the following command and observe the output:
```
user@Ubuntu:~/# ls /

bin   etc  lib    lost+found  mnt     proc  run   snap  sys  usr  vmlinuz
boot  dev  home   lib64       media   opt   root  sbin  srv  tmp  var
```

You invoked the `ls` command in the root directory of the operating system - `/`. What you're seeing are the directories that reside in the root directory of the operating system. The image below provides nice summary of all of the the important directories and their sub-directories (credit: Linux.com):

![Linux file system topology (Credit: Linux.com)](../assets/images/linux-topology.png)

## File manipulation

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://automaticaddison.com/the-complete-guide-to-linux-fundamentals-for-robotics/#create_folders -->
> **Note**: It is assumed that we are in the `/home/user/Desktop` directory.

Let us now work with files (finally, huh?)! We will start by creating a simple and completely empty file:
```
$ touch file
```
If nothing majorly went wrong, you can see the file by listing the contents of the directory:
```
$ ls
file
```
We can now make a copy of this file and call it `file2` with the `c`o`p`y command - `cp`:
```
$ cp file file1
```
The above command tells to make a copy of `file` (which we created earlier) into another file called `file2`.

We can again inspect the contents of the directory:
```
$ ls
file  file2
```
Good! We now have too files. By the way, you should also be able to see these two files on your desktop. If not, you're probably in the wrong directory!

We now have two files, `file` and `file2`. That's not too pretty and neither is it consistent. What if we want to have `file1` and `file2`? Simple! We will `m`o`v`e `file` into `file1` with the `mv` command:
```
$ mv file file1
```
Invoking the `ls` command:
```
$ ls
file1  file2
```
Ahhh, much better!
## Directory manipulation

So far we've explored how to create a file (`touch`), copy a file (`cp`) and rename/move a file (`mv`). But how about directories?

We can `m`a`k`e a new `dir`ectory with the `mkdir` command:
```
$ mkdir directory
```
Again, we inspect the content of our working directory and see
```
$ ls
directory  file1  file2
```
We can now move into the newly created directory called `directory`:
```
$ cd directory
```
Since this directory has just been created, we won't be listing it's contents. It's empty. However, let's step back into the directory we came from:
```
cd ..
```
> **Note**: The `..` represents one directory before the current working directory. It can be used with all Linux commands, like `ls ..`.

We should now try to create a directory within a directory. Let's inspect the help of `mkdir`:
```
mkdir --help
Usage: mkdir [OPTION]... DIRECTORY...
Create the DIRECTORY(ies), if they do not already exist.

Mandatory arguments to long options are mandatory for short options too.
  -m, --mode=MODE   set file mode (as in chmod), not a=rwx - umask
  -p, --parents     no error if existing, make parent directories as needed
  -v, --verbose     print a message for each created directory
  -Z                   set SELinux security context of each created directory
                         to the default type
      --context[=CTX]  like -Z, or if CTX is specified then set the SELinux
                         or SMACK security context to CTX
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Report mkdir translation bugs to <http://translationproject.org/team/>
Full documentation at: <http://www.gnu.org/software/coreutils/mkdir>
or available locally via: info '(coreutils) mkdir invocation'
```
There it is! It's the `-p` flag!

```
$ mkdir -p parent/child
```
Inspecting the contents of the `parent` directory reveals that `child` was created too:
```
$ ls parent
child
```
> **Note**: Without `-p` the above command would fail with the following error: `mkdir: cannot create directory ‘parent/child’: No such file or directory`.

### Directories with spaces

For this exercise we are going to use the desktop environment. Right-click on the desktop and create a directory and call it `dir with space`.

Make sure you are in the `~/Desktop` working directory:
```
$ cd ~/Desktop
```
From here, try to navigate to our newly created `dir with space` directory:
```
$ cd dir with space
```
Does it work? Of course not.

For this to work, we need to use escape characters. The reason behind this is, that otherwise `cd` simply things you are feeding it (in this case) 3 different arguments: `dir`, `with` & `space`. In Linux, `\` is the escape character. Let's try to use it:
```
$ cd dir\ with\ space
```
Worked like charm!

## Exercise

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!--  -->
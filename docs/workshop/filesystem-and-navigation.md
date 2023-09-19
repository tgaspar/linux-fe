Now that you're familiar with the terminal we can step back into the desktop environment:
- Press `Ctrl+Alt+F2`

Tadaaah, we are welcomed by a friendly beaver:

![Linux desktop](../assets/images/linux-desktop.png)

Sadly, we are going back to the terminal. This time, however, we are going to do it within the desktop environment. To open up the terminal you press the following keys: `Ctrl+Alt+T`. We can now proceed with the next chapter of this workshop.

## Tips and tricks within the Ubuntu desktop environment

There are a tricks that one should know when working with the Ubuntu desktop environment. We will go through this briefly but you can always look back into here for reference.
### The clipboard

We can do the copy-paste operation without pressing any keys on the keyboard. By simply selecting a certain text with our cursor (i.e. mouse) and then pressing the **left mouse button**, the text will go into the clipboard. To paste it, we press the **middle mouse button**. Additionally, text can be pasted also with the `Shift + Insert` key combination.

### Settings

To access the general operating system settings we click on the top-right down-pointing triangle and then clicking on the wrench-screwdriver looking icon:

![The settings button is on the left](../assets/images/ubuntu-settings.png)

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

> **Note**: Look at the help of the `ls` command to learn more about it.

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
As promised before, we will now look into how the Linux file system (Ubuntu, to be precise) is organized.

Type the following command and observe the output:
```
user@Ubuntu:~/# ls /

bin   etc  lib    lost+found  mnt     proc  run   snap  sys  usr  vmlinuz
boot  dev  home   lib64       media   opt   root  sbin  srv  tmp  var
```

You invoked the `ls` command in the root directory of the operating system - `/`. What you're seeing are the directories that reside in the root directory of the operating system. The image below provides nice summary of all of the the important directories and their sub-directories (credit: Linux.com):

![Linux file system topology (Credit: Linux.com)](../assets/images/linux-topology.png)

### Notable directories

#### `/home`

The `/home` directory contains the home directories of all of the "human" users on the operating system. For instance, if we are sharing the computer with another user, their home directory will be `/home/another-user`.

#### `/opt`

This is directory where the optional software application files are found. For instance, if we follow the instructions how to install Zoom it will eventually create the relevant binary files in the `/opt/zoom` directory.

> **Note**: Also the Robot Operating System (ROS) is installed in `/opt`. Depending on the distribution, for `melodic` it's installed in `/opt/ros/melodic`.

#### `/dev`

The `/dev` directory is used to contain all the device files. These are not "files for the devices". No, these are devices represented as files. Everything is a file in Linux, even devices. When working with robots, we often plug USB cameras into our computer. These cameras are typically represented as `/dev/video0` (the `0` depends on how many cameras there are).

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

Create a new file and give it a very random name. For instance, `aksdjasdjasd`:
```
$ touch aksdjasdjasd
```

List all the files in the directory and lay your eyes on your newly created abomination:
```
$ ls
file1  file2  aksdjasdjasd
```

We should clear it up, right? Let's `r`e`m`ove the file with the `rm` command:
```
$ rm aksdjasdjasd
```

If you now list the files in this directory you will see that order was restored. Hooraay!

### Auto-completion with the `Tab` key
You probably found typing the randomly created name rather tedious. Linux of course does not want you to spend time to type tedious names. For this reason, Linux supports auto-completion by hitting the `Tab` key.

Let's repeat the above example of creating a random file and removing it. This time, try typing the first 3 letters and then hit tab. You will see that the terminal wrote the name of the file for you.

Aut-completion with the `Tab` key works on almost everything in Linux: navigation directories, listing files, completing commands, etc. Use it!

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

### Removing/deleting directories

We learned how to remove files with `rm`. This command can also be used to remove directories. However, this command does not allow as to remove directories just like that. It's a safety feature. To remove directories, we need to use `rm` with some additional flags. Let's check the help of `rm` section:

```
$ rm --help
```

In there you will see following line:
```
...
  -r, -R, --recursive   remove directories and their contents recursively
...
```

Let's try this out by creating a new set of directories and then deleting them:

```
$ mkdir -p remove/delete/me
```

Now try to delete all of them by removing the parent directory `remove` with the `rm` command:
```
$ rm -r remove
```

> **Note**: Sometimes, this might not be enough because there might be some files in the directory. If you check the help section of `rm` again, you will see there is a `-f` flag. This stands for `force`. Use this when in doubt.

## Exercise

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!--  -->

1. Without leaving the `Desktop` directory, create the following directory hierarchy in `/home/user/Documents`: `Workshops/Linux FE`. **Note**: Your username might not be `user` but something else. That means, that the path to your `Documents` directory might be a little bit different.

2. Without leaving the `Desktop` directory, create a file in the newly created directory called `morning.txt`.

3. Move to the newly created directory and delete all the clutter we've made on the `Desktop`.
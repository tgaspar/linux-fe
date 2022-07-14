## Installing programs

By now we have explored a "few" very handy programs that are available by default in Linux. With them we learned how to do many useful operations, even combining them. In this section, we will learn how to install cool new programs on your Linux machine. We will focus on programs that are available through some sort of package management, which means we won't need to compile them.

### Advance package tool - `apt`

When we stumble upon a new cool program or tool for Linux and look at the install instructions we typically see something like this: `sudo apt-get install ...`. The `apt-get` is a package manager pre-installed on Ubuntu.

> **Note**: Some other Linux distributions may  use other package managers, e.g. `pacman`or `rpm`.

Let's give this command a try and see how it works. We will now install our first ever program. You can be sure that it will not be useful but it will for sure make you smile (and curse when you execute the command accidentally):
```
$ sudo apt-get install sl -y
```

> **Note**: The `-y` flag instructs `apt-get` that we are sure we want to install this. Otherwise it might ask for confirmation. In that case we type `y` and press `Enter`.

After some rumbling, `sl` was installed. You can try it out and have a few giggles. Try it with the `-al` flags, you will see the little guys screaming for help.

To uninstall a program, we use can use either `apt-get remove` or `apt-get purge`. The latter will also delete all of the configuration files.

Let's try it out and remove `sl`:
```
$ sudo apt-get remove sl
```

Excellent! You now know how to install and remove programs using `apt-get`. What you don't know yet though is how did `apt-get` understand where to get `sl` and how to install it. We will try to provide a short explanation shedding some light on this.

When we request a program to be installed with `apt-get` it will look for an **exact** match on the Ubuntu repositories. If you look back and the stream of text that got printed when installing the `sl` program you will notice this:
```
...
Get:1 http://archive.ubuntu.com/ubuntu bionic/universe amd64 sl amd64 3.03-17build2 [26.4 kB]
...
```

This gives you the exact location where the program was installed from. Each program listed in the official Ubuntu repositories. When we install something with `apt-get` it's not only the program that we wanted that gets installed but also all the dependencies. That is why we can be safe that when using `apt-get` that not only we are probably not installing malware, but our program will be working the moment we install it. The links to these repositories are written in `/etc/apt/sources.list` and you can easily look at them. Moreover, it is possible to instruct Linux to also look in other repositories when installing new programs by adding the definitions to `/etc/apt/sources.list.d/` (e.g. ROS repositories, see [http://wiki.ros.org/melodic/Installation/Ubuntu](http://wiki.ros.org/melodic/Installation/Ubuntu)).

> Further reading:
> - https://sources.debian.org/
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/how-to-use-apt-command/ -->
### Downloading and installing software directly

Sometimes we can come across great programs that are not provided on the official repositories (e.g. drivers for the Basler cameras: [https://docs.baslerweb.com/software-installation-(linux)](https://docs.baslerweb.com/software-installation-(linux))). The authors of these programs often provide the installer files packed in a more compact format. The typical archiving format in linux is `tar` which also coincides with the name of the command line program to manipulate such archives. To install software on Debian-based Linux distributions we then use the `dpkg` command. We will try this out with in the following example.

First, we navigate to the `~/Downloads` directory and there we download a ready-to-install package from the official Ubuntu repositories:
```
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/c/cowsay/cowsay_3.03+dfsg2-8_all.deb
```
> **Note**: The `wget` will download the files available at the provided URL.

If we inspect the contents of the directory we see the newly downloaded `cowsay_3.03+dfsg2-8_all.deb` file. Before we install it, we will pack it into an archive (and unpack it later).

Let's have a quick look at the very extensive help that `tar` offers and focus on the first few lines:
```
$ tar --help
Usage: tar [OPTION...] [FILE]...
GNU 'tar' saves many files together into a single tape or disk archive, and can
restore individual files from the archive.

Examples:
  tar -cf archive.tar foo bar  # Create archive.tar from files foo and bar.
  tar -tvf archive.tar         # List all files in archive.tar verbosely.
  tar -xf archive.tar          # Extract all files from archive.tar.
```

From this, we have everything we need. So let's pack our file with:
```
$ tar -cf cowsay.tar cowsay_3.03+dfsg2-8_all.deb
```

Inspect the contents of the current working directory and you will find the file `cowsay.tar`. Before we proceed, we will remove the original `cowsay_3.03+dfsg2-8_all.deb`:
```
$ rm cowsay_3.03+dfsg2-8_all.deb.
```

Inspecting the contents of the current working directory will show us that the file `cowsay_3.03+dfsg2-8_all.deb` is no longer present. We can now extract the archive and get the file from there:
```
$ tar -xf cowsay.tar
```

If we inspect the directory we will see taht the `cowsay_3.03+dfsg2-8_all.deb` file is present again. Great! We can finally install the program with `dpkg` (do not forget to do it with super user `sudo`):

```
$ sudo dpkg -i cowsay_3.03+dfsg2-8_all.deb
Selecting previously unselected package cowsay.
(Reading database ... 143807 files and directories currently installed.)
Preparing to unpack cowsay_3.03+dfsg2-8_all.deb ...
Unpacking cowsay (3.03+dfsg2-8) ...
Setting up cowsay (3.03+dfsg2-8) ...
Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
```

We can now use our new program for some useful tasks. For example, display a very friendly message:
```
$ cowsay Hello Linux!
 ______________
< Hello Linux! >
 --------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

That's right, the `cowsay` command displays the provided message inside a text bubble of a cow.
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/how-to-install-deb-packages-on-ubuntu/#installing-deb-files-with-dpkg -->

<!-- ### `tar` -->
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/how-to-create-and-extract-archives-using-the-tar-command-in-linux/ -->

<!-- ## Basic version control with GIT -->
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud -->
<!-- ### Cloning -->

<!-- ### Committing and pushing -->

<!-- ### Branching -->

<!-- ### Merging -->

<!-- ### Git branching model -->
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://nvie.com/posts/a-successful-git-branching-model/ -->
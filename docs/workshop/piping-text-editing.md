## Pipes & Redirects

In this section we will learn how we can pass the output of one command to the input of another. We will also learn how to populate files with the output of a command and much more.

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://www.educative.io/courses/master-the-bash-shell/3w5GrpYLENn -->
<!-- https://unix.stackexchange.com/questions/159513/what-are-the-shells-control-and-redirection-operators -->

### The pipe operator `|`

Before we show how the pipe operator `|` works, we will introduce you to very useful command - `grep`. We can for a moment pretend we are Sauron and we are looking for the Ring. Let's see if the most famous Hobbit keeps a calendar of his activities on a Ubuntu system:
```
$ grep -R Frodo /usr/share/calendar
/usr/share/calendar/calendar.lotr:03/05 Frodo & Samwise encounter Shelob
/usr/share/calendar/calendar.lotr:09/14 Frodo & Bilbo's birthday
/usr/share/calendar/calendar.lotr:09/18 Frodo and company rescued by Bombadil
/usr/share/calendar/calendar.lotr:09/28 Frodo wounded at Weathertop
/usr/share/calendar/calendar.lotr:10/05 Frodo crosses bridge of Mitheithel
```

Excellent! We know when Frodo will be where and can ambush him then. The Ring will finally be in its owners hand (on the owner's finger, to be precise).

If we look closely at what happens here we can see that `grep` looked for all the instances it could find of the word `Frodo` in the `/usr/share/calendar` directory and its sub-directories.

The help of the `grep` command tells its intended use:
```
$ grep --help
Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE.
...
```

In  our case we used it as follows: `-R` is an `[OPTION]` and tells grep to look for files recursively, `Frodo` is the `PATTERN` and `/usr/share/calendar` is the `[FILE]`. In Linux, we can pipe the output of one command into the input of another. Now that we know how `grep` works, let's test out the piping with a simple example:

```
$ echo "Frodo: I will take the Ring thought I don't know the way" | grep -o Ring
Ring
```

> **Note**: We've read the help page before, but just in case you've forgotten: `-o` stands for `--only-matching` and it does `show only the part of a line matching PATTERN`

Let's look at another example: check if a file exists in a certain directory:
```
$ ls /bin | grep grep
bzegrep
bzfgrep
bzgrep
egrep
fgrep
grep
zegrep
zfgrep
zgrep
```

> **Note**: Using `grep` to filter from a long list of things is extremely useful when using for robotics. It's often used to look if a certain topic on the ROS network exists.

Another very useful Linux command that is often used for manipulating strings and file contents is `sed`. Using `sed` on a file will be showcased later. For now, we show a simple string substitution:
```
$ echo "Frodo wouldn't have got far without Sam, would he?" | sed 's/Sam/Sauron/'
```

Here, we used `sed` to substitute all occurrences of `Sam` with `Sauron`. We did so by providing `sed` a "command". The command is `s` and what is after that has the following pattern: `/<expression>/<replacement>/flags`.

> **Note**: We can stack as many piped commands as we want:
>```
>$ echo "Frodo wouldn't have got far without Sam, would he?" | grep -o Sam | sed 's/Sam/Sauron/'
>```

### The redirect operator `>` and `>>`

It's finally time to start placing content into files. We will do this with the redirect operator `>`. This operator takes the output of a command and it *redirects* it into a file.

We've learned a very handy command that produces whatever output we type. So let's try to redirect this into a file:
```
$ echo "Hello people!" > greeting.txt
```

We inspect the contents of the file and we are pleased to see that the computer is greeting us:
```
$ cat greeting.txt
```

This can be very handy when combined with `grep`. Remember how Sauron was wondering about Frodo's appointments throughout the year? It would be a shame if Sauron did not write this down and forgot it. Let's write all Frodo's appointments into file:
```
$ cat /usr/share/calendar/calendar.lotr | grep Frodo > i_want_my_ring.txt
$ cat i_want_my_ring.txt
03/05   Frodo & Samwise encounter Shelob
09/14   Frodo & Bilbo's birthday
09/18   Frodo and company rescued by Bombadil
09/28   Frodo wounded at Weathertop
10/05   Frodo crosses bridge of Mitheithel
```

> **Note**: Before we mentioned that `sed` can be used on a file and that this will be showcased later. Now it's the later:
>```
>$ sed -i 's/Bilbo/Sauron/' i_want_my_ring.txt
>$ cat i_want_my_ring.txt | grep Sauron
>09/14   Frodo & Sauron's birthday
>```
>We replaced the word `Bilbo` with Sauron directly in the file with the `-i` (`--in-place`) flag.

What happens when we use the `>` operator on the same file but with different content? Let's try it out on a simple example:
```
$ echo "We need to talk" > message.txt
```

We now remember that we forgot to sign this message and want to add our name:
```
$ echo "It's me, M" > message.txt
$ cat message.txt
It's me, M
```

That didn't work, did it? The `>` operator will replace the contents in the file. If we want to append something, we need the `>>` operator:
```
$ echo "We need to talk" > message.txt
$ echo "It's me, M" >> message.txt
$ cat message.txt
```

### The redirect operator `<`

The `<` redirect operator takes the contents of a file and redirects them to the standard input of a command written before it.

Let's try to read the `calendar.lotr` file without using the `cat` command:
```
$ grep Frodo < /usr/share/calendar/calendar.lotr
```

We can see, that the result is the same.

## File editors

Before we proceed with scripts it's time to learn about file editors that we can use in the command line. The most basic and suggested one is `nano`.

You will often hear that real pros use `vim`. However, there's this joke about `vim`:
![Exiting vim](../assets/images/exit-vim.png)

To make our life easy and not spend the next 2 hours learning the basic usage of `vim`, we will proceed with `nano`.

Let's quickly try editing a file with `nano`:
```
$ nano delete_me.txt
```

Once this command is executed your terminal will transform into a text editor. See the image below:
![Nano text editor](../assets/images/nano.jpg)

Let's write something simple. Don't mind the content, as the name of the file suggests, we are going to delete it soon after.

After you wrote something, look at the bottom of the terminal window. You will see some tooltips: `^G Get help`, `^O WriteOut`, etc. These tool tips tell you what hot-keys do what. But the letters are followed by this odd character `^`. This character represents the `Ctrl` key on the keyboard. To save the file follow the `Write Out` tooltip and press `Ctrl + O`. The editor will ask you to confirm the name of the file. Simply press enter to do so. Congratulations, you now know how to use one of the text editor in Linux.

Before proceeding, let's remove the newly created file:
```
$ rm delete_me.txt
```

> **Note**: If you're having troubles exiting `nano`, follow the tooltips at the bottom. To exit `nano` simply press `Ctrl + X`.

## The `.bashrc` file

Whenever we start Bash interactively, there is a little script that runs first. We don't notice it, but it's sets up some very useful details. The script has the name `.bashrc` and is located in the root of the home directory.

Before we explore its contents, let's try something. Type the `ll` command and observe the output. Looks familiar? Why is there a command that works very similarly to `ls` but is called `ll`? Let's see what this is about:
```
$ ll --help
Usage: ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

...
```

As you can see, `ll` actually invokes the `ls` command, which means, that `ll` is actually an alias! If it's an alias, it should have been defined somewhere, right?

Let's explore the contents of the `~/.bashrc` file and look if this alias is defined there:
```
$ cat ~/.bashrc | grep ll=
alias ll='ls -alF'
```

There it is! Let's now look at `~/.bashrc` with our text editor `nano`:
```
$ nano ~/.bashrc
```

> **Note:** At this point we will not go into the details of all the lines of the `.bashrc` file because it's out of the scope of this workshop. However, we will add a line at the bottom to showcase how it cane be used.

Let's create a new alias that you are familiar with. Write the following line as the last line of the `.bashrc` file:
```
alias bring-me-coffee="echo Go get it yourself!"
```

Save the file and exit `nano`. The alias is now written in the `.bashrc` file. Do you think it will work if we try invoking the `bring-me-coffee` command?
```
$ bring-me-coffee
bring-me-coffee: command not found
```

Close the currently open terminal and open a new one. Try the command again:
```
$ bring-me-coffee
Go get it yourself!
```

> **Note** It is possible to invoke the `.bashrc` command also from the currently active terminal by doing `source ~/.bashrc`. It will have the same effect as opening a new interactive Bash shell. This is very often found in the Robot Operating System (ROS) tutorial.
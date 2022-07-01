The Linux command line can be used for some rather intricate operations. Not only by successfully using all of the available commands but also by combining them! In this section we will learn about some of the operators that allow this. Moreover, we will also learn how to write proper Shell scripts that do way more than simple tasks.

## Environment variables and variables
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://www.educative.io/courses/master-the-bash-shell/NE8LYJ3zkM2 -->

Shell supports the use of variables. You can assign a variable any value you want. We can start with a basic example and assign a variable a numeric value:
```
$ number=1
```

The above command executes without any issues. How do we know that the variable is assigned? And how do we use it?

We can access stored variables by prefixing its name with the `$` sign (everything's about money, huh?). Knowing this, we can try it out:
```
$ $number
1: command not found
```

What happened?

When we executed `$number` the terminal looked at its value and substituted the command with a `1`. This is essentially the same as simply trying to exectue `1` as a command:
```
$ 1
1: command not found
```

At the moment this might seem like silly and not really practical. Fret not! We will try to change your opinion in a moment.

Execute the following:
```
$ hello="echo Hello to you!"
```
What do you expect to see when executing either `hello` or `$hello` commands?
```
$ $hello
Hello to you!"
```

> **Note:** You're probably wondering why would one use variables and not simply `alias`. Alias can only be used to create aliases for commands. An alias cannot be assigned a plain value. Variables, on the other hand, can.

Ok, but how do we use a variable in practice? Let's do a little together: Define a variable called `name` and assign its value to **your** name. Then, use the `echo` command to print a nice gritting with your name. For instance: `Hello Linux`, where `Linux` was stored in the `name` variable.

First, we assign the `name` variable a value:
```
$ name=Linux
```
Then we execute the previously learned `echo` command with the desired text:
```
$ echo Hello $name!
Hello Linux
```

Congratulations, you now know how to use variables in Linux. Before we proceed, it's important to still discuss about good practice. Imagine we are dealing with files and file names. We want to store the file name into a variable and then append a suffix like `_new.txt`. If we use the knowledge acquired above this would look like this:

```
$ filename="very_important_document"
$ touch $filename_new.txt
```

No errors will be thrown. However, if we use `ls` to list all the files we will not be able to see our newly created `very_important_document_new.txt`. Where is it?!

To help solve the mystery we need to use `ls` with some extra parameters: `ls -la` (as we learned). If you pay attention, you will see a `.txt` file. Without a name, just the file ending. What happened?

First things first, as we once previously described, if a file has a `.` prefixed to it's name, Linux treats it as a "hidden" file and `ls` does not show it (but you already knew that). The question is, why do we see `.txt` only and what happened to the name. Try using `echo` instead of `touch` and inspect the output:

```
$ echo $filename_new.txt
.txt
```

By now you're probably tired of beating around the bush and want to hear the explanation and solution to the problem.
From the internet:
> Variable name must begin with alphanumeric character or underscore character (_), followed by one or more alphanumeric or underscore characters.

This tells us, that when we typed `$filename_new.txt` Linux understood that we're looking for the `filename_new` variable. To circumvent this issue we will double quotation marks `"`:
```
$ filename="very_important_document"
$ touch $"filename"_new.txt
```
Using `ls` will show us that the file has finally been created. Yay!

> **Note**: It is also possible to use curly braces  `{}` instead of the quotation marks. This also opens various possibilities like specifying a default value in case the variable is not defined - `${filename:-not_so_important_document}`. Useful when writing scripts

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

Real pros however use `vim`. However, there's this joke about `vim`.
![Exiting vim](../assets/images/exit-vim.png)

To make our life easy and not spend the next 2 hours learning the basic usage of `vim`, we will proceed with `nano`.


## Scripts

We now know how to sort the output of a command, write contents into a file and read from a file. It is now time to learn how to write some shell scripts that can do complicated operations by simply invoking them.

We start with a simple script:
```
$ echo "echo \"This message came from a script\"" > my_script.sh
```
> **Note**: `/` is an escape character.

We confirm that the content of this file is as expected:
```
$ cat my_script.sh
echo "This message came from a script"
```
Question: how do we execute this?

We execute this file by asking `bash` to execute it's contents:
```
$ bash my_script.sh
This message came from a script
```
We noticed, that we are calling all the Linux commands **without** asking `bash` for an interpretation. How can we achieve this with our scripts?

First, we need to make them executable!
```
$ chmod +x my_script.sh
```
We can now execute this with:
```
$ ./my_script.sh
```
> **Note**: Executing scripts works only by providing their full path. If we put the script elsewhere, we need to run it like `./some/other/directory/my_script.sh`. To make a script accessible from anywhere we can move it to `/usr/local/bin`.

### Quick words about shebangs

In the future, when you are a Linux pro and your only operating system is Linux, you will look for various scripts online that do this or that task. When reading these scripts, you will quickly notice that almost all of them have this unique first line that looks something like this: `#!/bin/bash`. This is the so called **shebang**.

The purpose of this line as the first file is to instruct the kernel which interpreter should be used to run the commands in the file. When you execute a shell script in Ubuntu it will usually assume you are executing it with bash. But that might not always be the case. It is therefore good practice to add the shebang to all shell scripts.

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-shebang/ -->
### `while`
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-while-loop/ -->
### `if`
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-if-else-statement/ -->
### `case`
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-case-statement/ -->
## Input parameters

### Function definition
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-functions/ -->
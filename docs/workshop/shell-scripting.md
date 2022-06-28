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

This tells us, that when we typed `$filename_new.txt` Linux understood that we're looking for the `filename_new` variable. To circumvent this issue we will use curly brackets `{}`:
```
$ filename="very_important_document"
$ touch ${filename}_new.txt
```
Using `ls` will show us that the file has finally been created. Yay!

> **Note**: It is also possible to use double quotation marks `"` isntead of the brackets. But this is not advised.

## Pipes & Redirects


<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://www.educative.io/courses/master-the-bash-shell/3w5GrpYLENn -->
<!-- https://unix.stackexchange.com/questions/159513/what-are-the-shells-control-and-redirection-operators -->

### The pipe operator `|`




### The redirect operator `>`

### The redirect operator `<`


## Scripts
### Shebang!
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
### Function definition
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/bash-functions/ -->
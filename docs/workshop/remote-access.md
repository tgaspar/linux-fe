## Connection to a remote Linux machine

The Raspberry Pi platform has risen in popularity in the last decade. It's a single-board computer that is most times running linux. These mini computers are very popular in robotics because they have a very small footprint and a fully fledge operating system running on them. This allows developers to create very complex software that can then serve as the brain of a robotics platform.

You can probably imagine, that the robotics platforms built on top of such a mini computer does not really provide a physical keyboard and a screen to interface with it. Instead, they are accessed remotely. In this section we will learn the basics of remote connection to a Linux system.

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/ssh-command-in-linux/ -->

### Secure Shell - `ssh`

From the official documentation:
> The Secure Shell (SSH) Protocol is a protocol for secure remote login and other secure network services over an insecure network.

From the very definition you see that security was among the main concerns when developing the SSH protocol. This is ensured by the exchange of cryptographic information between the client and the server (more about this later). Which essentially means that the data exchanged between the two is encrypted to the outside word.

In everyday, the cryptographic side of the SSH protocol will not be noticed but it is important to be aware of it. What you will notice, though, is the requirements to connect to the remote server. In the next steps we will do the following:
1. Ensure that the remote machine is running an SSH server
2. Get the IP address of the remote machine
3. Use the username and password from the previous chapter to connect to the remote machine

First, the remote machine must provide be running the SSH server software. This is pre-installed on a lot of Linux distributions, but not all of them. Let's proceed by ensuring that the OpenSSH ([https://www.openssh.com/](https://www.openssh.com/)) server is installed and running:
```
$ sudo apt-get install openssh-server
$ sudo systemctl enable ssh
$ sudo systemctl start ssh
```

Now that you all ensured that the OpenSSH is running, we can proceed by connecting to your neighbor's computer. For this, we need to get the IP address of your neighbor's computer. For this, you will have to kindly ask your neighbor to type the following command and tell you the result:
```
$ hostname -I
```

The login info was created on the remote machine (i.e. your neighbor's computer) in a previous chapter. Which means, we now have all the requirements to connect to the remote machine via SSH. To do so, issue the following command where you replace `USERNAME` with the username that was created in the previous section and `IP_ADDRESS` with the address your neighbor shared with you:
```
$ ssh USERNAME@IP_ADDRESS
USERNAME@IP_ADDRESS's password:
```

As you can see, the remote server is asking you to type in your password. Do that and then press `Enter`.
> **Note**: The password will not be visible! When you're typing the password, the command line will not react to it. This is a safety feature. When you press `Enter` everything you typed will be sent to the remote server.

If you did everything correctly, you should now be logged into the remote machine with your user. Congratulations, you can now peruse a career as a system administrator. To disconnect from the remote host and return to the terminal running on your machine, press `Ctrl + D`.

#### The Linux X server

> **Note**: The instructions below assume we are still connected to the remote machine.

In a section where we were learning about process management in Linux, we used some GUI-based programs. However, we did not take any time explaining how GUIs run on Linux. It is important to understand this because it allows us to control on which screen or desktop (not the same) does one application show.

To showcase the importance of this, try running `gedit` on the remote machine:
```
$ gedit
Unable to init server: Could not connect: Connection refused

(gedit:18787): Gtk-WARNING **: 20:36:02.992: cannot open display:
```

We received a message telling us that `gedit` was `Unable to init a server: Could not connect: Connection refused`. We are already connected to the remote machine. What kind of server do you think `gedit` is looking for? It was functioning just well on our machine, right?

The server that `gedit` is looking for is the `X` server. From the book *X Window System user's guide : for X11 R3 and R4 of the X Window System*:
> The X Window System, called X for short, is a network-based graphics window system that was developed at MIT in 1984. Several versions of X have been developed, the most recent of which is X Version 11 (X11), first released in 1987.
>
> \- Quercia and O'Reilly, 1990

In short, whatever you see on the desktop is displayed through this X server. At the beginning of this workshop we had a look at the raw terminal environment without any user interfaces. That's when we left the comfort of the X server. Since we came back into the desktop, we've been seeing what the X server feeds us. Knowing this you are probably asking yourself: "How did `gedit` know where the X server is on our machine and how does it not know where the X server is on the other machine?". The answer is very simple. Type the following command:

```
$ echo $DISPLAY
```

The `echo` command did not return anything. Which means that the `DISPLAY` environment variable is not set (more about environment variables in later section). When we run a GUI program, the value of `DISPLAY` tells the terminal where to look for the X server. Since it's empty, the X client (i.e. the program that connects to the server in order to display windows) doe snot know where to connect to.

Let's quickly disconnect from the remote server and inspect the value of `DISPLAY` on our machine:
```
$ echo $DISPLAY
:0.0
```

The `DISPLAY` environment variable has a very specific and strict syntax:
```
hostname:D.S
```

where:

- `hostname` is the network address of the server (if omitted it points to `localhost`)
- `D` is the display/monitor sequence number
- `S` is the screen number

In our case, the value `0.0` instructs the X client to send the window data to the X server running on our machine (`localhost`), on the first display and the first screen. Let's connect back to the remote server and set these values to the exact same:

```
$ export DISPLAY=:0.0
```

and start `gedit`. What happened? You probably did not see much on your screen except that `gedit` no longer outputs errors. But your neighbor is probably surprised that there's suddenly a window opened. By setting the `DISPLAY` environment variable to `:0.0` you instructed the remote host to open GUI applications locally.

Some curious minds probably already started wondering: "Can we make a remote server forward the GUI to our machine"? The answer is clearly yes! And this is easier than one would think. We can instruct `ssh` to forward the X server data to the remote machine. To try this, log out of the remote machine (`Ctrl + D`) and log back in with the `-Y` flag:

```
$ ssh -Y USERNAME@IP_ADDRESS
```

Try running `geddit` again and see it open on your screen.

<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://askubuntu.com/a/432257 -->
## File transfer

With SSH we learned how to connect to the remote machine's terminal and execute commands there. In this section we will learn how to transfer files from one machine to the other. This is rather useful when developing robotics applications as we sometimes want to copy larger data from a robot onto our local machine for further analysis.

In the previous part of the workshop we learned how to copy files with the `cp` command. To transfer files between two machines we can use something called `S`ecure `C`o`p`y or better, the `scp` command. This command has the similar syntax to the `cp` command but it requires some more information. The syntax is always following the pattern: copy from and paste it to. Let's learn how to use it.

First, we navigate into the `~/Documents` directory and create a simple file with some content:
```
$ echo "Hello neighbor" > message.txt
```

and then we send it to machine of our neighbor. We will do a secure copy (`scp`) of the `message.txt` file to our neighbor's machine `USERNAME@IP_ADDRESS` in the `~/Documents` directory:
```
$ scp message.txt USERNAME@IP_ADDRESS:~/Documents
```

You can now use `ssh` to login to the remote machine and inspect if the file really is there.

We will now copy the same file from the remote machine into the `~/Documents` directory on our machine. However, we first delete the file on our machine so it is not present in the `~/Documents` directory using `rm`. We proceed with:
```
$ scp USERNAME@IP_ADDRESS:~/Documents/message.txt ~/Documents/
```

You can now inspect the the contents of the `~/Documents` directory and you will find the `message.txt` file we copied from our neighbor.


<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files/ -->

<!-- ## SSH keys and encryption -->
<!-- What if we would want to avoid providing the password each time we log in into a remote server? -->
<!-- Hidden information -->
<!-- The content in this page was inspired by: -->
<!-- https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/ -->
### Exercise:
> To be defined
<!-- 1. Log into the computer of your neighbor.
2. Run a program with a GUI so you see it on your computer
3. Run a program with a GUI so they see it on their computer -->

> **Further reading**:
> * https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files
> * https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/
> * https://www.ssh.com/academy/ssh/tunneling/example
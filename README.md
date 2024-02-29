# Linux Project

> [!NOTE]
> This project is part of the [DevOpsTheHardWay](https://github.com/alonitac/DevOpsTheHardWay) course. Please [onboard the course]() before starting the project. 

## Project Goals

This project is aimed for the very beginners who want to get familiar with Git and GitHub workflows, debug Linux errors and work with basic Linux commands.

Regardless of your familiarity with Linux, **we highly encourage you to complete this exercise**.
It will familiarize you with the project workflows and testing methods used throughout the course, ensuring you're well-prepared for future projects.

## Preliminaries

1. [Clone this repo into your PyCharm](https://www.jetbrains.com/help/pycharm/set-up-a-git-repository.html#clone-repo).  
2. In PyCharm, [create a new branch](https://www.jetbrains.com/help/pycharm/manage-branches.html#create-branch) from branch `main`. Your branch must be named according to the following template:

```text
linux_project/<alias>
```

While changing `<alias>` to your name, e.g. `linux_project/alonit`.

The branch name must start with `linux_project/`.

> [!NOTE]
> Don't worry if you're not familiar with Git and GitHub yet. 
> We'll cover those topics later on. 
> The reason we're doing this (cloning the repo, and creating a branch...) is because DevOps engineers do this every day,
> it's part of their daily workflow, and we want you to get used to it.

Great. Let's get started...

## Questions

### Kernel System Calls

The Linux Kernel was presented in our first linux lecture - the main component of a Linux OS which functions as the core interface between a computer’s hardware and its applications.

![](https://alonitac.github.io/img/linuxkernel.png)

Then we moved to learn how to use the Terminal and communicate with the OS using commands such as `ls` or `chmod`.  
But how does it really work? we type a command, hit the Enter key, and then what happen? This question tries to investigate that point.  

Under the hood, linux commands are **compiled** C code (get yourself to know what is a compilation process if you don't know..). The C code contains **system calls**. 
System calls are the fundamental interface between an application and the Linux kernel. 

In simple words, when your application wants to use the hardware (e.g. write data to the disk), it invokes a system call to the Linux Kernel, and the linux kernel talks with the hardware on your behalf. Read more about what are System Calls. 

`strace` is a Linux command, which traces system calls and signals of a program.
It is an important tool to debug your programs in advanced cases.
In this question, you should follow the `strace` output of a program in order to understand what exactly it
does (i.e. what are the system calls of the program to the kernel). You can assume that the program does only what you can see by using `strace`.

To run the program, open a linux terminal in an empty directory and perform:
```shell
wget https://alonitac.github.io/__REPO_NAME__/whatIdo_<CPU_ARCH>
```

Where `<CPU_ARCH>` is `arm` or `amd`. TBD explain it better!

The `wget` command is able to retrieve data from the internet.

1. Give the `whatIdo` file an exec permission (make sure you don't get Permission denied when running it).
2. Run the program using strace: `strace ./whatIdo`.
3. Follow strace output. Tip: many lines in the beginning are part of the load of the
program. The first “interesting” lines comes only at the end of the output. 

In the `SOLUTION` file, write a **brief** description of what the program does. Don't copy & paste the terminal output as your answer, neither explain any single command. Try to get a general idea of what this program does by observing the sys calls and the directory you've run the program.


### Binary Numbers

1. Convert the following binary numbers to decimals: 111, 100, 10110.
2. What is the available decimal range represented by 8 bits binary number?
3. Given a 9 bits binary number, suggest a method to represent negative numbers between 0-255.
4. Suggest a method to represent a floating point numbers (e.g. 12.3,  15.67, 0.231) using 8 bits binary numbers.

### Broken Symlink

Uber has an automated daily backup system. Every day another backup file is being created in the file system according to the following format: `backup-YYYY-MM-DD.obj`. e.g. `backup-2023-03-01.obj`.
To be able to restore the system from a backup copy in a convenient way,
they want to point to the last generated backup file using a static file named `backup.obj`. To do so, they create a **symbolic link** pointing to the last generated backup file.  

1. Let's create the daily backup file:
```shell
FILENAME=backup-$(date +"%Y-%m-%d").obj
touch $FILENAME
echo "backup data..." >> $FILENAME
```

2. Then, create a symlink (soft link) to the daily backup file:
```shell
ln -s $FILENAME backup.obj
```

At some point in the development lifecycle of the product,
the DevOps team has decided to organize all backup links in a directory called `backups`. They moved the link `backup.obj` into `backups` directory:
```shell
mkdir backups
mv backup.obj backups/
```

What's wrong here? provide a fix to Uber's code. 

### File System Manipulations

1. Open the linux terminal and perform:

```shell
wget https://alonitac.github.io/__REPO_NAME__/secretGenerator.tar.gz
```

2. Use the `tar` command to extract the compressed file. Enter the `src` directory using `cd`. Explore the files and their content.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
3. Your goal is to generate a secret. The secret is generated using the following command: `/bin/bash generateSecret.sh`.

4. Once you've generated it, copy it to the designated place in the `SOLUTION` file (33 characters). 

5. Use `nano` or your preferred text editor, in `yourSolution.sh` file,  write a bash script (a complete commands set, single command in each line) that lets you generate the secret.
At the end, given a clean version of `src` directory (without the changes you've made) you should be able to run `/bin/bash yourSolution.sh` and the secret should be generated without any errors. 
6. Copy the content of `yourSolution.sh` into the same file in the Git repo under `linux_project/yourSolution.sh`. 
 
## Submission

At the end of this project, under `linux_project` directory in the shared repo, you should **commit** and **push** only **2 files** as your solution:

- `SOLUTION` file with your solution to the below questions. 
- Your bash script solution in `yourSolution.sh` file (see the last question below).


## Push your solution


Finally, [commit](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#commit) your solution. The **only** files that has to be committed are `linux_project/SOLUTION` and `linux_project/yourSolution.sh`.

After clicking on commit button, write some info message regarding your commit in the **Commit Message** and click the **Commit** button.
Commit messages are usually free text written by the developer, providing some information regarding the changes you are committing. Examples could be something like "initial solution" or "linux project solution - work in progress" or "linux project - final solution!".
Feel free to fix your code and commit the changes again and again. You can commit as much as you want.

Then [push](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#push) your solution to GitHub. Bravo! you've submitted your solution! 

Your solution has to pass an automated tests.
Go to [GitHub actions](https://github.com/alonitac/__REPO_NAME__/actions) and make sure your solution has passed the tests. You must see the following message:

```text
Well Done! you've passed all tests
```

Otherwise, your solution has to be fixed. Do your changes, commit and push again.

# Good Luck

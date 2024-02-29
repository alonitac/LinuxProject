# Linux Project

> [!NOTE]
> This project is part of the [DevOpsTheHardWay](https://github.com/alonitac/DevOpsTheHardWay) course. Please [onboard the course]() before starting the project. 

## Project Goals

This project is aimed for the **very beginners** who want to get familiar with Git and GitHub workflows, debug Linux errors and work with basic Linux commands.

Regardless of your familiarity with Linux, **we highly encourage you to complete this exercise**.
It will familiarize you with the project workflows and testing methods used throughout the course, ensuring you're well-prepared for future projects.

## Preliminaries

The website you are visiting now is called GitHub.
It's a platform where millions of developers from all around the world collaborate on projects and share code. 

Think of GitHub as the "central-station" of a code project. 
As a DevOps engineer you'll spend a lot of time here!

Each project on GitHub is stored in something called a **repository**, or **repo** for short. 
A repository is like a folder that contains all the files and resources related to a project.
These files can include code, images, documentation, and more.

This Linux project is also stored and provided to you as a GitHub repo.
You'll answer the project question here

Since this repo is owned by me, you cannot do any changes Now I want you to **fork** this repository but you want to make some changes to it or experiment with it without affecting the original project. That's where forking comes in.

1. Fork this GitHub repository. 
2. [Clone this repo into your PyCharm](https://www.jetbrains.com/help/pycharm/set-up-a-git-repository.html#clone-repo).  
3. In PyCharm, [create a new branch](https://www.jetbrains.com/help/pycharm/manage-branches.html#create-branch) from branch `main`. Your branch must be named according to the following template:

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

![](https://alonitac.github.io/DevOpsTheHardWay/img/linux_project_linuxkernel.png)

Then we moved to learn how to use the Terminal and communicate with the OS using commands such as `ls` or `chmod`. 
But how does it really work? we type a command, hit the Enter key, and then what happen? This question tries to investigate that point.  

Under the hood, linux commands are **compiled** C code (get yourself to know what is a compilation process if you don't know..). The C code contains **system calls**. 
System calls are the fundamental interface between an application and the Linux kernel. 

In simple words, when your application wants to use the hardware (e.g. write data to the disk), it invokes a system call to the Linux Kernel, and the linux kernel talks with the hardware on your behalf. Read more about what are System Calls. 

`strace` is a Linux command, which traces system calls and signals of a program.
It is an important tool to debug your programs in advanced cases.
In this question, you should follow the `strace` output of a program in order to understand what exactly it
does (i.e. what are the system calls of the program to the kernel). You can assume that the program does only what you can see by using `strace`.

To run the program, open up a Linux terminal in an empty directory and use the `wget` command to retrieve program from the internet:

```shell
# for arm64 CPU architectures
wget https://alonitac.github.io/DevOpsTheHardWay/linux_project/arm64/whatIdo

# for amd64 (x86_64) CPU architecture
wget https://alonitac.github.io/DevOpsTheHardWay/linux_project/amd64/whatIdo
```

Depending on the type of CPU your computer has, you'll need to use the appropriate command.
If you're unsure about your CPU architecture, you can usually find this information by running a command like `uname -m` in the terminal.

1. Give the `whatIdo` file an exec permissions (make sure you don't get Permission denied when running it).
2. Run the program using strace: `strace ./whatIdo`.
3. Follow strace output. 

> [!TIP] 
> Many lines in the beginning are part of the load of the
> program. The first “interesting” lines comes only at the end of the output. 

In the `SOLUTION` file, write a **brief** description of what the program does. Don't copy & paste the terminal output as your answer, neither explain any single command. 
Try to get a general idea of what this program does by observing the sys calls and the directory you've run the program in.


### Binary Numbers

1. Convert the following binary numbers to decimals: `111`, `100`, `10110`.
2. What is the available decimal range represented by 8 bits binary number?
3. Given a 9 bits binary number, suggest a method to represent negative numbers between `-255` to `255`.
4. Suggest a method to represent a floating point numbers (e.g. `12.3`,  `15.7`, `0.2`) using 8 bits binary numbers.

### Broken Symlink

Uber has an automated daily backup system. Every day another backup file is being created in the file system according to the following format: `backup-YYYY-MM-DD.obj` (e.g. `backup-2023-03-01.obj`).
To be able to restore the system from a backup copy in a convenient way,
they want to point to the last generated backup file using a static file named `latest-backup.obj`. To do so, they create a **symbolic link** pointing to the last generated backup file.  

1. Let's create the daily backup file:
```shell
FILENAME=backup-$(date +"%Y-%m-%d").obj
touch $FILENAME
echo "backup data..." >> $FILENAME
```

2. Then, create a symlink (soft link) to the daily backup file:
```shell
ln -s $FILENAME latest-backup.obj
```

At some point in the development lifecycle of the product,
the DevOps team has decided to organize all backup links in a directory called `backups`. They moved the link `latest-backup.obj` into `backups` directory:
```shell
mkdir backups
mv latest-backup.obj backups/
```

What's wrong here? provide a fix to Uber's code. 

### File System Manipulations

1. Open up a Linux terminal and perform:

```shell
wget https://alonitac.github.io/DevOpsTheHardWay/linux_project/secretGenerator.tar.gz
```

2. Use the `tar` command to extract the compressed file. Enter the `src` directory. Explore the files and their content. 
3. Your goal is to generate a secret. The secret is generated once the following command is executed successfully (with exit code 0): `/bin/bash generateSecret.sh`.
4. Once you've generated the secret, copy it to the designated place in the `SOLUTION` file (**exactly** 33 characters).
5. Using `nano` or your preferred text editor, write a bash script in the `yourSolution.sh` file (a complete commands set, single command in each line) that let you generate the secret.
At the end, given a clean version of `src` directory (without the changes you've made) you should be able to run `/bin/bash yourSolution.sh` and the secret should be generated without any errors. 
6. Copy the content of `yourSolution.sh` into the same file in the Git repo under `yourSolution.sh`. 
 
## Submission


To submit your project for testing, you first have to [commit](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#commit) your solution.

> [!IMPORTANT]
> If it's the first time ever you're committing using Git, PyCharm may ask you to set your Git username and email. Feel free to specify any details you want. 

The **only** two files that have to be committed are `SOLUTION` and `yourSolution.sh`.

In the commit message, write some info regarding your commit, and click the **Commit** button.
Commit messages are usually free text written by the developer, providing some information regarding the changes you are committing. 
Examples could be something like "initial solution" or "linux project solution - work in progress" or "linux project - final solution!".
Feel free to fix your code and commit the changes again and again. You can commit as much as you want.

Then, [push](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#push) your solution to GitHub. 
Bravo! you've submitted your solution! 

Your solution has to pass an automated tests.
Go to [GitHub actions](https://github.com/alonitac/__REPO_NAME__/actions) and make sure your solution has passed the tests. You must see the following message:

```text
Well Done! you've passed all tests
```

Otherwise, your solution has to be fixed. Do your changes, commit and push again.

# Good Luck

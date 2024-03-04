# Linux Project

> [!NOTE]
> This project is part of the [DevOpsTheHardWay](https://github.com/alonitac/DevOpsTheHardWay) course. Please [onboard the course]() before starting the project. 

## Project Goals

This project is aimed for the **very beginners** who want to get familiar with Git and GitHub workflows, debug Linux errors and work with basic Linux commands.

**Regardless of your familiarity with Linux, we highly encourage you to complete this exercise**.
It will familiarize you with the project workflows and testing methods used throughout the course, ensuring you're well-prepared for future projects.

> [!IMPORTANT]
> If you need any help, feel free to reach out in the [GitHub discussion community](https://github.com/alonitac/DevOpsTheHardWay/discussions) of the course.

## Preliminaries

The first step we would like you to do is to fork this repo. 

Wait a minute, **fork**? **repo**!? Let's take a step back. 

The website you are visiting now is called **GitHub**.
It's a platform where millions of developers from all around the world collaborate on projects and share code. 

Each project on GitHub is stored in something called a **repository**, or **repo** for short. 
A repository is like a folder that contains all the files and resources related to a project.
These files can include code, images, documentation, and more.


**This Linux project** is also stored and provided to you as a GitHub repo.
You'll answer the project's questions here, inside the repo, as if you were working on a real code project. 

However, because this repository is owned by me, you don't have permission to directly make changes.
Thus, I want you to **fork** this repository. 
When you fork a repository, you create a copy of the original repository under your own GitHub account. 
This copy is completely separate from the original repository, so you can make changes to it without altering the original project.


1. [Fork this repo](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository). 
2. Now, [clone your forked repository into your PyCharm environment](https://www.jetbrains.com/help/pycharm/set-up-a-git-repository.html#clone-repo). Cloning creates a local copy of the repository on your local computer. You'll work on the project's solution in PyCharm.   
3. In PyCharm, [create a new branch](https://www.jetbrains.com/help/pycharm/manage-branches.html#create-branch) from branch `main`. Your branch **must** be named according to the following pattern:

   ```text
   linux_project/YOUR_NAME_HERE
   ```

   While changing `YOUR_NAME_HERE` to your name, e.g. `linux_project/alonit`.

Don't worry if you don't understand exactly what "branch" is, or why do you do these steps. 
We'll cover those topics later on in the course.
We can only say that DevOps engineers do these steps as part of their daily workflow. 

> [!Note]
> By working on this project, you are generating an activity on your GitHub profile.
> This activity is visible to recruiters and potential employers, providing them with insights into your coding habits, projects, and overall engagement. 
> Think of it as your digital "business card" for people who are interested in your technical experience.


Great, let's get started...


## Questions

### I. Kernel System Calls

The Linux Kernel was presented in our first linux lecture - the main component of a Linux OS which functions as the core interface between a computer’s hardware and its applications.

![linux_project_linuxkernel][linux_project_linuxkernel]

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


### II. Binary Numbers

As you may know, the `chmod` command utilizes binary numbers to set permissions in Linux. 
Let's work a bit with binary numbers.   

1. Convert the following binary numbers to decimals: `111`, `100`, `10110`.
2. What is the available decimal range represented by 8 bits binary number?
3. Given a 9 bits binary number, suggest a method to represent negative numbers between `-255` to `255`.
4. Suggest a method to represent a floating point numbers (e.g. `12.3`,  `15.7`, `0.2`) using 8 bits binary numbers.

### III. Broken Symlink

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

### IV. File System Manipulations

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

Finished the project? it's time to submit your solution for testing.

In software engineering, testing is essential for ensuring the reliability and quality of the code that's delivered to production.
Thus, we'll test your project to ensure it meets basic standards of correctness.
This way, you'll receive immediate feedback and can quickly fix issues.

In order to deliver your project for testing, you need to save your changes (a.k.a. **Commit**), upload them to GitHub (a.k.a. **Push**), and request a review of your work (a.k.a. **Pull Request**).
We'll guide you through these steps. 

1. [Commit](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#commit) your changes through PyCharm.

   If it's the first time ever you're committing, PyCharm may ask you to set your Git username and email. Feel free to specify any details you want. 

   The **only** two files that have to be committed are `SOLUTION` and `yourSolution.sh`.
   In the commit message, write some info regarding your commit, and click the **Commit** button.

   Commit messages are usually free text written by the developer, providing some information regarding the changes she did. 
   Examples could be something like "initial solution" or "linux project solution - work in progress" or "linux project - final solution!".
   Feel free to fix your code and commit the changes again and again. You can commit as much as you want.

2. Next, [push](https://www.jetbrains.com/help/pycharm/commit-and-push-changes.html#push) your commits to GitHub. 
3. Then, create a pull request:
   - On GitHub, navigate to the main page of the repository.
   - In the top navigation menu, choose **Pull Requests**, then **New Pull Request**.
   - In the **Comparing changes** section, choose your forked repo as the **head repository** and your project branch as the **compare** branch. 
     likewise, choose our project (`alonitac/LinuxProject`) as the base repo, and `main` as the base branch. As follows:
     ![linux_project_pr][linux_project_pr]
   - Finally, click **Create Pull Request**, you can leave some title and description, and click **Create Pull Request** again.
4. Make sure your Pull Requests (PR) is passing all tests. If there is any failure, click on the failed test, **read the test logs carefully**, try to understand the root cause of the issue, fix it, then commit and push again.  




# Good Luck

![](http://13.51.193.44:8081)

[linux_project_linuxkernel]: https://alonitac.github.io/DevOpsTheHardWay/img/linux_project_linuxkernel.png
[linux_project_pr]: https://alonitac.github.io/DevOpsTheHardWay/img/linux_project_pr.png

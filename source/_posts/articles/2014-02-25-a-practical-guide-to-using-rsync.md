---
layout: post
title: A Practical Guide to Using rsync
categories: articles
---
If you've never used [rsync](http://rsync.samba.org/) before then today is going to be a great day for you. Firstly, rsync is not new it's been around for quite a while and chances are you've already used it without realising. One of the things I use it for most is to sync directories on your local machine (useful for creating backups to external devices) or you can sync with a remote connection.

> It can perform differential uploads and downloads (synchronization) of files across the network, transferring only data that has changed. The rsync remote-update protocol allows rsync to transfer just the differences between two sets of files across the network connection.

What this means is instead of uploading everything it will upload only the files that have changed. Not only that, it uses compression while sending so it can reduce the amount of bandwidth used over other methods.

## Preparation

Most machines will have `rsync` available, you can check by running `which rsync` in your terminal to show you where it is located. If you don't get a response then you will need to install it.

    # On Redhat based systems (CentOS etc)
    $ yum install rsync

    # On Debian based systems (Ubuntu etc)
    $ apt-get install rsync

OS X already has `rsync` available so you don't need to worry about installing it again.

## Usage

Using rsync is easy, there are a few options that you will use the most so you can mix and match these depending on what you would like to achieve.

    $ rsync [options] [source] [destination]

- `-v`, `--verbose`, this will increase the verbosity, showing the path for every file copied.
- `-a`, `--archive`, archive mode is very useful for backups, it will preserve everything about the file such as timestamps and permissions. The only thing it does not preserve is hardlinks, because finding multiply-linked files is expensive.
- `-z`, `--compress`, compress file data during the transfer to reduce bandwidth, this is particularly useful when working with a remote server.
- `-n`, `--dry-run`, perform a trial run with no changes made, very useful to do this before combining with the option below.
- `-h`, `--human-readable`, output numbers in a human-readable format. (If you use `-h` without anything else it is also the help)
- `--delete`, this will delete the files in the destination not present in the source, use this to truely sync changes.
- `--help`, probably the most useful one of them all, show the help for `rsync`.

## You said Practical Guide?

I've used `rsync` most extensively for syncronising folders on my local machine with an external harddrive for backups and for managing files on remote servers at times too. The `rsync` command can also be used more creatively and I intend to demonstrate a few of those use cases below along side the basics.

### 1. Copy/sync a directory on your local machine

A classic, simply creates an exact (recurrsive) replica of another directory. Make the destination a path to your USB storage and you've got an efficient backup tool. You can always use the `--dry-run` option to check what's going to change.

**Please note:** the trailing `/` on the source is important to copy the contents of the directory and not the directory itself.

    $ rsync -azvh --delete /my/source/directory/ /my/backup/directory

To get a touch of the secret symlink sauce, you might want any symlinks in your directory to be resolved into real files. In which case add `-L` to your options.

- `-L`, `--copy-links`, transforms a symlink into the real file or directory it targets.
- `--safe-links`, consider this option if you want to ignore symlinks that point outside the directory you're copying.

### 2. Copy/sync a directory to a remote server

Another classic use case. The main difference here is we are specificing the username and host(or IP) of the machine we wish to connect to, the remote server will also need to have `rsync` installed.

I would also opt for using rsync over ssh as it will encrypt your data as it travels over the internet, if you don't want this remove the `-e ssh` option.

    $ rsync -azvh -e ssh /my/source/directory/ root@123.123.123.123:/my/backup/directory

Add the `--delete` option if you want to remove any files that exist in the destination but don't in the source directory.

- `-e`, `--rsh=COMMAND`, allows you to specify the remote shell to use. In our case `ssh`.

### 3. Sync files but make backups of any deleted files

If the idea of the `--delete` option makes your buttocks clench it's understandable since there is no recovering the deleted files. However, you can pass in the `--backup` option, this will make copies of any files due to be deleted or updated.

The `--backup` command needs a friend to work best, introducing `--backup-dir`. These options allow you to specify the location of the backups and a string to add to the end of the filename.

    $ rsync -avz --delete --backup --backup-dir="backup_$(date +'%Y-%m-%d')" /source/path/ /dest/path

By using `$(date +'%Y-%m-%d')` I'm telling it to use todays date in the folder name.

- `-b`, `--backup`, with this option, preexisting destination files are renamed as each file is transferred or deleted.
- `--backup-dir=DIR`, this tells rsync to store all backups in the specified directory on the receiving side.


## Please sir, I want some more!

More! That's all for now but as I think of/remember other use cases for the brilliant `rsync` tool I will update this list. Or feel free to contribute your own by [tweeting me @createdbypete](https://twitter.com/createdbypete) or on [Google+](https://plus.google.com/+PeterRhoades) or [create and issue on GitHub](https://github.com/createdbypete/createdbypete.github.io/issues).

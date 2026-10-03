## grep text in dir `(ex: /etc)`

> How to use "grep" command to find text including subdirectories [askubuntu](https://askubuntu.com/questions/55325/how-to-use-grep-command-to-find-text-including-subdirectories) <br/>
> 14 Grep Command Examples in Linux [linuxtechi.com](https://www.linuxtechi.com/grep-command-examples-in-linux/) <br/>
> How to use grep command In Linux / UNIX with examples [cyberciti.biz faq](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/) <br/>
> Grep Command Basics: Text Searching in Linux for Beginners [yt](https://www.youtube.com/watch?v=FpqeWGDsSLc&t=159) <br/>
> Using the grep Command in Linux: Finding Text & Strings in Files [akamai.com guides](https://www.akamai.com/cloud/guides/how-to-use-grep) <br/>
> Manipulating text at the command line with grep [redhat.com blog](https://www.redhat.com/en/blog/manipulating-text-grep) 

To search for a specific text string inside the /etc directory, you need to use a recursive search because /etc contains many subdirectories.

The standard command to do this is:
```bash
grep -r "your_text_here" /etc
```

**💡 Useful Options to Pair with it**

Depending on what you want to achieve, you can modify the command with these common flags:

• Ignore case: Add -i if you aren't sure if the text is uppercase or lowercase.bash
```bash
grep -ri "text" /etc
```
• Show line numbers: Add -n to see exactly what line the text appears on inside the files.
```bash
grep -rn "text" /etc
```
• List filenames only: Add -l if you only want a list of files that contain the text, rather than seeing every matching line.
```bash
grep -rl "text" /etc
```
• Suppress error messages: Add -s to hide "Permission denied" or "No such file or directory" warnings for files your user account cannot read.
```bash
grep -ris "text" /etc
```

**🔒 Note on Permissions**

Many configuration files inside /etc are restricted to the root user. If you find that your search is missing files or throwing permission errors, run the command with sudo:
```bash
sudo grep -rn "your_text_here" /etc
```

## grep show line numbers

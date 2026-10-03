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

To show line numbers when using the `grep` command, use the **-n** (or **--line-number**) option. This prefixes each matching line in the output with its corresponding line number from the file.

> How can I format my grep output to show line numbers at the end of the line, and also the hit count? [stackoverflow](https://stackoverflow.com/questions/3968103/how-can-i-format-my-grep-output-to-show-line-numbers-at-the-end-of-the-line-and)  <br/>
> Linux/Unix: grep Command Show Line Numbers While Displaying Output [cyberciti.biz faq](https://www.cyberciti.biz/faq/unix-linux-grep-show-line-numbers-on-screen/)  <br/>
> https://www.howtogeek.com/devops/how-to-use-grep-to-display-filenames-line-numbers-before-matching-lines/
> [askubuntu](https://askubuntu.com/questions/558922/using-grep-to-print-line-numbers)  <br/>
> Grep Show Line Number & Usage Guide [namehero.com](https://www.namehero.com/blog/grep-show-line-number-usage-guide/)  <br/>
> Grep Show Lines Before and After [warp.dev](https://www.warp.dev/terminus/grep-lines-before-and-after)

**Standard Usage**
```bash
grep -n "pattern" filename
```
**Useful Variations**
• **Show line numbers across multiple files:**
When searching in more than one file, it will display the filename followed by the line number.
```bash
grep -n "pattern" file1.txt file2.txt
```
• **Print ONLY the line numbers (hide the matching text):**
If you only need the specific line numbers where the pattern occurs, pipe the output to the cut command:
```bash
grep -n "pattern" filename | cut -d: -f1
```
• **Combine with color formatting:**
To make the output easier to read visually on your screen, combine it with the --color flag:
```bash
grep -n --color "pattern" filename
```

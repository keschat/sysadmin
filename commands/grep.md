# grep command

The grep command (Global Regular Expression Print) is a powerful command-line utility used in Linux, macOS, and Unix systems to search for specific text patterns or regular expressions within files or standard input streams. [1, 2, 3] 

## Basic Syntax
```bash
grep [options] "pattern" [file_name]
```
------------------------------
## Common Options & Flags

| Flag | Description | Example |
|---|---|---|
| -i | Ignores case sensitivity. | grep -i "error" logfile.txt |
| -r | Searches recursively through directories. | grep -r "todo" ./src/ |
| -v | Inverts the match (shows lines without the pattern). | grep -v "success" server.log |
| -n | Displays the line numbers of the matches. | grep -n "main" index.js |
| -c | Returns a count of matching lines instead of the text. | grep -c "warning" log.txt |
| -w | Matches whole words only. | grep -w "cat" animals.txt |
| -l | Lists only the filenames that contain a match. | grep -l "secret" *.conf |

------------------------------
## Core Examples

* Search for text in a single file:
```bash
grep "failed" login.log
```
* Search with context lines (show 3 lines after, before, or around a match):
```bash
grep -A 3 "Exception" error.log  # 3 lines After
grep -B 3 "Exception" error.log  # 3 lines Before
grep -C 3 "Exception" error.log  # 3 lines Context (Before & After)
```

``` [1, 4] 

* Using Pipes (|) to filter other command outputs:
bash ps aux | grep "nginx" [5] 

------------------------------
## Using Basic Regular Expressions (Regex)

* ^ (Anchor to start of line): Find lines starting with "Error"
bash grep "^Error" app.log [1, 6] 
* $ (Anchor to end of line): Find lines ending with "done"
bash grep "done$" app.log [1, 6] 
* -E (Extended Regex - Multiple patterns): Find lines with "error" OR "fail" OR "warning"
bash grep -E "error|fail|warning" system.log [3] 

I can give you tailored examples if you tell me what specific task you are trying to automate or what kind of files you are searching through (e.g., code, logs, CSVs).

[1] [https://www.geeksforgeeks.org](https://www.geeksforgeeks.org/linux-unix/grep-command-in-unixlinux/)
[2] [https://www.cyberciti.biz](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/)
[3] [https://www.digitalocean.com](https://www.digitalocean.com/community/tutorials/grep-command-in-linux-unix)
[4] [https://docs.rackspace.com](https://docs.rackspace.com/docs/use-the-linux-grep-command)
[5] [https://www.akamai.com](https://www.akamai.com/cloud/guides/how-to-use-grep-command/)
[6] [https://dev.to](https://dev.to/chielo_chiamaka/grep-command-in-linux-34m5)

To skip binary files while searching with grep, you can use the --binary-files=without-match option or the shorter -I (capital i) flag.
Using these flags tells grep to completely ignore binary matches and pretend they do not contain the search pattern, preventing messy binary data from cluttering your terminal.
## The Best Flags to Use

* -I (Capital i): Processes a binary file as if it does not contain any matches. This is equivalent to --binary-files=without-match.
* --exclude-dir: Often used alongside -I when doing recursive searches to completely skip binary-heavy folders (like .git or node_modules).

------------------------------
## Command Examples

* Search a directory recursively while skipping binary files:
```bash
grep -rI "search_pattern" ./src/
```
* Search and skip both binary files and specific dependency folders:
```bash
grep -rI --exclude-dir={.git,node_modules,bin,obj} "auth_key" .
```
* Search a specific wildcard pattern while forcing grep to ignore binaries:
```bash
grep -I "database_url" *
```
***

# grep text in dir `(ex: /etc)`

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

# grep show line numbers

To show line numbers when using the `grep` command, use the **-n** (or **--line-number**) option. This prefixes each matching line in the output with its corresponding line number from the file.

> How can I format my grep output to show line numbers at the end of the line, and also the hit count? [stackoverflow](https://stackoverflow.com/questions/3968103/how-can-i-format-my-grep-output-to-show-line-numbers-at-the-end-of-the-line-and) <br/>
> Linux/Unix: grep Command Show Line Numbers While Displaying Output [cyberciti.biz faq](https://www.cyberciti.biz/faq/unix-linux-grep-show-line-numbers-on-screen/) <br/>
> [askubuntu](https://askubuntu.com/questions/558922/using-grep-to-print-line-numbers) <br/>
> Grep Show Line Number & Usage Guide [namehero.com](https://www.namehero.com/blog/grep-show-line-number-usage-guide/) <br/>
> Grep Show Lines Before and After [warp.dev](https://www.warp.dev/terminus/grep-lines-before-and-after) <br/>
> How to Use grep to Display Filenames & Line Numbers Before Matching Lines [howtogeek.com](https://www.howtogeek.com/devops/how-to-use-grep-to-display-filenames-line-numbers-before-matching-lines/)

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
> Match string and print a line number only using Linux shell [linuxconfig.org](https://linuxconfig.org/match-string-and-print-a-line-number-only-using-linux-shell) <br/>
> Get line number while using grep [stackoverflow](https://stackoverflow.com/questions/3213748/get-line-number-while-using-grep)

If you only need the specific line numbers where the pattern occurs, pipe the output to the cut command:
```bash
grep -n "pattern" filename | cut -d: -f1
```
• **Combine with color formatting:**
To make the output easier to read visually on your screen, combine it with the --color flag:
```bash
grep -n --color "pattern" filename
```

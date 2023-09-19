# Final assignment

You are a professor at a Star Fleet university. This year you started a new course entitled: "The Social Impacts of the Linux Operating System in the 20nd Century". The students attending this course are from France, Ireland, USA, and Kronos (Klingon home world). It's the time of the finals and the student have had an exam of this course. You asked your assistant to collect the grades of the students and forward them to you in a CSV (comma separated values) file. The data in the file should be ordered as follows: student name, exam grade, preferred language and other comments. The assistant gave you the following file (the extra empty line at the end is mandatory, see [https://www.iso.org/obp/ui/#iso:std:iso-iec:9899:ed-3:v1:en](https://www.iso.org/obp/ui/#iso:std:iso-iec:9899:ed-3:v1:en)):

```
Miles O'Brien,84,gle,Try to tune down the chatter
Worf Rozhenko,76,tlh,Has a temper.
Jean-Luc Picard,100,fra,Getting bald but it fits the character. Keep it up.
Beverly Crusher,93,eng,
```

Your class currently has only 4 students but it seems that it was very popular so you expect many more next year. You want to write a script that generates a text informing the students of their grade (passing criteria is 50/100) and adds comments from the assistant. Because you want to show them additional respect (no matter of their score), you want the greeting of the email to be in their native language. This text should be printed in standard output so you can copy-paste it into an email. The text should additionally also be saved in a file with the following format: `Name_Surname.txt`.

Hints:
 - The `cut` command can cut out a single piece of data from a string with a specified delimiter: `cut -d , -f 1`.
 - The `tr` (translate) command can be used to replace one character with another: `tr ' ' '_'`.
 - It is possible to pipe a file into the while loop with the following syntax:
 - By setting the `-e` flag with `echo` it is possible to use special characters like new line `\n`.
 ```bash
while read -r line; do
  COMMANDS
done < /path/to/file
 ```
 - The `head -n <number>` command outputs the number of lines specified by `<number>` from top to bottom.
 - The `tail -n <number>` command outputs the the number of lines specified by `<number>` from bottom to top.

Example of a text for Beverly Crusher:
```
Dear Beverly Crusher!
It my pleasure to inform you that you passed the exam. Your grade is 93/100.
Additional comments from the assistant:
Best regards,
Your teacher
```

 > Expected time for the assignment: 45 minutes.
#!/bin/bash
parse_name (){
    echo $@ | cut -d , -f 1
}
parse_grade (){
    echo $@ | cut -d , -f 2
}
parse_lang (){
    echo $@ | cut -d , -f 3
}
parse_comment (){
    echo $@ | cut -d , -f 4
}

while read -r line; do
    name=$(parse_name $line)
    filename="$(echo $name | tr ' ' '_').txt"
    grade=$(parse_grade $line)
    lang=$(parse_lang $line)
    comment=$(parse_comment $line)
    # echo "Student name: $name"
    # echo "Exam grade: $grade"
    # echo "Preferd language: $lang"
    # echo "Comment: $comment"
    echo "Dear $name," > $filename
    echo "It my pleasure to inform you that you passed the exam. Your grade is $grade/100." >> $filename
done < /home/tgaspar/linux-fe/docs/assets/assignments/finals.csv
#!/bin/bash
parse_name (){
    echo $@ | cut -d ',' -f 1
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

eng_text (){
    echo -e "Dear $1!\n"\
"It my pleasure to inform you that you passed the exam. Your grade is $2/100.\n"\
"Additional cooments from the assistant: $3\n"\
"Best regards, \n"\
"Your teacher"
}

while read -r line; do
    name=$(parse_name $line)
    filename="$(echo $name | tr ' ' '_').txt"
    grade=$(parse_grade $line)
    lang=$(parse_lang $line)
    comment=$(parse_comment $line)

    case $lang in
        "eng")
            eng_text "$name" "$grade" "$comment" > $filename
            ;;
        *)
            echo "Language $lang is not supported"
            continue
            ;;
    esac

    # echo "Student name: $name"
    # echo "Exam grade: $grade"
    # echo "Preferd language: $lang"
    # echo "Comment: $comment"
    # eng_greeting $name > $filename
    # eng_grades $grade >> $filename

done < /home/tgaspar/linux-fe/docs/assets/assignments/finals.csv
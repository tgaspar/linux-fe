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
"Additional comments from the assistant: $3\n"\
"Best regards, \n"\
"Your teacher"
}

gle_text (){
    echo -e "A chara $1!\n"\
"Tá áthas orm a chur in iúl duit gur éirigh leat sa scrúdú. Is é $2/100 do ghread.\n"\
"Moltaí breise ón oiliúnaí: $3\n"\
"Le gach dea-ghuí, \n"\
"Do mhúinteoir"
}

tlh_text (){
    echo -e "Qapla' $1!\n"\
"BIDalqu'mo' 'e' DachIDqangmoH. $2/100.\n"\
"$3\n"\
"Qapla'!\n"\
"Qapla'!"
}

fra_text (){
    echo -e "Cher $1!\n"\
"J'ai le plaisir de vous informer que vous avez réussi l'examen. Votre note est $2/100.\n"\
"Commentaires supplémentaires de l'assistant: $3\n"\
"Meilleures salutations, \n"\
"Votre professeur"
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
        "gle")
            gle_text "$name" "$grade" "$comment" > $filename
            ;;
        "tlh")
            tlh_text "$name" "$grade" "$comment" > $filename
            ;;
        "fra")
            fra_text "$name" "$grade" "$comment" > $filename
            ;;
        *)
            echo "Language $lang is not supported"
            continue
            ;;
    esac

    echo "Student name: $name"
    echo "Exam grade: $grade"
    echo "Preferd language: $lang"
    echo "Comment: $comment"

done < /home/tgaspar/Documents/FE/linux-fe/docs/assets/assignments/finals.csv
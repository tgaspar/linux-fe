#!/bin/bash
brave_students=(John Jack Jane Jolene)
for idx in {0..3..1}
do
    echo "Dear ${brave_students[$idx]},"
    echo "You finished the course with the following grade: 5. You will have to repeat the course."
    echo "¯\_(ツ)_/¯"
    echo ""
done

# Can be done also with `for student in ${brave_students[@]}`
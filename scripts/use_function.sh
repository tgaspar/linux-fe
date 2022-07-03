#!/bin/bash

print_args () {
   echo "This text comes from the print_args function."
   echo "These are the provided arguments:"
   for arg in "$@"
    do
        echo -e "\t\t\t\t - $arg"
    done

}

print_args sometext somemoretext number1 number2
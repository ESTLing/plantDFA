#! /bin/bash

if [ ! -f "bin/plant" ]
then
    gcc NFA.c -o bin/plant
fi

jarpath="bin/plantuml.jar"
outputname="uml.out"
num=$#
str=${!num}

while getopts "j:o:" arg; do
    case $arg in
        j)
            jarpath=$OPTARG
            ;;
        o)
            outputname=$OPTARG
            ;;
        \?)
            echo "usage: ./gen.sh [-j jarpath] [-o outputname] regexp"
            exit 1
        ;;
    esac
done


echo '@startuml'>$outputname
bin/plant $str>>$outputname
echo '@enduml'>>$outputname

java -jar bin/plantuml.jar $outputname

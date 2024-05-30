#!/bin/bash

read -p "Enter the number of subjects: " numSubjects

declare -a subjects
declare -a marks
declare -a credits

for ((i=0; i<numSubjects; i++))
do
    echo "Enter the name of subject $((i+1)): "
    read subject
    subjects[$i]=$subject

    echo "Enter the mark for $subject (out of 5): "
    read mark
    marks[$i]=$mark

    echo "Enter the credits for $subject: "
    read credit
    credits[$i]=$credit
done

totalWeightedMarks=0
totalCredits=0

for ((i=0; i<numSubjects; i++))
do
    totalWeightedMarks=$(awk "BEGIN {print $totalWeightedMarks + ${marks[$i]} * ${credits[$i]}}")
    totalCredits=$(($totalCredits + ${credits[$i]}))
done

average=$(awk "BEGIN {print $totalWeightedMarks / $totalCredits}")

printf "Your average is %.2f\n" $average

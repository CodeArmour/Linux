#!/bin/bash

# Function to calculate age
calculate_age() {
    local birth_day=$1
    local birth_month=$2
    local birth_year=$3
    local current_day=$4
    local current_month=$5
    local current_year=$6

    local years=$((current_year - birth_year))
    local months=$((current_month - birth_month))
    local days=$((current_day - birth_day))

    if (( months < 0 )) || { (( months == 0 )) && (( days < 0 )); }; then
        ((years--))
        if (( months < 0 )); then
            ((months += 12))
        fi
        if (( days < 0 )); then
            local days_in_prev_month=$(get_days_in_month $birth_month $birth_year)
            ((days += days_in_prev_month))
        fi
    fi

    echo "$years $months $days"
}


# Function to get days in a month
get_days_in_month() {
    local month=$1
    local year=$2
    case $month in
        2)
            if is_leap_year $year; then
                echo 29
            else
                echo 28
            fi
            ;;
        4 | 6 | 9 | 11)
            echo 30
            ;;
        *)
            echo 31
            ;;
    esac
}

# Function to determine if a year is a leap year
is_leap_year() {
    local year=$1
    if (( (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 )); then
        return 0
    else
        return 1
    fi
}



# Main program starts here
echo "Enter your birth day:"
read birth_day

echo "Enter your birth month:"
read birth_month

echo "Enter your birth year:"
read birth_year

echo "Enter the current day:"
read current_day

echo "Enter the current month:"
read current_month

echo "Enter the current year:"
read current_year

age=($(calculate_age $birth_day $birth_month $birth_year $current_day $current_month $current_year))
echo "Your age is: ${age[0]} years, ${age[1]} months, and ${age[2]} days."

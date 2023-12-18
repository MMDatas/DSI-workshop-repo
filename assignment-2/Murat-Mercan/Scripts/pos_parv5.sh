#!/bin/bash

# Checking if the correct number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_csv_file>"
    exit 1
fi

# Storing the input CSV file path
csv_file=$1

# Change to the directory where the CSV file is
cd "$(dirname "$csv_file")"

# Requirement 2a: Print all types of parking infractions
print_infractions() {
    cut -d ',' -f 4 "$csv_file" | sort | uniq
}

# Execute 2a
echo "All types of infractions:"
print_infractions

# Requirement 2b: Print mean, min, and max set_fine_amount

calculate_fine_stats() {
    awk -F ',' 'NR==1 {next} {sum+=$5; count+=1; if(min=="" || $5<min) min=$5; if($5>max) max=$5} END{print "Mean:", sum/count, "Min:", min, "Max:", max}' "$csv_file"
}


# Execute 2b
echo "Fine statistics:"
calculate_fine_stats

# Requirement 2c: Saving one type of parking infraction to a separate file
save_infraction_to_csv() {
    infraction_type="PARK ON PRIVATE PROPERTY"
    grep "$infraction_type" "$csv_file" > "$infraction_type"_filtered.csv
}

# Execute 2c: Save one type of parking infraction to a separate file
save_infraction_to_csv
echo -e "\n'$infraction_type' observations saved to '$infraction_type'_filtered.csv"

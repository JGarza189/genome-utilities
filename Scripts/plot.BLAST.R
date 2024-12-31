#!/usr/bin/env Rscript

# Load necessary packages
if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr")
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
suppressMessages(library(readr))
suppressMessages(library(dplyr))
suppressMessages(library(ggplot2))

# Get the file path from command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check if a file path is provided
if (length(args) == 0) {
  stop("No input file provided. Usage: ./your_script.R <file_path>", call. = FALSE)
}

# Get the file path
file_path <- args[1]

# Check if the file exists
if (!file.exists(file_path)) {
  stop(paste("File does not exist:", file_path), call. = FALSE)
}

# Get the base name of the file (without extension) to create a directory
base_name <- tools::file_path_sans_ext(basename(file_path))

# Create the new directory for output
output_dir <- paste0(base_name, "_plots")
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Read the CSV file without printing the column specification
data <- read_csv(file_path, show_col_types = FALSE)

# Replace spaces in column names with periods
colnames(data) <- gsub(" ", ".", colnames(data))

# Wrangle the data by replacing spaces with periods in the values
data_wrangled <- data %>%
  mutate_all(~gsub(" ", ".", .))

# Print a line space for readability
cat("\n")

# Print a sample of original untidy data
cat("Sample of original data:\n")
print(head(data))  # Print first few rows of the untidy data

# Extract genus by taking the first word before the period in Scientific.Name
data_genus <- data_wrangled %>%
  mutate(Genus = sub("\\..*", "", `Scientific.Name`)) %>%
  group_by(Genus) %>%
  summarise(Frequency = n()) %>%
  ungroup() %>%
  arrange(desc(Frequency)) %>%
  top_n(10, Frequency)  # Get the top 10 genera based on frequency

# Dot plot for top 10 genera frequency
dot_plot <- ggplot(data_genus, aes(x = reorder(Genus, Frequency), y = Frequency)) +
  geom_point(color = "cadetblue", size = 4) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.background = element_rect(fill = "white")) +  # White background
  labs(title = "Top 10 Genus Frequency", x = "Genus", y = "Frequency")

# Bar plot for top 10 genera frequency
bar_plot <- ggplot(data_genus, aes(x = reorder(Genus, Frequency), y = Frequency, fill = Genus)) + 
  geom_bar(stat = "identity", alpha = 0.9) +  # Less transparency for darker bars
  scale_fill_manual(values = c("steelblue", "powderblue", "slategray", "skyblue4", "aquamarine3", "darkgray", 
                               "paleturquoise3", "lightblue4", "skyblue2", "azure2")) +
  labs(title = "Top 10 Genus Frequency", x = "Genus", y = "Frequency", fill = "Genus") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.background = element_rect(fill = "white"))  # White background

# Save the plots to the new output directory
ggsave(file.path(output_dir, paste0(base_name, "_dot_plot.png")), dot_plot, dpi = 300, width = 8, height = 6)
ggsave(file.path(output_dir, paste0(base_name, "_bar_plot.png")), bar_plot, dpi = 300, width = 8, height = 6)

# Print confirmation and top 10 genera
cat("\nPlots saved to:", output_dir, "\n")
cat("\nTop 10 Genera (sorted by frequency):\n")
print(data_genus)

# Add a space for readability
cat("\n")  # This will print an empty line after the table

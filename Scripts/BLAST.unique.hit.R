#!/usr/bin/env Rscript

# Load Packages
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
library(tidyverse)

# Get command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check if a file path is provided
if (length(args) == 0) {
  stop("No input file provided. Usage: ./your_script.R <file_path>", call. = FALSE)
}

# Get the file path
file_path <- args[1]

# Get the output directory, default to "Processed-Data"
output_dir <- ifelse(length(args) > 1, args[2], "Processed-Data")

# Check if the file exists
if (!file.exists(file_path)) {
  stop(paste("File does not exist:", file_path), call. = FALSE)
}

# Print the file being processed
cat("Processing file:", file_path, "\n")

# Read the CSV file
CO1.Coral <- read_csv(file_path)

# Ensure the data is loaded correctly
cat("Data preview:\n")
print(head(CO1.Coral))

# Custom palette
custom_colors = c(
  "steelblue", 
  "powderblue", 
  "slategray", 
  "skyblue4", 
  "lightgreen", 
  "darkgray", 
  "paleturquoise3", 
  "lightblue4", 
  "skyblue2", 
  "azure2"
)

# Unique Coral Species
Unique.Species = CO1.Coral |>
  filter(!is.na(Scientific.Name) & Scientific.Name != "") |>
  group_by(Scientific.Name) |>
  summarise(Frequency = n()) |>
  ungroup()

# Extract unique genera
Unique.Genus = Unique.Species |>
  mutate(Genus = sub("\\..*", "", Scientific.Name)) |> # Extract genus (before the first period)
  group_by(Genus) |>
  summarise(Frequency = sum(Frequency)) |> 
  arrange(desc(Frequency)) |> 
  ungroup()

# View processed genera data
cat("Unique genera and their frequencies:\n")
print(head(Unique.Genus))

# Summarize genera and frequencies 
genera.summary = Unique.Genus |> 
  summarise(
    Total_Genera = n(),                       
    Total_Frequency = sum(Frequency),        
    Average_Frequency = mean(Frequency),      
    Min_Frequency = min(Frequency),           
    Max_Frequency = max(Frequency))

cat("Genera summary:\n")
print(genera.summary)

# Dot plot
Dot.Plot = ggplot(Unique.Genus, aes(x = reorder(Genus, Frequency), y = Frequency)) +
  geom_point(color = "cadetblue", size = 3) + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.background = element_rect(fill = "white")) +  # White background
  labs(title = "Genus Frequency", x = "Genus", y = "Frequency")

cat("Dot Plot:\n")
print(Dot.Plot)

# Log transform Frequency and create a new column (log base 10)
Unique.Genus.Log = Unique.Genus |>
  mutate(Log_Frequency = log10(Frequency + 1))

# Dot Plot (log-transformed)
Dot.Plot.log = ggplot(Unique.Genus.Log, aes(x = reorder(Genus, Log_Frequency), y = Log_Frequency)) +
  geom_point(color = "cadetblue", size = 3) +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.background = element_rect(fill = "white")) +  # White background
  labs(title = "Log Transformed Genus Frequency", x = "Genus", y = "Log Frequency")

cat("Dot Plot log:\n")
print(Dot.Plot.log)

# Extract High Frequency Genera (Top 10)
High.Frequency.Genera  = Unique.Genus.Log |>
  slice_max(Frequency, n = 10) |>
  arrange(desc(Frequency)) |>
  ungroup()

cat("Top 10 genera:\n")
print(High.Frequency.Genera)

# Bar Plot of Hit Fequency 
Bar.Plot = ggplot(High.Frequency.Genera, aes(x = reorder(Genus, Frequency), y = Frequency, fill = factor(Genus))) + 
  geom_bar(stat = "identity", alpha = 0.94) + 
  scale_fill_manual(values = custom_colors) + 
  labs(title = "Top 10 Genera by Hit Frequency", x = "Genus", y = "Frequency", fill = "Genus") +  # Title and axis labels
  theme_minimal() +  # Clean theme
  theme(
    plot.background = element_rect(fill = "white"),  # Set plot background to white
    panel.background = element_rect(fill = "white"), # Set panel background to white
    legend.title = element_text(size = 12), 
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.y = element_line(color = "darkgray", linewidth = 0.5),
    panel.grid.minor.y = element_line(color = "gray90", linewidth = 0.3)
  )

cat("Bar Plot:\n")
print(Bar.Plot)

# Bar Plot Log
Bar.Plot.log = ggplot(High.Frequency.Genera, aes(x = reorder(Genus, Frequency), y = Log_Frequency, fill = factor(Genus))) + 
  geom_bar(stat = "identity", alpha = 0.94) + 
  scale_fill_manual(values = custom_colors) + 
  labs(title = "Top 10 Genera by Log Hit Frequency", x = "Genus", y = "Log Frequency", fill = "Genus") +  # Title and axis labels
  theme_minimal() +  # Clean theme
  theme(
    plot.background = element_rect(fill = "white"),  # Set plot background to white
    panel.background = element_rect(fill = "white"), # Set panel background to white
    legend.title = element_text(size = 12), 
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.y = element_line(color = "darkgray", linewidth = 0.5),
    panel.grid.minor.y = element_line(color = "gray90", linewidth = 0.3)
  )

cat("Bar Plot Log:\n")
print(Bar.Plot.log)

# Save processed data
write_csv(Unique.Species, file.path(output_dir, "unique.species.csv"))
write_csv(Unique.Genus, file.path(output_dir, "unique.genera.csv"))

# Capture command-line argument
input_args <- commandArgs(trailingOnly = TRUE)  # Renaming to avoid conflict
input_file <- input_args[1]  # Assumes the first argument is the input file name

# Get the base name of the input file (without extension)
base_name <- tools::file_path_sans_ext(input_file)

# Save the plots with descriptive names based on the input file name
ggsave(file.path(output_dir, paste0(base_name, "_visualization_processed_dot_plot.png")), Dot.Plot, dpi = 300, width = 8, height = 6)
ggsave(file.path(output_dir, paste0(base_name, "_visualization_processed_log_dot_plot.png")), Dot.Plot.log, dpi = 300, width = 8, height = 6)
ggsave(file.path(output_dir, paste0(base_name, "_visualization_processed_bar_plot.png")), Bar.Plot, dpi = 300, width = 8, height = 6)
ggsave(file.path(output_dir, paste0(base_name, "_visualization_processed_dot_plot2.png")), Bar.Plot.log, dpi = 300, width = 8, height = 6)


# Print summary
cat("Summary saved to:", output_dir, "\n")

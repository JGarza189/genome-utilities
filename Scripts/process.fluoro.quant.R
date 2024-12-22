#### INITIALIZATION ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### User defined variables ####

#### PACKAGES ####
packages_used <- 
  c(
    "tidyverse",
    "janitor",
    "readxl",
    # "purrr",
    "lubridate",
    "magrittr",
    "MASS",
    "drc"
  )

packages_to_install <- 
  packages_used[!packages_used %in% installed.packages()[,1]]

if(length(packages_to_install) > 0) {
  install.packages(packages_to_install, 
                   Ncpus = Sys.getenv("NUMBER_OF_PROCESSORS") - 1)
}

lapply(packages_used, 
       require, 
       character.only = TRUE)

#### Wrangle DATA ####
setwd('../Data')  # Move up one level and enter the Data directory
path_data_quant <- "Garza-coral_AccuBlueNGS_2024-06-12.xlsx"

data_quant <-
  read_excel(path_data_quant) %>%
  clean_names() %>%
  filter(!is.na(sample)) %>%
  mutate(type = case_when(str_detect(sample, "standard") ~ "standard",
                          TRUE ~ "sample"))

data_std <-
  data_quant %>%
  filter(
    str_detect(
      sample,
      "standard"
    ),
    #remove std below 2 pg/ul
    conc >= 2
  )

data_samples <- 
  data_quant %>%
  filter(!str_detect(sample, "standard")) %>%
  filter(!is.na(raw_rfu))

min_rfu <- min(data_std$raw_rfu * 0.75)
max_rfu <- max(data_std$raw_rfu * 1.25)

#### plot linear model ####
data_std %>%
  ggplot() +
  aes(x = conc,
      y = raw_rfu) +
  geom_point() +
  geom_smooth(
    method = "lm"
  ) +
  scale_y_log10() + 
  scale_x_log10() +
  theme_classic()


#### Fit the 4pl model ####

model_4pl <- 
  drm(
    raw_rfu ~ conc, 
    data = data_std, 
    fct = LL.4()
  )

# Summarize the model
summary(model_4pl)

# Generate predictions from the model
data_std$predicted_rfu <- predict(model_4pl)

# Plot the data and the fitted model
data_std %>%
  ggplot() +
  aes(x = conc, 
      y = raw_rfu) +
  geom_point() +
  geom_line(aes(y = predicted_rfu), color = "blue") +
  scale_y_log10() +
  scale_x_log10() +
  theme_classic() +
  labs(title = "4PL Model Fit",
       x = "Concentration",
       y = "Raw RFU")

# Function to predict concentration given raw RFU
predict_concentration <- 
  function(rfu, model) {
    if (rfu < min_rfu | rfu > max_rfu) {
      return(NA)
    }
    as.numeric(ED(model, rfu, type = "absolute", display = FALSE)[1])
  }

# Apply the function to each raw RFU in the sample data
data_pr_conc <- 
  # data_samples %>%
  data_quant %>%
  filter(conc >= 2 | is.na(conc)) %>%
  rowwise() %>%
  mutate(predicted_conc = predict_concentration(raw_rfu, model_4pl)) %>%
  ungroup() %>%
  group_by(sample,
           type) %>%
  summarize(
    mean_rfu = mean(raw_rfu,
                    na.rm = TRUE),
    sd_rfu = sd(raw_rfu,
                na.rm = TRUE),
    mean_pred_conc_pg_ul = mean(predicted_conc,
                                na.rm = TRUE),
    sd_pred_conc_pg_ul = sd(predicted_conc,
                            na.rm = TRUE)
  )

# Print the results
print(data_pr_conc)

data_pr_conc %>%
  filter(!is.nan(mean_pred_conc_pg_ul)) %>%
  ggplot() +
  aes(x = mean_pred_conc_pg_ul,
      y = mean_rfu,
      color = type) +
  geom_point() +
  geom_errorbar(
    aes(
      ymin = mean_rfu-sd_rfu, 
      ymax = mean_rfu+sd_rfu
    )
  ) +
  geom_errorbarh(
    aes(
      xmin = mean_pred_conc_pg_ul-sd_pred_conc_pg_ul,
      xmax = mean_pred_conc_pg_ul+sd_pred_conc_pg_ul
    )
  ) +
  geom_line(
    data = data_std, 
    aes(x = conc, 
        y = predicted_rfu), 
    color = "blue") +
  scale_y_log10() +
  scale_x_log10() +
  theme_classic() 

#### fit polynomial model ####

model_poly3 <- lm(raw_rfu ~ poly(log10(conc), 3), data = data_std)

summary(model_poly3)

# Generate predictions from the model
data_std$predicted_rfu <- predict(model_poly3)

# Plot the data and the fitted model
data_std %>%
  ggplot() +
  aes(x = conc, 
      y = raw_rfu) +
  geom_point() +
  geom_line(aes(y = predicted_rfu), color = "blue") +
  scale_y_log10() +
  scale_x_log10() +
  theme_classic() +
  labs(title = "Poly3 Model Fit",
       x = "Concentration",
       y = "Raw RFU")



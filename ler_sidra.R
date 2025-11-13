library(readr)

# Lê o arquivo ignorando as 3 primeiras linhas de cabeçalho extras
dados_brutos <- read_csv2("Taxa_analf.csv", skip = 3, locale = locale(decimal_mark = ","))


library(dplyr)

dados_limpos <- dados_brutos %>%
  rename(
    municipio = `Município`,
    situacao_ocupacao = `Situação de ocupação na semana de referência`,
    taxa_analfabetismo_2010 = `2010`
  ) %>%
  mutate(
    taxa_analfabetismo_2010 = as.numeric(gsub(",", ".", taxa_analfabetismo_2010))
  )

dados_para <- dados_limpos %>%
  filter(grepl("\\(PA\\)", municipio))



qtd_ocupado <- read_csv2("qtd_ocupado.csv", skip = 3, locale = locale(decimal_mark = ","))


qtd_ens_sup <- read_csv2("qtd_ens_sup.csv", skip = 3, locale = locale(decimal_mark = ","))


install.packages("stringi")

library(stringi)

extrair_cidade <- function(nome_municipio) {
  nome_municipio |>
    gsub("\\s*\\(.*\\)", "", _) |>        # remove o estado (ex: (RO))
    stri_trans_general("Latin-ASCII") |>  # remove acentos
    gsub("['`´]", "", _) |>               # remove apóstrofos
    trimws()                              # remove espaços extras
}
extrair_cidade("Alta Floresta D'Oeste (RO)")

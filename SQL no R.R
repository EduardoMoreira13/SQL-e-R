# SQL no R e Comparacao com funcoes basicas e do tidyverse

library(sqldf)
library(tidyverse)



# AULA 01 - SELECT, WHERE AND FILTERS ----

dados <- iris

# COMANDO SELECT
sqldf(" SELECT * 
        FROM dados ")

sqldf(" SELECT Species 
        FROM dados ")

sqldf(" SELECT `Sepal.Length`,  `Species`
        FROM dados ")

sqldf(" SELECT DISTINCT  `Species`
        FROM dados ")


dados # ACOES DE SELECT NO R
dados$Species
dados['Species']
dados %>% select(Species)
dados %>% select(Sepal.Length,Species)
dados[,c('Sepal.Length','Species')]
dados[,c(1,5)]
dados %>% select(Species) %>% distinct()
dados %>% select(Species) %>% unique()




#  COMANDO WHERE

sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5")

dados %>% filter(Sepal.Length > 5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` >= 5.5")

dados %>% filter(Sepal.Length >= 5.5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` = 5.5")

dados %>% filter(Sepal.Length == 5.5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` <> 5.5")

dados %>% filter(Sepal.Length != 5.5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` >= 5.5 AND `Sepal.Length` <= 6.5")

dados %>% filter(Sepal.Length >= 5.5 & Sepal.Length <= 6.5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` = 5.5 OR `Sepal.Length` = 6.5")

sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` = 5.5 OR `Sepal.Length` = 6.5")

dados %>% filter(Sepal.Length == 5.5 | Sepal.Length == 6.5)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5.5 AND SPECIES IS NULL ")

dados %>% filter(Sepal.Length > 5.5 & is.na(Species) == TRUE)
dados %>% filter(Sepal.Length > 5.5 & is.null(Species) == TRUE)

sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5.5 AND SPECIES IS NOT NULL ")

dados %>% filter(Sepal.Length > 5.5 & is.na(Species) == FALSE)
dados %>% filter(Sepal.Length > 5.5 & is.null(Species) == FALSE)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5.5 AND SPECIES = 'setosa'")

dados %>% filter(Sepal.Length > 5.5 & Species == 'setosa')


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5.5 AND SPECIES IN ('setosa')")

dados %>% filter(Sepal.Length > 5.5 & Species %in% 'setosa')


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` > 5.5 AND SPECIES NOT IN ('setosa')")

dados %>% filter(Sepal.Length > 5.5 & !Species %in% 'setosa')






# AULA 02 - COUNT, TOP/LIMIT, ORDER BY, BETWEEN, IN, LIKE ----

dados <- iris


# COMANDO COUNT
sqldf(" SELECT COUNT (*) 
        FROM dados ")

dados %>% count()


sqldf(" SELECT COUNT (SPECIES) 
        FROM dados ")

dados$Species %>% length()
dados %>% count(Species)


sqldf(" SELECT COUNT (DISTINCT SPECIES) 
        FROM dados ")

dados$Species %>% unique() %>%length()
dados %>% distinct(Species) %>% count()



# COMANDO TOP/LIMIT

sqldf(" SELECT TOP 10 * 
        FROM dados ") # NAO FUNCIONA - USAR LIMIT

sqldf(" SELECT * 
        FROM dados 
        LIMIT 10")

head(dados, 10)
tail(dados, 10)



# COMANDO ORDER

sqldf(" SELECT * 
        FROM dados
        ORDER BY `Petal.Length` 
        LIMIT 10")

dados %>% arrange(Petal.Length) %>% head(10)
dados %>% arrange(desc(Petal.Length)) %>% head(10)

sqldf(" SELECT * 
        FROM dados
        ORDER BY `Species` ASC, `Sepal.Length` DESC
        LIMIT 20 ")

dados %>% arrange(Species, desc(Sepal.Length)) %>% head(20)



# COMANDO BETWEEN

sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` BETWEEN 5.5 AND 6.5 ")

dados %>% filter(between(dados$Sepal.Length, 5.5, 6.5) == TRUE)


sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` NOT BETWEEN 5.5 AND 6.5 ")

dados %>% filter(!between(dados$Sepal.Length, 5.5, 6.5) == TRUE)




# COMANDO IN

sqldf(" SELECT * 
        FROM dados 
        WHERE `Sepal.Length` IN (5.5,6.5) ")

dados %>% filter(Sepal.Length  %in% c(5.5,6.5))


sqldf(" SELECT * 
        FROM dados 
        WHERE `Species` NOT IN ('versicolor') ")

dados %>% filter(!Species  %in% c('versicolor'))




# COMANDO LIKE

sqldf(" SELECT * 
        FROM dados 
        WHERE Species LIKE 'SE%' ") # COMECA COM

dados %>% filter(is.na(str_extract(dados$Species, "^(se)")) == FALSE)


sqldf(" SELECT * 
        FROM dados 
        WHERE Species LIKE '%LOR' ") # TERMINA EM

dados %>% filter(is.na(str_extract(dados$Species, "(.lor)")) == FALSE)


sqldf(" SELECT * 
        FROM dados 
        WHERE Species LIKE '%gin%' ") # CONTEM

dados %>% filter(is.na(str_extract(dados$Species, "(.gin.)")) == FALSE)




# AULA 03 - AS, ESTATISTICAS BASICAS, GROUP BY, HAVING ----

dados <- iris


# COMANDO AS
sqldf(" SELECT Species AS ESPECIE 
        FROM dados ")

dados %>% rename(Especie = Species) %>% 
          select(Especie)

sqldf(" SELECT Species AS 'ESPECIE' 
        FROM dados ")

dados %>% rename('Especie' = Species) %>% 
          select('Especie')

sqldf(" SELECT Species AS 'NOVA ESPECIE' 
        FROM dados ")

dados %>% rename('Nova Especie' = Species) %>% 
          select('Nova Especie')




# FORMULAS ESTATISTICAS BASICAS

sqldf(" SELECT *
        FROM dados ")

sqldf(" SELECT `Sepal.Length`
        FROM dados ")

sqldf(" SELECT SUM(`Sepal.Length`) AS Soma
        FROM dados ")

dados %>% summarise(Soma = sum(Sepal.Length))


sqldf(" SELECT AVG(`Sepal.Length`) AS Media
        FROM dados ")

dados %>% summarise(Media = mean(Sepal.Length))


sqldf(" SELECT MIN(`Sepal.Length`) AS Minimo
        FROM dados ")

dados %>% summarise(Minimo = min(Sepal.Length))


sqldf(" SELECT MAX(`Sepal.Length`) AS Maximo
        FROM dados ")

dados %>% summarise(Maximo = max(Sepal.Length))

sqldf(" SELECT MEDIAN(`Sepal.Length`) AS Mediana
        FROM dados ")

dados %>% summarise(Mediana = median(Sepal.Length))




# COMANDO GROUP BY

sqldf(" SELECT SPECIES, SUM(`Sepal.Length`) AS Soma
        FROM dados 
        GROUP BY SPECIES")

dados %>% group_by(Species) %>% 
          summarise(Soma = sum(Sepal.Length))



sqldf(" SELECT SPECIES, AVG(`Sepal.Length`) AS Media
        FROM dados 
        WHERE `Sepal.Length` < 5
        GROUP BY SPECIES")

dados %>% filter(Sepal.Length < 5) %>% 
          group_by(Species) %>% 
          summarise(Media = mean(Sepal.Length))


sqldf(" SELECT SPECIES, MIN(`Sepal.Length`) AS Minimo
        FROM dados 
        GROUP BY SPECIES
        ORDER BY Minimo ASC")

dados %>% group_by(Species) %>% 
          summarise(Minimo = min(Sepal.Length)) %>% 
          arrange(Minimo)



sqldf(" SELECT SPECIES, MAX(`Sepal.Length`) AS Maximo
        FROM dados 
        GROUP BY SPECIES
        ORDER BY Maximo DESC")

dados %>% group_by(Species) %>% 
          summarise(Maximo = max(Sepal.Length)) %>% 
          arrange(desc(Maximo))


sqldf(" SELECT SPECIES, COUNT(SPECIES) AS Contagem
        FROM dados 
        GROUP BY SPECIES
        ORDER BY Contagem")

dados %>% count(Species)

dados %>% group_by(Species) %>% 
          count(Species) %>% 
          arrange()

dados %>% group_by(Species) %>% 
          summarise(Total = n()) %>% 
          arrange(Total)



# COMANDO HAVING - COMANDO WHERE PARA A TABELA JA FILTRADA

sqldf(" SELECT SPECIES, SUM(`Sepal.Length`) AS Soma
        FROM dados 
        GROUP BY SPECIES")

dados %>% group_by(Species) %>% 
          summarise(Soma = sum(Sepal.Length))


sqldf(" SELECT SPECIES, SUM(`Sepal.Length`) AS Soma
        FROM dados 
        GROUP BY SPECIES
        HAVING Soma < 300 ")

dados %>% group_by(Species) %>% 
          summarise(Soma = sum(Sepal.Length)) %>% 
          filter(Soma < 300)


sqldf(" SELECT SPECIES, SUM(`Sepal.Length`) AS Soma
        FROM dados 
        WHERE `Sepal.Length` < 7
        GROUP BY SPECIES ")

dados %>% filter(Sepal.Length < 7) %>% 
          group_by(Species) %>% 
          summarise(Soma = sum(Sepal.Length))


sqldf(" SELECT SPECIES, SUM(`Sepal.Length`) AS Soma
        FROM dados 
        WHERE `Sepal.Length` < 7
        GROUP BY SPECIES 
        HAVING Soma < 280 ")

dados %>% filter(Sepal.Length < 7) %>%
          group_by(Species) %>% 
          summarise(Soma = sum(Sepal.Length)) %>% filter(Soma < 280)




# AULA 04 - INNER JOIN, LEFT JOIN, UNION ----

library(readr)
Person <- read_table("Person.txt", col_types = cols(ModifiedDate = col_datetime(format = "%Y-%m-%d ")))
Person$Number = seq(100,10000,100)

Bussiness <- read_table("Bussiness.txt", col_types = cols(ModifiedDate = col_datetime(format = "%Y-%m-%d ")))
Bussiness$BusinessEntityID[c(1,4,66,88,90)] <- c(101,102,103,104,105)


# COMANDO INNER JOIN  

head(Person)
head(Bussiness)

sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        INNER JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        ")

A = Person %>% select(BusinessEntityID, FirstName, LastName)
B = Bussiness %>% select(BusinessEntityID, EmailAddress)

A %>% inner_join(B, by = c('BusinessEntityID')) # possivel usar multiplas colunas




# COMANDO LEFT JOIN

head(Person)
head(Bussiness)

sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        LEFT JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        ")

A = Person %>% select(BusinessEntityID, FirstName, LastName)
B = Bussiness %>% select(BusinessEntityID, EmailAddress)

A %>% left_join(B, by = c('BusinessEntityID')) # possivel usar multiplas colunas



sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        LEFT JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        WHERE B.BusinessEntityID is null
        ")

A %>% left_join(B, by = c('BusinessEntityID')) %>% 
      filter(is.na(EmailAddress) == TRUE)



# COMANDO RIGHT JOIN

sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        RIGHT JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        ")

A = Person %>% select(BusinessEntityID, FirstName, LastName)
B = Bussiness %>% select(BusinessEntityID, EmailAddress)

A %>% right_join(B, by = c('BusinessEntityID')) %>% print(n = 100) 


sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        RIGHT JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        WHERE A.BusinessEntityID is null
        ")

A %>% right_join(B, by = c('BusinessEntityID')) %>% 
      filter(is.na(FirstName) == TRUE)



# COMANDO FULL JOIN

sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        FULL OUTER JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        WHERE A.BusinessEntityID is null or B.BusinessEntityID is null
        ")

A %>% full_join(B, by = c('BusinessEntityID')) %>% 
      filter(is.na(FirstName) == TRUE | is.na(EmailAddress) == TRUE)


sqldf(" SELECT A.BusinessEntityID, A.FirstName, A.LastName, 
               B.BusinessEntityID, B.EmailAddress
        FROM Person AS A
        FULL OUTER JOIN Bussiness AS B 
        ON A.BusinessEntityID = B.BusinessEntityID
        ")

A %>% full_join(B, by = c('BusinessEntityID')) 



# COMANDO UNION

sqldf(" SELECT FirstName, LastName, BusinessEntityID
        FROM Person
        WHERE BusinessEntityID <= 40
        UNION -- RETIRA DUPLICADOS
        SELECT FirstName, LastName, BusinessEntityID
        FROM Person
        WHERE BusinessEntityID > 25 
        ")

A = Person %>% select(FirstName, LastName, BusinessEntityID) %>% 
               filter(BusinessEntityID <= 40)
B = Person %>% select(FirstName, LastName, BusinessEntityID) %>% 
               filter(BusinessEntityID > 25)

bind_rows(A, B) %>% distinct() %>% print(n = 100) 


sqldf(" SELECT FirstName, LastName, BusinessEntityID
        FROM Person
        WHERE BusinessEntityID <= 40
        UNION ALL -- NAO RETIRA DUPLICADOS
        SELECT FirstName, LastName, BusinessEntityID
        FROM Person
        WHERE BusinessEntityID > 25 
        ")

bind_rows(A, B) %>% print(n = 100) 



# AULA 05 - SELF JOIN, SUBQUERY, DATEPART, STRINGS, MATH OPERATIONS ----

library(readr)
Person <- read_table("Person.txt", col_types = cols(ModifiedDate = col_datetime(format = "%Y-%m-%d ")))
Person$Number = seq(100,10000,100)

Bussiness <- read_table("Bussiness.txt", col_types = cols(ModifiedDate = col_datetime(format = "%Y-%m-%d ")))
Bussiness$BusinessEntityID[c(1,4,66,88,90)] <- c(101,102,103,104,105)


# COMANDO SELF JOIN 

head(Person)
head(Bussiness)

sqldf(" SELECT A.FirstName, A.LastName, B.FirstName, B.LastName
        FROM Person AS A, Person AS B
        WHERE A.FirstName = B.FirstName ")

A = Person %>% select(FirstName, LastName) 

A %>% left_join(A, by = ("FirstName"), relationship = "many-to-many", keep = T)


sqldf(" SELECT A.FirstName, A.LastName, B.FirstName, B.LastName
        FROM Person AS A, Person AS B
        WHERE A.FirstName = B.FirstName and A.LastName <> B.LastName
        ORDER BY A.FirstName")

A %>% left_join(A, by = ("FirstName"), relationship = "many-to-many", keep = T) %>% 
      filter(LastName.x != LastName.y)




# COMANDO SUBQUERY (SUBSELECT)

head(Person)
head(Bussiness)

sqldf(" SELECT BusinessEntityID
        FROM Bussiness ")

Bussiness %>% select(BusinessEntityID)

sqldf(" SELECT AVG(Number) / 100 
        FROM Person ")

Person %>% summarise(calculo = mean(Number)/100)


sqldf(" SELECT BusinessEntityID
        FROM Bussiness
        WHERE BusinessEntityID > (SELECT AVG(Number) / 100 FROM Person) ")


media = Person %>% summarise(calculo = mean(Number)/100) %>% as.numeric()

Bussiness %>% filter(BusinessEntityID > media) %>% select(BusinessEntityID)



sqldf(" SELECT BusinessEntityID 
        FROM Person ")

Person %>% select(BusinessEntityID)


sqldf(" SELECT BusinessEntityID, EmailAddressID
        FROM Bussiness
        WHERE EmailAddressID IN (SELECT BusinessEntityID FROM Person) ")

vetor = Person %>% select(BusinessEntityID) %>% unlist() %>% as.numeric()

Bussiness %>% filter(EmailAddressID %in% vetor) %>% select(BusinessEntityID)



# MANIPULACAO DE TEXTO - (STRINGS)

sqldf(" SELECT FirstName, LastName
        FROM Person ")

Person %>% select(FirstName, LastName)


sqldf(" SELECT CONCAT(FirstName, ' ',LastName) AS NOME
        FROM Person ")

Person %>% transmute(Nome = str_c(FirstName, " ", LastName))


sqldf(" SELECT UPPER(CONCAT(FirstName, ' ',LastName)) AS NOME
        FROM Person ")

Person %>% transmute(Nome = str_to_upper(str_c(FirstName, " ", LastName)))


sqldf(" SELECT LOWER(CONCAT(FirstName, ' ',LastName)) AS NOME
        FROM Person ")

Person %>% transmute(Nome = str_to_lower(str_c(FirstName, " ", LastName)))


sqldf(" SELECT LENGTH(FirstName) AS TAMANHO # LEN NAO FUNCIONA
        FROM Person ")

Person %>% transmute(Nome = length(str_c(FirstName, " ", LastName))) 


sqldf(" SELECT FirstName, SUBSTRING(FirstName, 1, 3), SUBSTRING(FirstName, 3, 2)
        FROM Person ")

Person %>% transmute(FirstName, Sub1 = str_sub(FirstName, 1, 3),
                     Sub2 = str_sub(FirstName, 3, 4)) 


sqldf(" SELECT FirstName, REPLACE(FirstName, 'a', 'XXX')
        FROM Person ")

Person %>% transmute(FirstName, Sub1 = str_replace(FirstName, 'a', 'XXX'))



# OPERACOES MATEMATICAS

sqldf(" SELECT NUMBER, NUMBER - NUMBER, NUMBER + NUMBER
        FROM Person ")

Person %>% transmute(Number, diferenca = (Number - Number),
                     soma = (Number + Number))

sqldf(" SELECT NUMBER, NUMBER * NUMBER, NUMBER / NUMBER
        FROM Person ")

Person %>% transmute(Number, mult = (Number * Number),
                     div = (Number / Number))


sqldf(" SELECT SUM(NUMBER), MIN(NUMBER), MAX(NUMBER), AVG(NUMBER), MEDIAN(NUMBER)
        FROM Person ")

Person %>% summarise(soma = sum(Number),media = mean(Number),
                    minimo = min(Number),maximo = max(Number),
                    mediana = median(Number))


sqldf(" SELECT SQRT(MAX(NUMBER)), ROUND(AVG(NUMBER) + 1.66666, 1)
        FROM Person ")

Person %>% summarise(raiz = sqrt(max(Number)),
                     media = round(mean(Number)+ 1.66666, 1))


sqldf(" SELECT FLOOR(AVG(NUMBER) + 1.66666), CEILING(AVG(NUMBER) + 1.66666)
        FROM Person ")

Person %>% summarise(media1 = floor(mean(Number)+ 1.66666),
                     media2 = ceiling(mean(Number)+ 1.66666))


sqldf(" SELECT FLOOR(AVG(NUMBER) + 1.66666)
        FROM Person ")

Person %>% summarise(media1 = floor(mean(Number)+ 1.66666))


sqldf(" SELECT POWER(NUMBER, 3), SQUARE(NUMBER), EXP(NUMBER/1000)
        FROM Person ")

Person %>% reframe(pot = (Number)^3, quad = (Number)^2, expon = exp(Number/1000))
Person %>% transmute(pot = (Number)^3, quad = (Number)^2, expon = exp(Number/1000))


sqldf(" SELECT SIN(NUMBER), COS(NUMBER), TAN(NUMBER)
        FROM Person ")

Person %>% reframe(seno = sin(Number), cose = cos(Number), tang = tan(Number))
Person %>% transmute(seno = sin(Number), cose = cos(Number), tang = tan(Number))


sqldf(" SELECT NUMBER, NTILE(4) OVER(ORDER BY NUMBER ASC) AS Quartile 
        FROM Person ")

quantile(Person$Number)



# AULA 06 - FUNCOES DE JANELA ----


# Soma acumulada

sqldf(" SELECT `Sepal.Length`, 
        SUM(`Sepal.Length`) OVER(ORDER BY `Sepal.Length` ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma acumulada'
        FROM dados
        ORDER BY `Sepal.Length` 
        LIMIT 10") 

dados %>%  arrange(`Sepal.Length`) %>%  transmute(`Sepal.Length`,
           SA = cumsum(`Sepal.Length`))  %>% head(10)


# Vetorizacao de uma informacao agrupada

sqldf(" SELECT Species, AVG(`Sepal.Length`) AS 'Media' -- AGRUPA
        FROM dados
        GROUP BY Species")

dados %>% group_by(Species) %>% summarise(Media = mean(`Sepal.Length`))


sqldf(" SELECT Species, AVG(`Sepal.Length`) OVER() AS 'Media' -- REPETE A INFORMACAO
        FROM dados
        ORDER BY Species")

dados %>% transmute(Species, Media = mean(`Sepal.Length`))

sqldf(" SELECT Species, AVG(`Sepal.Length`) OVER(PARTITION BY Species) AS 'Media'
        FROM dados -- REPETE A INFORMACAO POR GRUPO
        ORDER BY Species")

valores = dados %>% group_by(Species) %>% summarise(Media = mean(`Sepal.Length`))

dados %>% transmute(Species, Media = case_when(Species == 'setosa' ~ as.numeric(valores[1,2]),
                                               Species == 'versicolor' ~ as.numeric(valores[2,2]),
                                               .default = as.numeric(valores[3,2])))



# AULA 07 - CASE WHEN ----

sqldf(" SELECT * 
        FROM dados ")

sqldf(" SELECT Species, `Sepal.Length`,
        CASE WHEN Species = 'setosa' THEN  'Classe A'
            ELSE 'Classe B'
            END AS Classificacao
        FROM dados ")

dados %>% transmute(Species, `Sepal.Length`,
                    Classificacao = case_when(Species == 'setosa' ~ 'Classe A',
                                              .default = 'Classe B'))


sqldf(" SELECT Species, `Sepal.Length`,
        CASE WHEN `Sepal.Length` BETWEEN 4 AND 5  THEN  'Classe A'
             WHEN `Sepal.Length` BETWEEN 5 AND 6  THEN  'Classe B'
             ELSE 'Classe C'
             END AS Classificacao
        FROM dados ")

dados %>% transmute(Species, `Sepal.Length`,
                    Classificacao = case_when(between(`Sepal.Length`,4,5) == T ~ 'Classe A',
                                              between(`Sepal.Length`,5,6) == T ~ 'Classe B',
                                              .default = 'Classe C'))


sqldf(" SELECT Species, `Sepal.Length`,
        CASE WHEN `Sepal.Length` <= 5  THEN  (`Sepal.Length` + 5)
             WHEN `Sepal.Length` <= 6  THEN  (`Sepal.Length` + 3)
             ELSE (`Sepal.Length` + 1)
             END AS Classificacao
        FROM dados
        ORDER BY `Sepal.Length`")

dados %>% transmute(Species, `Sepal.Length`,
                    Classificacao = case_when(`Sepal.Length` <= 5 ~  (`Sepal.Length` + 5),
                                              `Sepal.Length` <= 6 ~  (`Sepal.Length` + 3),
                                              .default = (`Sepal.Length` + 1))) %>% 
  arrange(`Sepal.Length`)



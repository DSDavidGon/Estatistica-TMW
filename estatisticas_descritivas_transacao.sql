WITH 
tb_subset_mediana AS (
    SELECT qtdPontos 
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT COUNT(*) / 2 FROM points)
),

tb_mediana AS (
    SELECT AVG(qtdPontos) AS Mediana
    FROM tb_subset_mediana
),

tb_subset_quartil_01 AS (
    SELECT qtdPontos 
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT COUNT(*) / 4 FROM points)
),

tb_quartil_01 AS (
    SELECT AVG(qtdPontos) AS Quartil_1
    FROM tb_subset_quartil_01
),

tb_subset_quartil_03 AS (
    SELECT qtdPontos 
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT 3 * COUNT(*) / 4 FROM points)
),

tb_quartil_03 AS (
    SELECT AVG(qtdPontos) AS Quartil_3
    FROM tb_subset_quartil_03
),

tb_stats as (
    SELECT
    min(qtdPontos) as Minimo,
    avg(qtdPontos) as Media,
    max(qtdPontos) as Maximo

    FROM points
)

SELECT 
    Mediana,
    Quartil_1,
    Quartil_3,
    Minimo,
    Maximo,
    Media

    
FROM 
    tb_mediana, tb_quartil_01, tb_quartil_03, tb_stats;

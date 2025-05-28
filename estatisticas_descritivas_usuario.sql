WITH tb_usuario as(

    SELECT idUsuario,
    sum(qtdPontos) as qtdPontos
    FROM points
    GROUP BY idUsuario
),

tb_subset_mediana AS (
    SELECT qtdPontos 
    FROM tb_usuario
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM tb_usuario)
    OFFSET (SELECT COUNT(*) / 2 FROM tb_usuario)
),

tb_mediana AS (
    SELECT AVG(qtdPontos) AS Mediana
    FROM tb_subset_mediana
),

tb_subset_quartil_01 AS (
    SELECT qtdPontos 
    FROM tb_usuario
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM tb_usuario)
    OFFSET (SELECT COUNT(*) / 4 FROM tb_usuario)
),

tb_quartil_01 AS (
    SELECT AVG(qtdPontos) AS Quartil_1
    FROM tb_subset_quartil_01
),

tb_subset_quartil_03 AS (
    SELECT qtdPontos 
    FROM tb_usuario
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM tb_usuario)
    OFFSET (SELECT 3 * COUNT(*) / 4 FROM tb_usuario)
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

    FROM tb_usuario
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
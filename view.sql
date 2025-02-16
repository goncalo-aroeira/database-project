DROP VIEW if exists Vendas;
CREATE VIEW Vendas(ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades)
AS
        SELECT
        ean AS ean,
        nome_categoria AS cat,
        EXTRACT(YEAR FROM instante) AS ano,
        ROUND(EXTRACT(MONTH FROM instante) / 4 + 1) AS trimestre,
        EXTRACT(MONTH FROM instante) AS mes,
        EXTRACT(DAY FROM instante) AS dia_mes,
        CASE
                WHEN EXTRACT(dow FROM instante) = 0 THEN 'Sunday'
                WHEN EXTRACT(dow FROM instante) = 1 THEN 'Monday'
                WHEN EXTRACT(dow FROM instante) = 2 THEN 'Tuesday'
                WHEN EXTRACT(dow FROM instante) = 3 THEN 'Wednesday'
                WHEN EXTRACT(dow FROM instante) = 4 THEN 'Thursday'
                WHEN EXTRACT(dow FROM instante) = 5 THEN 'Friday'
                WHEN EXTRACT(dow FROM instante) = 6 THEN 'Saturday'
        END dia_semana,
        distrito AS distrito,
        concelho AS concelho,
        unidades_repostas AS unidades
        FROM produto NATURAL JOIN evento_reposicao NATURAL JOIN instalada_em NATURAL JOIN ponto_de_retalho;
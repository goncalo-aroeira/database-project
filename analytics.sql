SELECT dia_semana, concelho, SUM(unidades) AS res FROM Vendas 
WHERE (Vendas.ano = 2022 AND Vendas.mes >= 8 AND Vendas.dia_mes >=1) AND (Vendas.ano = 2022 AND Vendas.mes <= 9 AND Vendas.dia_mes <=29)
GROUP BY ROLLUP ((dia_semana), (concelho));


SELECT concelho, cat, dia_semana, SUM(unidades) AS res 
FROM Vendas 
WHERE Vendas.distrito = 'Lisboa' 
GROUP BY ROLLUP((concelho), (cat), (dia_semana));

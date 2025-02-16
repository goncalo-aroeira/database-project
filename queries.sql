/*Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de categorias?*/
SELECT nome_retalhista 
FROM retalhista
WHERE tin IN (
SELECT tin
FROM responsavel_por 
GROUP BY tin
HAVING COUNT(nome_categoria) >= ALL
	(SELECT COUNT(nome_categoria)
	FROM responsavel_por
	GROUP BY tin)
);


/*Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples?*/
select distinct nome_retalhista from (
    select nome_retalhista, count(distinct nome_categoria) from (        
            select nome_retalhista, nome_categoria from responsavel_por natural join retalhista natural join categoria_simples)
    as ret_cat group by nome_retalhista
) as ret_count
where count = (select count(*) from categoria_simples);

 
/*Quais os produtos (ean) que nunca foram repostos? */
select ean from produto where ean not in (select ean from evento_reposicao);


/*Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista?*/
select ean from evento_reposicao group by ean having count(distinct tin) = 1;
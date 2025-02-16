CREATE OR REPLACE FUNCTION check_categoria()
RETURNS TRIGGER AS
$$
BEGIN 
	IF NEW.super_categoria = NEW.categoria_filha THEN
		RAISE EXCEPTION 'A categoria não pode estar contida em si própria';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_categoria
BEFORE UPDATE OR INSERT ON tem_outra 
FOR EACH ROW EXECUTE PROCEDURE check_categoria();



CREATE OR REPLACE FUNCTION check_excesso_unidades()
RETURNS TRIGGER AS
$$
DECLARE
	T planograma%ROWTYPE;
BEGIN
	SELECT *
	INTO T
	FROM planograma
	WHERE ean = NEW.ean;
	IF T.unidades < NEW.unidades_repostas THEN
		RAISE EXCEPTION 'Número de unidades repostas não pode exceder as definidas pelo planograma';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_excesso_unidades
BEFORE UPDATE OR INSERT ON evento_reposicao 
FOR EACH ROW EXECUTE PROCEDURE check_excesso_unidades();



CREATE OR REPLACE FUNCTION check_reposição_produto()
RETURNS TRIGGER AS
$$
DECLARE
    T_prat prateleira%ROWTYPE;
BEGIN
    SELECT *
    INTO T_prat
    FROM prateleira
    WHERE prateleira.nro = NEW.nro AND prateleira.num_serie = NEW.num_serie AND prateleira.fabricante = NEW.fabricante;

    IF T_prat.nome_categoria NOT IN ( 
        SELECT nome_categoria 
        FROM tem_categoria 
        WHERE tem_categoria.ean = NEW.ean) THEN 
            RAISE EXCEPTION 'Produto reposto na prateleria não pretence a nenhuma das categorias da mesma';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_reposição_produto
BEFORE UPDATE OR INSERT ON evento_reposicao 
FOR EACH ROW EXECUTE PROCEDURE check_reposição_produto();
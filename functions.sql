DELIMITER $$
CREATE FUNCTION calcular_puntaje_equipo(id_equipo)
RETURNS INT
BEGIN
    DECLARE suma_puntaje INT;

    SELECT SUM(j.puntaje) INTO suma_puntaje 
    FROM seleccionados s
    JOIN jugadores j ON j.id = s.id_jugador
    WHERE s.id_equipo = id_equipo;

    RETURN suma_puntaje;
END$$

CREATE FUNCTION calcular_saldo_usuario(id_usuario INT, id_jugador INT, operador VARCHAR(1))
RETURNS INT
BEGIN
    DECLARE saldo_inicial INT;
    DECLARE saldo_actualizado INT;
    DECLARE precio_jugador INT;

    SELECT saldo INTO saldo_inicial
    FROM usuarios u
    WHERE u.id = id_usuario;

    SELECT precio INTO precio_jugador
    FROM jugadores j
    WHERE j.id = id_jugador;

    SET saldo_actualizado = CASE operador
        WHEN '+' THEN saldo_actualizado + precio_jugador
        WHEN '-' THEN saldo_actualizado - precio_jugador
    ELSE NULL
    END;

    UPDATE usuarios u SET saldo = saldo_actualizado 
    WHERE u.id = id_usuario;

    RETURN saldo_actualizado;
END$$

CREATE FUNCTION obtener_saldo_usuario(id_usuario INT)
RETURNS INT
BEGIN
    DECLARE saldo_usuario INT;

    SELECT saldo INTO saldo_usuario
    FROM usuarios u
    WHERE u.id = id_usuario;

    RETURN saldo_usuario;
END$$

CREATE FUNCTION calcular_puntaje_usuario(id_usuario INT)
RETURNS INT
BEGIN
    DECLARE equipo_id INT;
    DECLARE suma_puntaje_jugadores INT;

    SELECT e.id INTO equipo_id
    FROM equipos e  
    WHERE e.id_usuario = id_usuario;

    SELECT SUM(j.puntaje) INTO suma_puntaje_jugadores
    FROM jugadores j 
    JOIN seleccionados s ON s.id_jugador = j.id
    WHERE s.id_equipo = equipo_id;

    RETURN suma_puntaje_jugadores;
END$$

CREATE FUNCTION obtener_usuario_ganador()
RETURNS INT
BEGIN
    DECLARE id_usuario_ganador INT;

    SELECT u.id INTO id_usuario_ganador
    FROM usuarios u 
    ORDER BY u.puntaje DESC
    LIMIT 1;

    RETURN id_usuario_ganador;
END$$
DELIMITER ;
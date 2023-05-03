DELIMITER $$
CREATE PROCEDURE insertar_posicion( posicion VARCHAR(10))
BEGIN
    INSERT INTO posiciones (posicion) VALUES (posicion);
END$$

CREATE PROCEDURE insertar_jugador( nombre VARCHAR(25), apellido VARCHAR(25), precio INT, puntaje INT, id_posicion INT, lesionado BOOLEAN)
BEGIN
    INSERT INTO jugadores(nombre, apellido, precio, puntaje, id_posicion, lesionado) 
    VALUES (nombre, apellido, precio, puntaje, id_posicion, lesionado);
END$$

CREATE PROCEDURE insertar_usuario(mail VARCHAR(25), clave VARCHAR(16),  saldo INT, puntaje INT)
BEGIN
    INSERT INTO usuarios(mail, clave, saldo, puntaje) VALUES (mail, clave, saldo, puntaje);
END$$

CREATE PROCEDURE insertar_equipos(nombre VARCHAR(25), id_usuario INT)
BEGIN
    INSERT INTO equipos(nombre, id_usuario) 
    VALUES (nombre, id_usuario);
END$$

CREATE PROCEDURE insertar_seleccionados(id_jugador INT, id_equipo INT, titular BOOLEAN)
BEGIN
    INSERT INTO seleccionados(id_jugador, id_equipo, titular) 
    VALUES (id_jugador, id_equipo, titular);
END$$

CREATE PROCEDURE jugadores_equipo(id_equipo INT)
BEGIN
    SELECT j.nombre AS nombre, j.apellido AS apellido, p.posicion AS posicion, 
    s.titular AS titular, j.lesionado AS lesionado, j.puntaje AS puntaje
    FROM seleccionados s
    JOIN jugadores j ON j.id = s.id_jugador
    JOIN posiciones p ON p.id = j.id_posicion
    WHERE s.id_equipo = id_equipo
    ORDER BY s.id;
END$$

CREATE PROCEDURE consultar_equipo(id_equipo INT)
BEGIN
    SELECT j.nombre, j.apellido, j.lesionado, s.titular
    FROM jugadores j 
    JOIN seleccionados s ON j.id = s.id_jugador
    JOIN equipos e ON e.id = s.id_equipo
    WHERE e.id = id_equipo
    ORDER BY s.titular DESC;
END$$

CREATE PROCEDURE cambiar_titularidad(id_jugador INT, id_equipo INT, titularidad BOOLEAN)
BEGIN
    DECLARE posicion_jugador INT;
    DECLARE jugador_en_posicion INT;

    SELECT j.id_posicion INTO posicion_jugador
    FROM jugadores j
    WHERE j.id = id_jugador;

    SELECT j.id INTO jugador_en_posicion
    FROM jugadores j
    JOIN seleccionados s ON j.id = s.id_jugador
    WHERE s.id_equipo = id_equipo AND j.id_posicion = posicion_jugador AND j.id != id_jugador;

    UPDATE seleccionados s
    SET titular = NOT titularidad
    WHERE s.id_jugador = jugador_en_posicion AND s.id_equipo = id_equipo;

    UPDATE seleccionados s
    SET titular = titularidad
    WHERE s.id_jugador = id_jugador AND s.id_equipo = id_equipo;
END$$

CREATE PROCEDURE manejar_lesion_jugador(id_jugador INT)
BEGIN
    UPDATE jugadores j 
    SET j.lesionado = NOT j.lesionado
    WHERE j.id = id_jugador;

    SELECT lesionado FROM jugadores j
    WHERE j.id = id_jugador;
END$$

CREATE PROCEDURE manejar_precio_jugador(id_jugador INT, nuevo_precio INT)
BEGIN
    UPDATE jugadores j 
    SET precio = nuevo_precio
    WHERE j.id = id_jugador;
END$$

CREATE PROCEDURE manejar_puntaje_jugador(id_jugador INT, nuevo_puntaje INT)
BEGIN
    UPDATE jugadores j
    SET puntaje = nuevo_puntaje
    WHERE j.id = id_jugador;
END$$

CREATE PROCEDURE cargar_puntajes_usuarios()
BEGIN
    DECLARE usuario_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT u.id FROM usuarios u;
    DECLARE EXIT HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    WHILE NOT done DO
        FETCH cur INTO usuario_id;
        IF NOT done THEN
            CALL manejar_puntaje_usuario(usuario_id);
        END IF;
    END WHILE;
    CLOSE cur;
END$$

CREATE PROCEDURE obtener_top_usuarios()
BEGIN
    SELECT u.id, e.id AS id_equipo, u.mail, e.nombre AS equipo, u.puntaje 
    FROM usuarios u
    JOIN equipos e ON u.id = e.id_usuario
    ORDER BY u.puntaje DESC
    LIMIT 3;
END$$

CREATE PROCEDURE manejar_puntaje_usuario(id_usuario INT)
BEGIN
    UPDATE usuarios u
    SET puntaje = calcular_puntaje_usuario(id_usuario)
    WHERE u.id = id_usuario;    
END$$
DELIMITER ;
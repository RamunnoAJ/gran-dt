DELIMITER $$
CREATE TRIGGER tr_cargar_puntaje_usuario AFTER UPDATE ON jugadores
FOR EACH ROW
BEGIN
    DECLARE usuario_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR 
    SELECT u.id 
    FROM usuarios u
    JOIN equipos e ON e.id_usuario = u.id
    JOIN seleccionados s ON s.id_equipo = e.id
    WHERE s.id_jugador = NEW.id AND s.id_equipo = e.id;
    DECLARE EXIT HANDLER FOR NOT FOUND SET done = 1; 

    IF !(NEW.puntaje <=> OLD.puntaje) THEN
        OPEN cur;
        WHILE NOT done DO
            FETCH cur INTO usuario_id;
            IF NOT done THEN
                CALL manejar_puntaje_usuario(usuario_id);
            END IF;
        END WHILE;
        CLOSE cur;
    END IF;
END$$

CREATE TRIGGER tr_actualizar_titularidad_lesionado AFTER UPDATE ON jugadores
FOR EACH ROW
BEGIN 
    DECLARE equipo_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT s.id_equipo FROM seleccionados s WHERE s.id_jugador = NEW.id AND s.titular = 1;
    DECLARE EXIT HANDLER FOR NOT FOUND SET done = 1;

    IF !(NEW.lesionado <=> OLD.lesionado) AND NEW.lesionado = 1 THEN
        OPEN cur;
        WHILE NOT done DO
            FETCH cur INTO equipo_id;
            IF NOT done THEN
                CALL cambiar_titularidad(NEW.id, equipo_id, 0);
            END IF;
        END WHILE;
        CLOSE cur;
    END IF;
END$$
DELIMITER ;
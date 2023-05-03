# GRAN DT

Es una base de datos que imita el flujo de datos del juego gran dt donde los usuarios tienen sus equipos y sus puntajes.

Estos usuarios armarían su equipo con los jugadores existentes en la tabla de jugadores, cuentan con un saldo inicial el cual se utiliza para comprar los jugadores e incluirlos a su equipo.

Los jugadores tienen un precio y una posición asignada, los equipos se conforman de 10 jugadores, habiendo 5 posiciones, cada equipo deberá contar con 2 jugadores por posición.

Este proyecto está desarrollado usando MySQL con el motor de XAMPP.

## Tablas

### • Usuarios

| Field   | Type    | Extra          | Key     |
|---------|---------|----------------|---------|
| id      | int     | auto_increment | PRIMARY |
| mail    | varchar |                |         |
| clave   | varchar |                |         |
| saldo   | int     |                |         |
| puntaje | int     |                |         |

### • Equipos

| Field      | Type    | Extra          | Key     |
|------------|---------|----------------|---------|
| id         | int     | auto_increment | PRIMARY |
| nombre     | varchar |                |         |
| id_usuario | int     |                | FOREIGN |

### • Jugadores

| Field       | Type    | Extra          | Key     |
|-------------|---------|----------------|---------|
| id          | int     | auto_increment | PRIMARY |
| nombre      | varchar |                |         |
| apellido    | varchar |                |         |
| precio      | int     |                |         |
| puntaje     | int     |                |         |
| id_posicion | int     |                | FOREIGN |
| lesionado   | boolean |                |         |

### • Posiciones

| Field    | Type    | Extra          | Key     |
|----------|---------|----------------|---------|
| id       | int     | auto_increment | PRIMARY |
| posicion | varchar |                |         |

### • Seleccionados

| Field      | Type    | Extra          | Key     |
|------------|---------|----------------|---------|
| id         | int     | auto_increment | PRIMARY |
| id_jugador | int     |                | FOREIGN |
| id_equipo  | int     |                | FOREIGN |
| titular    | boolean |                |         |

## Procedimientos

### • **insertar_posicion(posicion)**: 
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace un INSERT en la tabla posiciones, recibe un parámetro de tipo string.

### • **insertar_jugador(nombre, apellido, precio, puntaje, id_posicion, lesionado)**: 
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace un INSERT en la tabla jugadores, recibe 6 parámetros con sus tipos de dato (nombre: string, apellido: string, precio: number, puntaje: number, id_posicion: number, lesionado: boolean).

### • **insertar_usuario(mail, clave, saldo, puntaje)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace un INSERT en la tabla usuarios, recibe 4 parámetros con sus tipos de dato (mail: string, clave: string, saldo: number, puntaje: number).

### • **insertar_equipos(nombre, id_usuario)**: 
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace un INSERT en la tabla equipos, recibe 2 parámetros con sus tipos de dato (nombre: string, id_usuario: number).

### • **insertar_seleccionados(id_jugador, id_equipo, titular)**: 
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace un INSERT en la tabla seleccionados, recibe 3 parámetros con sus tipos de dato (id_jugador: number, id_equipo: number, titular: boolean).

### • **consultar_equipo(id_equipo)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento realiza una consulta que muestra los nombres, apellidos, estado de lesión y titularidad de los jugadores en un equipo específico, recibe 1 parámetro de tipo number.

### • **cambiar_titularidad(id_jugador, id_equipo, titularidad)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento hace dos updates para cambiar la titularidad del jugador que le pasemos en el equipo seleccionado, le cambia la titularidad a ese jugador y al que tenga la misma posicion dentro del mismo equipo a la titularidad contraria. Recibe 3 parámetros con sus tipos de dato (id_jugador: number, id_equipo: number, titularidad: boolean).

### • **manejar_lesion_jugador(id_jugador)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento ejecuta un UPDATE de la propiedad lesionado del jugador que seleccionemos, recibe 1 solo parámetro de tipo number.

### • **manejar_precio_jugador(id_jugador, nuevo_precio)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento ejecuta un UPDATE de la propiedad precio del jugador seleccionado al valor indicado. Recibe 2 parámetros con sus tipos de dato (id_jugador: number, nuevo_precio: number).

### • **manejar_puntaje_jugador(id_jugador, nuevo_puntaje)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento ejecuta un UPDATE de la propiedad puntaje del jugador seleccionado al valor indicado. Recibe 2 parámetros con sus tipos de dato (id_jugador: number, nuevo_puntaje: number).

### • **manejar_puntaje_usuario(id_usuario, nuevo_puntaje)**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento ejecuta un UPDATE de la propiedad precio del usuario seleccionado al valor indicado. Recibe 2 parámetros con sus tipos de dato (id_usuario: number, nuevo_puntaje: number).

### • **cargar_puntajes_usuarios**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento recorre todos los usuarios y ejecuta el procedimiento **manejar_puntaje_usuario** con el valor de cada usuario.

### • **obtener_top_usuarios**:
&nbsp;&nbsp;&nbsp;&nbsp;Este procedimiento selecciona los datos de los 3 usuarios que tengan el puntaje más alto.

## Funciones

### • **calcular_puntaje_equipo(id_equipo)**:
&nbsp;&nbsp;&nbsp;&nbsp;Esta función devuelve la suma de los puntajes de todos los jugadores en un equipo. Recibe un parámetro de tipo number.

### • **calcular_saldo_usuario(id_usuario, id_jugador, operador)**:
&nbsp;&nbsp;&nbsp;&nbsp;Esta función devuelve el saldo actualizado del usuario que le envíemos, va a restar o sumar el precio del jugador a su saldo dependiendo de la acción que realicemos. Recibe 3 parámetros con sus tipos de datos (id_usuario: number, id_jugador: number, operador: string).

### • **obtener_saldo_usuario(id_usuario)**:
&nbsp;&nbsp;&nbsp;&nbsp;Esta función devuelve el saldo del usuario que seleccionemos. Toma como parámetro un solo argumento de tipo number.

### • **calcular_puntaje_usuario(id_usuario)**:
&nbsp;&nbsp;&nbsp;&nbsp;Esta función devuelve la suma del puntaje de todos los jugadores que formen parte del equipo que pertenece al usuario. Recibe como parámetro un solo argumento de tipo number.

### • **obtener_usuario_ganador**:
&nbsp;&nbsp;&nbsp;&nbsp;Esta función devuelve el usuario con mayor puntaje.

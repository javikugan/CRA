
    :- use_module(library(clpfd)).

% Inicializa el tablero de Sudoku con variables para las casillas vacías.
inicializar_tablero(Tablero) :-
    Tablero = [[5, 3, _, _, 7, _, _, _, _],
               [6, _, _, 1, 9, 5, _, _, _],
               [_, 9, 8, _, _, _, _, 6, _],
               [8, _, _, _, 6, _, _, _, 3],
               [4, _, _, 8, _, 3, _, _, 1],
               [7, _, _, _, 2, _, _, _, 6],
               [_, 6, _, _, _, _, 2, 8, _],
               [_, _, _, 4, 1, 9, _, _, 5],
               [_, _, _, _, 8, _, _, 7, 9]],
    append(Tablero, Vars),
    Vars ins 1..9.

% Aplica restricciones de Sudoku a las variables.
aplicar_restricciones(Tablero) :-
    maplist(all_distinct, Tablero), % Todas las filas deben tener números distintos.
    transpose(Tablero, Transpuesto),
    maplist(all_distinct, Transpuesto), % Todas las columnas deben tener números distintos.
    Tablero = [A,B,C,D,E,F,G,H,I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I). % Subcuadrículas 3x3 con números distintos.

blocks([], [], []).
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
    all_distinct([A,B,C,D,E,F,G,H,I]),
    blocks(Bs1, Bs2, Bs3).

% Nueva función para imprimir el tablero resuelto.
imprimir_tablero([]).
imprimir_tablero([Fila|Resto]) :-
    write(Fila), nl,
    imprimir_tablero(Resto).

% Para resolver y mostrar el Sudoku.
resolver_y_mostrar_sudoku :-
    inicializar_tablero(Tablero),
    aplicar_restricciones(Tablero),
    maplist(labeling([ffc]), Tablero),
    imprimir_tablero(Tablero).
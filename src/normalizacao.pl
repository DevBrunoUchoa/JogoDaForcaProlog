% normalizar_char(+Original, -Normalizado)
normalizar_char('A', 'A'). normalizar_char('B', 'B').
normalizar_char('C', 'C'). normalizar_char('D', 'D').
normalizar_char('E', 'E'). normalizar_char('F', 'F').
normalizar_char('G', 'G'). normalizar_char('H', 'H').
normalizar_char('I', 'I'). normalizar_char('J', 'J').
normalizar_char('K', 'K'). normalizar_char('L', 'L').
normalizar_char('M', 'M'). normalizar_char('N', 'N').
normalizar_char('O', 'O'). normalizar_char('P', 'P').
normalizar_char('Q', 'Q'). normalizar_char('R', 'R').
normalizar_char('S', 'S'). normalizar_char('T', 'T').
normalizar_char('U', 'U'). normalizar_char('V', 'V').
normalizar_char('W', 'W'). normalizar_char('X', 'X').
normalizar_char('Y', 'Y'). normalizar_char('Z', 'Z').

normalizar_char('Á', 'A'). normalizar_char('À', 'A').
normalizar_char('Ã', 'A'). normalizar_char('Â', 'A').
normalizar_char('Ä', 'A').
normalizar_char('É', 'E'). normalizar_char('Ê', 'E').
normalizar_char('È', 'E'). normalizar_char('Ë', 'E').
normalizar_char('Í', 'I'). normalizar_char('Î', 'I').
normalizar_char('Ì', 'I'). normalizar_char('Ï', 'I').
normalizar_char('Ó', 'O'). normalizar_char('Ô', 'O').
normalizar_char('Ò', 'O'). normalizar_char('Õ', 'O').
normalizar_char('Ö', 'O').
normalizar_char('Ú', 'U'). normalizar_char('Û', 'U').
normalizar_char('Ù', 'U'). normalizar_char('Ü', 'U').
normalizar_char('Ç', 'C').

normalizar_char(X, X).

% normalizar_lista(+Lista, -ListaNormalizada)
normalizar_lista([], []).
normalizar_lista([H|T], [NH|NT]) :-
    normalizar_char(H, NH),
    normalizar_lista(T, NT).

% normalizar_palavra(+Palavra, -PalavraNormalizada)
normalizar_palavra(Palavra, Normalizada) :-
    atom_chars(Palavra, Chars),
    normalizar_lista(Chars, CharsNorm),
    atom_chars(Normalizada, CharsNorm).
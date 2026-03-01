
% carregar_banco(+Arquivo, -Pares)
% Le o CSV e retorna lista de pares (Palavra, Dificuldade)
carregar_banco(Arquivo, Pares) :-
    open(Arquivo, read, Stream),
    ler_linhas(Stream, Linhas),
    close(Stream),
    maplist(quebrar_virgula, Linhas, Pares).

% ler_linhas(+Stream, -Linhas)
ler_linhas(Stream, Linhas) :-
    ler_linhas_aux(Stream, Linhas).

ler_linhas_aux(Stream, []) :-
    at_end_of_stream(Stream), !.
ler_linhas_aux(Stream, Resultado) :-
    read_line_to_string(Stream, Linha),
    ( Linha = end_of_file ->
        Resultado = []
    ; Linha = "" ->
        % ignora linhas vazias, continua lendo
        ler_linhas_aux(Stream, Resultado)
    ;
        Resultado = [Linha|Resto],
        ler_linhas_aux(Stream, Resto)
    ).

% quebrar_virgula(+Linha, -(Palavra, Dificuldade))
% Separa uma linha "PALAVRA,DIFICULDADE" no par correspondente
quebrar_virgula(Linha, (Palavra, Dificuldade)) :-
    split_string(Linha, ",", " \t\r\n", [PalavraStr | RestoParts]),
    atomic_list_concat(RestoParts, ',', DifAtom0),
    string_upper(PalavraStr, PalavraUpper),
    atom_string(DifAtom0, DifStr),
    string_upper(DifStr, DifUpper),
    string_trim(PalavraUpper, Palavra),
    string_trim(DifUpper, Dificuldade).

% string_trim(+Str, -Trimmed)
% Remove espaços das bordas
string_trim(Str, Trimmed) :-
    split_string(Str, "", " \t\r\n", [Trimmed]).

% filtrar_por_dificuldade(+Dificuldade, +Pares, -Palavras)
% Retorna apenas as palavras da dificuldade escolhida
filtrar_por_dificuldade(_, [], []).
filtrar_por_dificuldade(Dif, [(Palavra, D)|Resto], [Palavra|Filtradas]) :-
    string_upper(D,   DUp),
    string_upper(Dif, DifUp),
    DUp = DifUp, !,
    filtrar_por_dificuldade(Dif, Resto, Filtradas).
filtrar_por_dificuldade(Dif, [_|Resto], Filtradas) :-
    filtrar_por_dificuldade(Dif, Resto, Filtradas).

% escolher_palavra(+Lista, -Palavra)
% Escolhe uma palavra aleatoria da lista
escolher_palavra(Lista, Palavra) :-
    length(Lista, Tamanho),
    Tamanho > 0,
    UltimoIdx is Tamanho - 1,
    random_between(0, UltimoIdx, Idx),
    nth0(Idx, Lista, Palavra).
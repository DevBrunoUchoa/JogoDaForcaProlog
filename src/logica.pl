:- use_module(library(lists)).
:- ensure_loaded(normalizacao).

%  ESTADO DO JOGO
%  estado(+Palavra, +LetrasUsadas, +Erros, +MaxErros)

% estado_inicial(+Palavra, +MaxErros, -Estado)
estado_inicial(Palavra, MaxErros, estado(Palavra, [], 0, MaxErros)).

estado_palavra(estado(P, _, _, _),   P).
estado_letras(estado(_, L, _, _),    L).
estado_erros(estado(_, _, E, _),     E).
estado_max_erros(estado(_, _, _, M), M).

% jogo_perdido(+Estado)
% O jogo foi perdido se erros >= maxErros
jogo_perdido(Estado) :-
    estado_erros(Estado, Erros),
    estado_max_erros(Estado, Max),
    Erros >= Max.

% jogo_vencido(+Estado)
% O jogo foi vencido se todas as letras da palavra foram descobertas
jogo_vencido(Estado) :-
    estado_palavra(Estado, Palavra),
    estado_letras(Estado, LetrasUsadas),
    atom_chars(Palavra, CharsP),
    normalizar_lista(CharsP, CharsNorm),
    normalizar_lista(LetrasUsadas, LetrasNorm),
    todas_descobertas(CharsNorm, LetrasNorm).

% todas_descobertas(+CharsNorm, +LetrasNorm)
% Verifica se todos os chars da palavra estao na lista de letras usadas
todas_descobertas([], _).
todas_descobertas([H|T], LetrasNorm) :-
    member(H, LetrasNorm),
    todas_descobertas(T, LetrasNorm).

% status_jogo(+Estado, -Status)
% Status pode ser: perdeu, venceu, em_andamento
status_jogo(Estado, perdeu) :-
    jogo_perdido(Estado), !.
status_jogo(Estado, venceu) :-
    jogo_vencido(Estado), !.
status_jogo(_, em_andamento).


% processar_jogada(+Letra, +EstadoAtual, -NovoEstado)
% Gera um novo estado com base na letra digitada
processar_jogada(Letra, Estado, NovoEstado) :-
    estado_palavra(Estado, Palavra),
    estado_letras(Estado, LetrasUsadas),
    estado_erros(Estado, Erros),
    estado_max_erros(Estado, Max),

    normalizar_char(Letra, LetraNorm),
    normalizar_lista(LetrasUsadas, LetrasNorm),
    atom_chars(Palavra, CharsP),
    normalizar_lista(CharsP, PalavraNorm),

    % Se a letra ja foi usada, estado nao muda
    ( member(LetraNorm, LetrasNorm) ->
        NovoEstado = Estado

    % Se a letra esta na palavra, adiciona sem incrementar erros
    ; member(LetraNorm, PalavraNorm) ->
        NovoEstado = estado(Palavra, [Letra|LetrasUsadas], Erros, Max)

    % Se a letra nao esta na palavra, adiciona e incrementa erros
    ;   NovosErros is Erros + 1,
        NovoEstado = estado(Palavra, [Letra|LetrasUsadas], NovosErros, Max)
    ).

% mostrar_painel(+Palavra, +LetrasUsadas)
% Exibe a palavra com _ para letras nao descobertas
mostrar_painel(Palavra, LetrasUsadas) :-
    atom_chars(Palavra, Chars),
    normalizar_lista(LetrasUsadas, LetrasNorm),
    write("Palavra: "),
    exibir_chars(Chars, LetrasNorm),
    nl.

% exibir_chars(+Chars, +LetrasNorm)
exibir_chars([], _).
exibir_chars([H|T], LetrasNorm) :-
    normalizar_char(H, HNorm),
    ( member(HNorm, LetrasNorm) ->
        write(H)
    ;
        write('_')
    ),
    write(' '),
    exibir_chars(T, LetrasNorm).

% avaliar_entrada(+EntradaStr, -Resultado)
% Resultado: jogada_valida(Char) | entrada_invalida(Msg) | ignorar
avaliar_entrada(Entrada, Resultado) :-
    string_chars(Entrada, Chars),
    ( Chars = [] ->
        Resultado = ignorar

    ; length(Chars, Len), Len > 1, maplist(char_type_letra, Chars) ->
        Resultado = entrada_invalida(">> Digite apenas UMA letra!")

    ; \+ maplist(char_type_letra, Chars) ->
        Resultado = entrada_invalida(">> Digite apenas letras!")

    ;   Chars = [C|_],
        upcase_atom(C, CUpper),
        normalizar_char(CUpper, CNorm),
        Resultado = jogada_valida(CNorm)
    ).

% char_type_letra(+Char)
char_type_letra(C) :-
    char_type(C, alpha), !.
char_type_letra(C) :-
    % Cobre letras acentuadas que char_type pode nao reconhecer
    atom_codes(C, [Code]),
    Code > 127.

% validar_palavra_secreta(+Entrada, -Resultado)
% Resultado: valida(Palavra) | invalida(Mensagem)
validar_palavra_secreta(Entrada, Resultado) :-
    ( Entrada = "" ->
        Resultado = invalida("A palavra nao pode ser vazia.")

    ; string_length(Entrada, Len), Len < 3 ->
        Resultado = invalida("A palavra deve ter no minimo 3 letras.")

    ; string_contains_space(Entrada) ->
        Resultado = invalida("A palavra nao pode conter espacos.")

    ; string_chars(Entrada, Chars), \+ maplist(char_type_letra, Chars) ->
        Resultado = invalida("Apenas letras sao permitidas.")

    ;   string_upper(Entrada, PalavraUpper),
        Resultado = valida(PalavraUpper)
    ).

% string_contains_space(+Str)
string_contains_space(Str) :-
    string_chars(Str, Chars),
    member(' ', Chars).
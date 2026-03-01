:- ensure_loaded(normalizacao).
:- ensure_loaded(arquivo).
:- ensure_loaded(desenho).
:- ensure_loaded(logica).

:- initialization(iniciar, main).


iniciar :-
    menu_principal.


menu_principal :-
    nl,
    writeln("=== JOGO DA FORCA ==="),
    writeln("1. Jogar (Solo)"),
    writeln("2. Instrucoes"),
    writeln("3. Modo Multijogador"),
    writeln("4. Sair"),
    write("Escolha: "),
    read_line_to_string(user_input, Opcao),
    tratar_menu_principal(Opcao).

tratar_menu_principal("1") :- !, menu_dificuldade.
tratar_menu_principal("2") :- !, exibir_instrucoes, menu_principal.
tratar_menu_principal("3") :- !, menu_multijogador.
tratar_menu_principal("4") :- !, writeln("Saindo... Ate logo!").
tratar_menu_principal(_)   :-
    writeln("Opcao invalida! Tente novamente."),
    menu_principal.

%  INSTRUÇÕES

exibir_instrucoes :-
    nl,
    writeln("========================================"),
    writeln("         REGRAS E INSTRUCOES"),
    writeln("========================================"),
    writeln("1. O objetivo e adivinhar a palavra secreta."),
    writeln("2. A cada rodada, digite uma letra."),
    writeln("3. Se a letra estiver na palavra, ela sera revelada."),
    writeln("4. Se errar, uma parte do boneco sera desenhada."),
    writeln("5. No modo FACIL,  voce pode errar ate 7 vezes."),
    writeln("6. No modo DIFICIL, voce pode errar ate 5 vezes."),
    writeln("========================================"),
    nl,
    writeln("Pressione Enter para voltar ao menu..."),
    read_line_to_string(user_input, _).

%  MENU DE DIFICULDADE (modo solo)

menu_dificuldade :-
    nl,
    writeln("--- DIFICULDADE ---"),
    writeln("1. Facil  (7 erros)"),
    writeln("2. Dificil (5 erros)"),
    write("Escolha: "),
    read_line_to_string(user_input, Op),
    tratar_menu_dificuldade(Op).

tratar_menu_dificuldade("1") :- !,
    carregar_banco("../data/palavras.csv", Banco),
    filtrar_por_dificuldade("FACIL", Banco, Palavras),
    iniciar_jogo(Palavras, 7).

tratar_menu_dificuldade("2") :- !,
    carregar_banco("../data/palavras.csv", Banco),
    filtrar_por_dificuldade("DIFICIL", Banco, Palavras),
    iniciar_jogo(Palavras, 5).

tratar_menu_dificuldade(_) :-
    writeln("Opcao invalida!"),
    menu_dificuldade.

iniciar_jogo([], _) :-
    writeln("ERRO: Nenhuma palavra encontrada no banco!"),
    menu_principal.

iniciar_jogo(Palavras, MaxErros) :-
    escolher_palavra(Palavras, Palavra),
    estado_inicial(Palavra, MaxErros, EstadoInicial),
    loop_jogo(EstadoInicial, nenhum).

%  LOOP PRINCIPAL DO JOGO

% loop_jogo(+Estado, +MsgErro)
% MsgErro pode ser 'nenhum' ou uma string com mensagem de erro
loop_jogo(Estado, MsgErro) :-
    imprimir_divisor,
    exibir_estado(Estado, MsgErro),
    status_jogo(Estado, Status),
    tratar_status(Status, Estado).

% tratar_status(+Status, +Estado)
tratar_status(perdeu, Estado) :-
    estado_palavra(Estado, Palavra),
    format("~nPERDEU! A palavra era: ~w~n", [Palavra]),
    perguntar_jogar_novamente.

tratar_status(venceu, _) :-
    writeln("\nPARABENS! Voce venceu!"),
    perguntar_jogar_novamente.

tratar_status(em_andamento, Estado) :-
    processar_turno(Estado).

% processar_turno(+Estado)
processar_turno(Estado) :-
    write("\nDigite uma letra: "),
    read_line_to_string(user_input, Entrada),
    avaliar_entrada(Entrada, Resultado),
    tratar_resultado_entrada(Resultado, Estado).

% tratar_resultado_entrada(+Resultado, +Estado)
tratar_resultado_entrada(entrada_invalida(Msg), Estado) :-
    loop_jogo(Estado, Msg).

tratar_resultado_entrada(ignorar, Estado) :-
    loop_jogo(Estado, nenhum).

tratar_resultado_entrada(jogada_valida(Letra), Estado) :-
    processar_jogada(Letra, Estado, NovoEstado),
    loop_jogo(NovoEstado, nenhum).

%  EXIBIR ESTADO DO JOGO

exibir_estado(Estado, MsgErro) :-
    estado_erros(Estado, Erros),
    estado_max_erros(Estado, Max),
    estado_palavra(Estado, Palavra),
    estado_letras(Estado, Letras),

    desenhar_forca(Erros, Max),
    nl,
    mostrar_painel(Palavra, Letras),
    format("Letras usadas: ~w~n", [Letras]),
    format("Erros: ~w/~w~n", [Erros, Max]),

    % Exibe mensagem de erro apenas se houver uma
    ( MsgErro \= nenhum ->
        writeln(MsgErro)
    ;   true
    ).

imprimir_divisor :-
    nl, nl, nl, nl, nl,
    writeln("-----------------------------------------------------------").

perguntar_jogar_novamente :-
    nl,
    writeln("Deseja jogar novamente?"),
    writeln("1. Sim"),
    writeln("2. Voltar ao menu principal"),
    write("Escolha: "),
    read_line_to_string(user_input, Op),
    ( Op = "1" -> menu_dificuldade
    ; Op = "2" -> menu_principal
    ; writeln("Opcao invalida!"), perguntar_jogar_novamente
    ).

menu_multijogador :-
    nl,
    writeln("=== MODO MULTIJOGADOR ==="),
    writeln("Regras: minimo 3 letras, sem espacos, apenas letras."),
    nl,
    writeln("JOGADOR 1: Digite a palavra secreta:"),
    read_line_to_string(user_input, Entrada),
    validar_palavra_secreta(Entrada, Resultado),
    tratar_validacao_palavra(Resultado).

tratar_validacao_palavra(invalida(Msg)) :-
    format("~n>>> ERRO: ~w Tente novamente. <<<~n", [Msg]),
    menu_multijogador.

tratar_validacao_palavra(valida(Palavra)) :-
    % Limpa a tela para o jogador 2 nao ver a palavra
    forall(between(1, 50, _), nl),
    writeln("JOGADOR 1: Escolha a dificuldade para o JOGADOR 2:"),
    writeln("1. Facil  (7 erros)"),
    writeln("2. Dificil (5 erros)"),
    write("Escolha: "),
    read_line_to_string(user_input, Op),
    tratar_dificuldade_multi(Op, Palavra).

tratar_dificuldade_multi("1", Palavra) :- !,
    writeln("\n--- JOGO INICIADO ---"),
    writeln("JOGADOR 2: Tente adivinhar a palavra!"),
    estado_inicial(Palavra, 7, Estado),
    loop_jogo(Estado, nenhum).

tratar_dificuldade_multi("2", Palavra) :- !,
    writeln("\n--- JOGO INICIADO ---"),
    writeln("JOGADOR 2: Tente adivinhar a palavra!"),
    estado_inicial(Palavra, 5, Estado),
    loop_jogo(Estado, nenhum).

tratar_dificuldade_multi(_, Palavra) :-
    writeln("Opcao invalida!"),
    tratar_validacao_palavra(valida(Palavra)).
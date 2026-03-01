% ============================================================
%  desenho.pl
%  Responsavel pelos desenhos ASCII da forca
%  O estado do boneco depende dos erros e do max de erros
% ============================================================

% desenhar_forca(+Erros, +MaxErros)
% Decide qual fase do desenho exibir de acordo com os erros
% Facil (7 erros): 8 fases -> indices [0,1,2,3,4,5,5,6]
% Dificil (5 erros): 6 fases -> indices [0,1,2,4,5,6]
desenhar_forca(Erros, MaxErros) :-
    (MaxErros =:= 5
    ->  IndicesDesenho = [0,1,2,4,5,6]
    ;   IndicesDesenho = [0,1,2,3,4,5,5,6]
    ),
    length(IndicesDesenho, Tam),
    UltimoIdx is Tam - 1,
    Idx is min(Erros, UltimoIdx),
    nth0(Idx, IndicesDesenho, Fase),
    exibir_fase(Fase).

% exibir_fase(+Fase)
% Cada fase corresponde a um estado do boneco na forca
exibir_fase(0) :-
    writeln("  +---+"),
    writeln("      |"),
    writeln("      |"),
    writeln("=========").

exibir_fase(1) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln("      |"),
    writeln("=========").

exibir_fase(2) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln("  |   |"),
    writeln("=========").

exibir_fase(3) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln(" /|   |"),
    writeln("=========").

exibir_fase(4) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln(" /|\\  |"),
    writeln("=========").

exibir_fase(5) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln(" /|\\  |"),
    writeln(" /    |"),
    writeln("=========").

exibir_fase(6) :-
    writeln("  +---+"),
    writeln("  O   |"),
    writeln(" /|\\  |"),
    writeln(" / \\  |"),
    writeln("=========").
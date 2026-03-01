# JogoDaForcaProlog

Segunda Parte do Projeto para a Disciplina de **Paradigmas das Linguagens de Programação — UFCG (2025.2)**.  
Jogo da Forca implementado utilizando o **paradigma Lógico** na linguagem **Prolog**.

---

## 👥 Equipe

| Nome |
| :--- |
| Ana Larissa Costa dos Santos |
| João Bruno Tavares Uchoa |
| Nathan Amaro Trajano |
| Raissa Tainá Pordeus Ferreira |
| Teones Alex Lira de Farias Filho |

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [SWI-Prolog](https://www.swi-prolog.org/Download.html) instalado (versão 8.x ou superior recomendada).
- O arquivo `palavras.csv` deve estar na **mesma pasta** que os arquivos `.pl`.

### Passo a Passo

1. **Clone ou baixe** este repositório:
   ```bash
   git clone https://github.com/seu-usuario/JogoDaForcaProlog.git
   cd JogoDaForcaProlog/src
   ```

2. **Execute** o projeto pelo terminal:
   ```bash
   swipl main.pl
   ```

3. Ou, dentro do console interativo do SWI-Prolog:
   ```prolog
   ?- iniciar.
   ```

---

## 📋 Descrição Geral do Sistema

O Jogo da Forca é um sistema interativo executado no terminal que permite ao usuário tentar adivinhar uma palavra secreta letra por letra. O jogo controla as tentativas, as letras já usadas e o estado atual da palavra revelada. O objetivo é adivinhar a palavra antes que o número de erros atinja o limite definido pela dificuldade escolhida.

O sistema possui dois modos de jogo:
- **Solo** — a palavra é sorteada aleatoriamente do banco de palavras (`palavras.csv`).
- **Multijogador** — o Jogador 1 digita a palavra secreta e o Jogador 2 tenta adivinhar.

---

## ✅ Lista de Funcionalidades

| ID | Funcionalidade | Descrição |
| :--- | :--- | :--- |
| 1 | Validação de Entrada | Aceita apenas letras; rejeita números, símbolos e entradas vazias. Converte automaticamente para maiúscula. |
| 2 | Normalização de Acentos | Letras acentuadas (ex: `Á`, `Ç`, `Ê`) são normalizadas, permitindo acertar a letra independente do acento digitado. |
| 3 | Escolha Aleatória | A palavra secreta é escolhida aleatoriamente do arquivo `palavras.csv` conforme a dificuldade selecionada. |
| 4 | Contagem de Tentativas | Define o limite de erros por dificuldade. Cada letra errada incrementa o contador de erros. |
| 5 | Exibição da Palavra | Mostra as letras já descobertas e usa `_` nas posições ainda ocultas. |
| 6 | Letras Usadas | Exibe todas as letras já tentadas para evitar repetições. |
| 7 | Vitória | O jogo verifica automaticamente se todas as letras da palavra foram descobertas. |
| 8 | Derrota | O jogo encerra quando o número máximo de erros é atingido. |
| 9 | Menu Principal | Permite navegar entre: Jogar (Solo), Instruções, Modo Multijogador e Sair. |
| 10 | Seleção de Dificuldade | **Fácil**: palavras simples, até 7 erros. **Difícil**: palavras complexas, até 5 erros. |
| 11 | Desenho da Forca | A cada erro, o boneco é desenhado progressivamente em ASCII no console. |
| 12 | Modo Multijogador | O Jogador 1 define a palavra secreta (com validação) e escolhe a dificuldade para o Jogador 2. |
| 13 | Instruções | Exibe as regras do jogo ao usuário antes de iniciar. |

---

## 🗂️ Estrutura de Arquivos

```
JogoDaForcaProlog/
│
├── src/
│   ├── main.pl           # Ponto de entrada: menus, loop do jogo e interface com o usuário
│   ├── logica.pl         # Lógica central: estado do jogo, processar jogada, verificar vitória/derrota
│   ├── arquivo.pl        # Leitura do CSV, filtragem por dificuldade e escolha aleatória de palavra
│   ├── desenho.pl        # Desenhos ASCII progressivos da forca
│   ├── normalizacao.pl   # Remoção de acentos e padronização de caracteres
│   └── palavras.csv      # Banco de palavras no formato: PALAVRA,DIFICULDADE
│
└── README.md
```


## 📄 Formato do `palavras.csv`

O arquivo deve conter uma palavra por linha, separada por vírgula da sua dificuldade:

```
ABACAXI,FACIL
BORBOLETA,FACIL
ALGORITMO,DIFICIL
CRIPTOGRAFIA,DIFICIL
```

Valores aceitos para dificuldade: `FACIL` ou `DIFICIL` (sem acento, maiúsculo).
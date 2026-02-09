# JogoDaForcaProlog
Segunda Parte do Projeto para a Disciplina de Paradigmas Das Linguagens de Programação - UFCG - (2025.2). Jogo da Forca utilizando o paradigma Lógico na Linguagem Prolog.

## Equipe
* Ana Larissa Costa dos Santos
* João Bruno Tavares Uchoa
* Nathan Amaro Trajano
* Raissa Tainá Pordeus Ferreira
* Teones Alex Lira de Farias Filho

## 🚀 Como Rodar o Projeto

### Pré-requisitos

### Passo a Passo
1.  **Clone ou baixe** este repositório.


---

## Descrição geral do sistema
Jogo da Forca é um sistema interativo no terminal que permite ao usuário tentar adivinhar uma palavra secreta letra por letra. O jogo controla tentativas, letras já usadas e o estado atual da palavra. O objetivo é adivinhar a palavra antes que o número de erros atinja o limite.

## Lista de Funcionalidades

| ID | Funcionalidade | Descrição |
| :--- | :--- | :--- |
| 1 | Validação de Entrada | Aceita apenas letras; ignora números e símbolos. Converte para maiúscula. |
| 2 | Escolha aleatória | A palavra secreta é escolhida aleatoriamente do arquivo `palavras.csv`. |
| 3 | Contagem de Tentativas | Define limite de erros. Cada letra errada decrementa as chances. |
| 4 | Exibição da Palavra | Mostra os acertos e usa “_” nas posições não descobertas. |
| 5 | Letras Usadas | Exibe letras já tentadas para evitar repetição. |
| 6 | Vitória | Verifica se todas as letras foram descobertas. |
| 7 | Derrota | O jogo termina quando o número máximo de erros é atingido. |
| 8 | Menu Inicial | Permite: jogar ou sair. |
| 9 | Dificuldade | **Fácil**: Palavras simples (7 erros). **Difícil**: Palavras complexas (5 erros). |
| 10 | Desenho da Forca | A cada erro, o boneco é desenhado progressivamente no console. |

---

## Estrutura de Arquivos
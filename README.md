# music-recommendation-neo4j

Projeto de exemplo para modelagem de usuários, músicas, artistas e gêneros em um banco de grafos Neo4j.

## Sobre
Este repositório contém um conjunto de dados fictícios com nós e relacionamentos para um projeto em Neo4j. O foco é representar usuários, músicas, artistas e gêneros, além de suas relações.

## Estrutura do repositório
- `imagens/`: imagens do grafo para visualizar a estrutura do projeto.
- `cypher/`: arquivo `seed.cypher` com os comandos Cypher para criar nós e relacionamentos.

## Conteúdo do script Cypher
O arquivo `cypher/seed.cypher` inclui:
- Criação de nós para `User`, `Music`, `Genre` e `Artist`
- Relacionamentos `BELOGS_TO` entre os nós `Music` com o nó `Genre`.
- Relacionamentos `PERFORMED_BY` entre o nó `Music` com o nó `Artist`.
- Relacionamentos `FOLLOWS` entre o nó `User` com o nó `Artist`.
- Relacionamentos `LISTENED` entre o nó `User` com o nó `Music`.
- Relacionamentos `LIKED` entre o nó `User` com o nó `Music`.

## Propriedades
**Nós:**
- User
    - name: nome do usuário
    - age: idade do usuário
- Music
    - title: titulo da música
- Artist
    - name: nome do artista
- Genre
    - name: descrição do gênero

**Relações:**
- Listened
    - times: vezes escutadas
- Liked
    - Não possui atributos
- Follows
    - Não possui atributos
- Belongs_to
    - Não possui atributos


## Observações
- Modelo presente na pasta `images/`, ajuda na compreensão da modelagem
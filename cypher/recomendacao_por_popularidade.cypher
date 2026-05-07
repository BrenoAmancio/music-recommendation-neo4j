
MATCH (u:User {name: "Julia"})-[:LIKED]->(:Music)-[:BELONGS_TO]->(g:Genre)

WITH u, g, count(*) AS preferencias
ORDER BY preferencias DESC
LIMIT 1

MATCH (:User)-[:LISTENED]->(m:Music)-[:BELONGS_TO]->(g)

WHERE NOT (u)-[:LISTENED]->(m)

RETURN m.title,
       sum(1) AS popularidade
ORDER BY popularidade DESC;
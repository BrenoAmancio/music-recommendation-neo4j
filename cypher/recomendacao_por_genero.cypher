MATCH (u:User {name: "Ana"})-[:LIKED]->(:Music)-[:BELONGS_TO]->(g:Genre)
MATCH (recommended:Music)-[:BELONGS_TO]->(g)

WHERE NOT (u)-[:LIKED]->(recommended)

RETURN DISTINCT recommended.title AS recomendacao,
       g.name AS genero;
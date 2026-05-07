MATCH (u:User {name: "Paulo"})-[:LIKED]->(m:Music)<-[:LIKED]-(other:User)
MATCH (other)-[:LIKED]->(recommended:Music)

WHERE NOT (u)-[:LIKED]->(recommended)
  AND recommended <> m

RETURN recommended.title AS recomendacao,
       count(*) AS relevancia
ORDER BY relevancia DESC;
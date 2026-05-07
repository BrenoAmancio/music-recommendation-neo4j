MATCH (u1:User)-[:LIKED]->(m:Music)<-[:LIKED]-(u2:User)

WHERE u1 <> u2

RETURN u1.name,
       collect(DISTINCT u2.name) AS comunidade;
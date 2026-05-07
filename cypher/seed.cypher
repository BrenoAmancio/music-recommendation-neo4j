// =========================
// USUÁRIOS
// =========================
UNWIND [
  {name: "Paulo", age: 22},
  {name: "Ana", age: 25},
  {name: "Carlos", age: 30},
  {name: "Marina", age: 27},
  {name: "Julia", age: 21},
  {name: "Rafael", age: 29}
] AS userData

MERGE (u:User {name: userData.name})
SET u.age = userData.age;


// =========================
// ARTISTAS
// =========================
UNWIND [
  {name: "The Weeknd"},
  {name: "Dua Lipa"},
  {name: "Taylor Swift"},
  {name: "Imagine Dragons"},
  {name: "Bruno Mars"},
  {name: "Billie Eilish"}
] AS artistData

MERGE (a:Artist {name: artistData.name});


// =========================
// GÊNEROS
// =========================
UNWIND [
  {name: "Pop"},
  {name: "Synthwave"},
  {name: "Rock"},
  {name: "Indie"},
  {name: "Alternative"},
  {name: "Electronic"}
] AS genreData

MERGE (g:Genre {name: genreData.name});


// =========================
// MÚSICAS
// =========================
UNWIND [
  {
    title: "Blinding Lights",
    artist: "The Weeknd",
    genres: ["Synthwave", "Pop"]
  },
  {
    title: "Levitating",
    artist: "Dua Lipa",
    genres: ["Pop", "Electronic"]
  },
  {
    title: "Bad Habits",
    artist: "Ed Sheeran",
    genres: ["Pop"]
  },
  {
    title: "Believer",
    artist: "Imagine Dragons",
    genres: ["Rock", "Alternative"]
  },
  {
    title: "As It Was",
    artist: "Harry Styles",
    genres: ["Pop", "Indie"]
  },
  {
    title: "Anti-Hero",
    artist: "Taylor Swift",
    genres: ["Pop"]
  },
  {
    title: "Bad Guy",
    artist: "Billie Eilish",
    genres: ["Electronic", "Alternative"]
  },
  {
    title: "Locked Out of Heaven",
    artist: "Bruno Mars",
    genres: ["Pop", "Rock"]
  }
] AS musicData

MERGE (m:Music {title: musicData.title})

WITH m, musicData
MERGE (a:Artist {name: musicData.artist})
MERGE (m)-[:PERFORMED_BY]->(a)

WITH m, musicData
UNWIND musicData.genres AS genreName
MATCH (g:Genre {name: genreName})
MERGE (m)-[:BELONGS_TO]->(g);


// =========================
// RELACIONAMENTOS
// =========================
UNWIND [

  {
    user: "Paulo",
    music: "Blinding Lights",
    listened: 15,
    liked: true,
    follows: "The Weeknd"
  },

  {
    user: "Ana",
    music: "Levitating",
    listened: 20,
    liked: true,
    follows: "Dua Lipa"
  },

  {
    user: "Carlos",
    music: "Believer",
    listened: 32,
    liked: true,
    follows: "Imagine Dragons"
  },

  {
    user: "Marina",
    music: "Anti-Hero",
    listened: 18,
    liked: true,
    follows: "Taylor Swift"
  },

  {
    user: "Julia",
    music: "Bad Guy",
    listened: 25,
    liked: true,
    follows: "Billie Eilish"
  },

  {
    user: "Rafael",
    music: "Locked Out of Heaven",
    listened: 14,
    liked: false,
    follows: "Bruno Mars"
  },

  {
    user: "Ana",
    music: "Blinding Lights",
    listened: 10,
    liked: false,
    follows: null
  },

  {
    user: "Carlos",
    music: "Levitating",
    listened: 8,
    liked: true,
    follows: null
  },

  {
    user: "Julia",
    music: "As It Was",
    listened: 12,
    liked: true,
    follows: null
  },

  {
    user: "Paulo",
    music: "Believer",
    listened: 5,
    liked: false,
    follows: null
  }

] AS relData

MATCH (u:User {name: relData.user})
MATCH (m:Music {title: relData.music})

MERGE (u)-[l:LISTENED]->(m)
SET l.times = relData.listened

FOREACH (_ IN CASE WHEN relData.liked THEN [1] ELSE [] END |
  MERGE (u)-[:LIKED]->(m)
)

FOREACH (_ IN CASE WHEN relData.follows IS NOT NULL THEN [1] ELSE [] END |
  MATCH (a:Artist {name: relData.follows})
  MERGE (u)-[:FOLLOWS]->(a)
);
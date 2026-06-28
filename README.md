# Análise de Streams do Spotify com SQL

Projeto de análise exploratória utilizando SQL no DB Browser for SQLite, com um dataset público do Kaggle contendo músicas do Spotify com foco em 2022 e 2023.

O objetivo foi praticar SQL formulando perguntas reais sobre os dados e interpretando os resultados com contexto.

---

## Dataset

- **Fonte:** Kaggle
- **Período predominante:** 2022–2023, com algumas músicas de anos anteriores
- **Colunas principais utilizadas:** `track_name`, `artist_name`, `streams`, `released_year`
- **Observação:** O dataset é limitado e focado no período recente. Anos mais antigos têm poucas entradas, geralmente clássicos que acumularam streams ao longo do tempo na plataforma.

---

## Perguntas e Análises

---

### 1. Quais são as 100 músicas mais ouvidas no dataset?

```sql
SELECT track_name, artist_name, streams
FROM spotify
ORDER BY streams DESC
LIMIT 100;
```

**Conclusão:** Lista direta das músicas com maior número de streams. Ponto de entrada para entender quais artistas e faixas dominam a plataforma.

---

### 2. Quais são as músicas mais ouvidas da Olivia Rodrigo?

```sql
SELECT track_name, artist_name, streams
FROM spotify
WHERE artist_name = 'Olivia Rodrigo'
ORDER BY streams DESC
LIMIT 10;
```

**Conclusão:** O filtro com `WHERE` permite isolar um artista específico e ranquear suas músicas por popularidade. O mesmo modelo serve para qualquer artista do dataset.

---

### 3. Qual artista aparece mais vezes no dataset?

```sql
SELECT artist_name, COUNT(artist_name) as count_appearence
FROM spotify
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;
```

**Conclusão:** Quantidade de músicas por artista no dataset. Artistas com mais entradas não necessariamente são os mais ouvidos — apenas lançaram mais músicas que foram indexadas.

---

### 4. Qual artista tem mais streams totais e quantas músicas tem no dataset?

```sql
SELECT artist_name, SUM(streams) as all_streams, COUNT(artist_name) as count_appearence
FROM spotify
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;
```

**Conclusão:** Combinando `SUM` e `COUNT` no mesmo agrupamento é possível comparar volume de streams com quantidade de músicas. Um artista com poucos lançamentos e streams altos indica hits concentrados; muitos lançamentos com streams distribuídos indica presença consistente.

---

### 5. Qual ano teve mais streams no total?

```sql
SELECT SUM(streams) as all_streams, released_year
FROM spotify
GROUP BY released_year
ORDER BY all_streams DESC
LIMIT 10;
```

**Conclusão:** 2021 e 2022 dominam o ranking de streams totais. Isso reflete o crescimento acelerado do Spotify no período pós-pandemia, quando muitos usuários migraram para streaming. 2023 não aparece no top 10 porque os dados foram coletados antes do fim do ano, deixando os streams incompletos.

---

### 6. Qual a média de streams por ano?

```sql
SELECT AVG(streams) as avg_streams, released_year
FROM spotify
GROUP BY released_year
ORDER BY released_year DESC;
```

**Conclusão:** Anos antigos como 1975 e 1983 aparecem com médias altíssimas, acima de anos recentes. Isso é enganoso — não significa que o Spotify era popular nessa época, mas sim que poucas músicas desses anos entraram no dataset e as que entraram são clássicos históricos com streams acumulados ao longo de décadas. A média sobe porque a amostra é pequena e enviesada para hits.

---

### 7. Qual a média de streams por ano e quantas músicas cada ano tem no dataset?

```sql
SELECT AVG(streams) as avg_streams, released_year, COUNT(track_name) as track_quantity
FROM spotify
GROUP BY released_year
ORDER BY released_year DESC;
```

**Conclusão:** Cruzando a média com a quantidade de músicas por ano, o viés fica evidente. Anos como 1975 têm média alta mas apenas 2 músicas no dataset. Já 2022 tem 402 músicas, tornando sua média muito mais representativa da realidade. **Média sozinha pode enganar quando o tamanho da amostra varia muito entre grupos.**

---

## Aprendizados Técnicos

- `SELECT`, `FROM` — selecionar colunas e tabela
- `WHERE` — filtrar linhas por condição
- `ORDER BY` + `DESC` — ordenar resultados
- `LIMIT` — limitar quantidade de resultados
- `GROUP BY` — agrupar linhas por categoria
- `COUNT` — contar ocorrências por grupo
- `SUM` — somar valores por grupo
- `AVG` — calcular média por grupo
- Alias com `AS` — renomear colunas no resultado

## Ferramentas utilizadas

- DB Browser for SQLite
- Dataset público do Kaggle

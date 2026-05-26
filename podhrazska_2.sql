-- Vytvoření sekundární tabulky pro SQL projekt
-- Tabulka obsahuje ekonomická data evropských států od roku 2000.
-- Data vznikla spojením tabulek countries a economies.

-- Smazání tabulky pokud již existuje
DROP TABLE IF EXISTS t_michaela_podhrazska_project_sql_secondary_final;

-- Vytvoření nové tabulky
CREATE TABLE t_michaela_podhrazska_project_sql_secondary_final AS

SELECT
    c.continent,      -- Kontinent
    c.country,        -- Název státu
    e.year,           -- Rok
    e.gdp,            -- HDP
    e.gini,           -- Gini koeficient
    e.population      -- Počet obyvatel

FROM countries c

LEFT JOIN economies e
    ON c.country = e.country
   AND e.year >= 2000

WHERE c.continent = 'Europe'
  AND c.country IS NOT NULL

ORDER BY c.country, e.year;

-- Kontrola výsledné tabulky
SELECT *
FROM t_michaela_podhrazska_project_sql_secondary_final;
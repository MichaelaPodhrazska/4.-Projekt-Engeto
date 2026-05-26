-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
-- První období je rok 2006, poslední je rok 2018
--kroky: Vyberou se data z let 2006 a 2018.
--1.Spočítá se průměrná mzda pro oba roky.
--2.Vyberou se ceny chleba a mléka a vypočítá se jejich průměrná cena.
--3.Propojí se mzdy a ceny podle roku.
--4.Vypočítá se, kolik litrů mléka a kilogramů chleba bylo možné koupit za průměrnou mzdu.
--5.Výsledky se seřadí podle roku a potraviny.

-- Průměrná mzda v letech 2006 a 2018
WITH wages AS (
    SELECT
        year,
        ROUND(AVG(average_salary)::numeric, 2) AS avg_salary
    FROM t_michaela_podhrazska_project_sql_primary_final
    WHERE year IN (2006, 2018)
    GROUP BY year
),

-- Průměrné ceny chleba a mléka
food AS (
    SELECT
        year,
        food_name,
        ROUND(AVG(average_food_price)::numeric, 2) AS avg_price
    FROM t_michaela_podhrazska_project_sql_primary_final
    WHERE food_name IN (
        'Mléko polotučné pasterované',
        'Chléb konzumní kmínový'
    )
    AND year IN (2006, 2018)
    GROUP BY year, food_name
)

SELECT
    w.year,
    f.food_name,
    w.avg_salary,
    f.avg_price,

    -- Kolik kusů/litrů lze koupit za průměrnou mzdu
    ROUND(w.avg_salary / f.avg_price, 2) AS quantity_affordable

FROM wages w
JOIN food f ON w.year = f.year
ORDER BY w.year, f.food_name;

--výsledek: chleb rok 2006 vs 2018 = 1264 vs 1319 kg/kč; mléko 2006 vs 2018 = 1408 vs 1613 litru/kč
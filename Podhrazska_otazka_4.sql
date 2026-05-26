-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-- kroky: Vybrat data o mzdách a cenách potravin z tabulky.
-- 1.Spočítat průměrnou mzdu pro každý rok.
-- 2.Spočítat průměrnou cenu potravin pro každý rok.
-- 3.Získat hodnotu mzdy z předchozího roku pro meziroční porovnání.
-- 4.Získat hodnotu ceny potravin z předchozího roku.
-- 5.Vypočítat meziroční procentuální růst mezd.
-- 6.Vypočítat meziroční procentuální růst cen potravin.
-- 7.Spojit výsledky podle jednotlivých let.
-- 8.Spočítat rozdíl mezi růstem cen potravin a růstem mezd.
-- 9.Ověřit, zda růst cen potravin převýšil růst mezd o více než 10 %.
-- 10.Odstranit první rok, kde není možné provést meziroční porovnání.
-- 11.Seřadit výsledky chronologicky podle roku.

WITH salary_by_year AS (

    -- Průměrná mzda podle roku
    SELECT
        year,
        ROUND(AVG(average_salary)::numeric, 2) AS avg_salary
    FROM t_michaela_podhrazska_project_sql_primary_final
    GROUP BY year
),

salary_growth AS (

    -- Přidání mzdy z předchozího roku
    SELECT
        year,
        avg_salary,
        LAG(avg_salary) OVER (ORDER BY year) AS prev_salary
    FROM salary_by_year
),

salary_growth_percent AS (

    -- Výpočet meziročního růstu mezd v %
    SELECT
        year,
        ROUND(((avg_salary - prev_salary) / prev_salary) * 100, 2) AS salary_growth_pct
    FROM salary_growth
),

food_by_year AS (

    -- Průměrná cena potravin podle roku
    SELECT
        year,
        ROUND(AVG(average_food_price)::numeric, 2) AS avg_price
    FROM t_michaela_podhrazska_project_sql_primary_final
    GROUP BY year
),

food_growth AS (

    -- Přidání ceny z předchozího roku
    SELECT
        year,
        avg_price,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price
    FROM food_by_year
),

food_growth_percent AS (

    -- Výpočet meziročního růstu cen potravin v %
    SELECT
        year,
        ROUND(((avg_price - prev_price) / prev_price) * 100, 2) AS food_growth_pct
    FROM food_growth
)

SELECT
    f.year,
    f.food_growth_pct,
    s.salary_growth_pct,

    -- Rozdíl mezi růstem cen a mezd
    ROUND(f.food_growth_pct - s.salary_growth_pct, 2) AS difference_pct,

    -- Ověření, zda rozdíl překročil 10 %
    CASE
        WHEN (f.food_growth_pct - s.salary_growth_pct) > 10 THEN 'YES'
        ELSE 'NO'
    END AS significant_growth

FROM food_growth_percent f
JOIN salary_growth_percent s
    ON f.year = s.year

-- Odstranění NULL hodnot z prvního roku
WHERE f.food_growth_pct IS NOT NULL
AND s.salary_growth_pct IS NOT NULL

ORDER BY f.year;

-- vysledek: v žádném roce nebyl nárust větší než 10%
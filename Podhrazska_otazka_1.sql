-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
--1.Vyberou se data pouze pro roky 2006 a 2018.
--2.Spočítá se průměrná mzda pro každý z těchto roků.
--3.Vyberou se pouze sledované potraviny – mléko a chléb.
--4.Spočítá se jejich průměrná cena v jednotlivých letech.
--5.Data o mzdách a cenách se propojí podle roku.
--6.Vypočítá se, kolik litrů mléka nebo kilogramů chleba lze koupit za průměrnou mzdu.
--7.Výsledky se nakonec seřadí podle roku a názvu potraviny.

-- Výpočet průměrné mzdy pro každý rok a odvětví
WITH salary_by_year AS (
    SELECT
        year,
        industry_name,
        ROUND(AVG(average_salary)::numeric, 2) AS average_salary
    FROM t_michaela_podhrazska_project_sql_primary_final
    GROUP BY
        year,
        industry_name
),

-- Přidání hodnoty z předchozího roku
salary_with_lag AS (
    SELECT
        year,
        industry_name,
        average_salary,

        LAG(average_salary) OVER (
            PARTITION BY industry_name
            ORDER BY year
        ) AS average_salary_last_year
    FROM salary_by_year
)

SELECT
    year,
    industry_name,
    average_salary,
    average_salary_last_year,

    -- Trend vývoje mzdy
    CASE
        WHEN average_salary > average_salary_last_year THEN 'growth'
        WHEN average_salary_last_year IS NULL THEN '-'
        ELSE 'drop'
    END AS trend

FROM salary_with_lag

-- Seřazení podle odvětví a roku
ORDER BY
    industry_name,
    year;

--odpověď: Průměrná hrubá mzda v Kč ve všech letech tj. 2006 – 2018 ROSTLA pro odvětví: 
--administrativní a podpůrné činnosti, doprava a skladování, ostatní činnosti, zdravotní a sociální péče, zpracovatelský průmysl
--V ostatních odvětvích došlo vždy minimálně k jednomu zakolísání v průběhu daných let.

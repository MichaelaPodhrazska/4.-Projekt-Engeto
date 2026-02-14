---zadání: vytvoření pomocné tabulky t_Michaela_Podhrazska_project_SQL_primary_final = tabulka pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky 
---krok 1: tabulka czechia_payroll = tabulka pro data mezd - potřebuji join všech číselníků
---krok 2: tabulka czechia price = tabulka pro data potravin - potřebuji join na tabulku czechia payroll
---krok 3: potřebuji filtr společných roků 2006 - 2018  

--create table t_Michaela_Podhrazska_project_SqL_primary_final AS
with cte_payroll_rank as (
select 
	cp.payroll_year as year,
	cp.industry_branch_code as branch_code,
	max (cpib."name") as branch_name,
	avg (cp.value) as avg_wage,
	--cp.calculation_code,
	--max (cpc."name") as calculation_name,
	--cp.unit_code,
	max (cpu."name") as currency ---chyba v zadání currecý by nemělo být tis.os.)
	--cp.value_type_code,
	--max (cpvt."name") as avg_wage_employee,
	--cp.value,
	--cpib."name" 
from czechia_payroll cp 
left join czechia_payroll_calculation cpc 
	on cp.calculation_code = cpc.code
left join czechia_payroll_industry_branch cpib 
	on cp.industry_branch_code = cpib.code
left join czechia_payroll_unit cpu 
	on cp.unit_code = cpu.code 
left join czechia_payroll_value_type cpvt  
	on cp.value_type_code = cpvt.code 
where cp.value_type_code = 5958 ---pouze data hrubá mzda na zaměstnance
and cp.payroll_year between 2006 and 2018  -- filtr let 2006-2018
group by payroll_year, branch_code 
), cte_last_year as (
select
	*,
	lag(avg_wage) over (partition by branch_code order by branch_code, year) as avg_wage_last_year
	from cte_payroll_rank
)
select
	*,
	case
		when avg_wage > avg_wage_last_year then 'growt'
		when avg_wage_last_year is null then '-'
		else 'drop'
	end as trend
from cte_last_year;




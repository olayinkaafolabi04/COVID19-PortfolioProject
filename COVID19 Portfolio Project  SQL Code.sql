Select *
From Project1..Coviddeath
Order by population DESC, continent DESC


Select *
From Project1..CovidVacc
Order by continent DESC


Select location, total_cases, new_cases, total_deaths, population
From Project1..Coviddeath
Order by 1, 2



---------------------------------CANADA ONLY DATA--------------------------------

--1. 
----Calculating Total Cases vs Total deaths (In Canada)
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From Project1..Coviddeath
Where location ='Canada'
Order by date DESC
--- This information shows the death percentage if infected by Covid in Canada. 



--2.
----COVID19 death to case percentage(In Canada)
Select location, Max(total_cases) AS TotalCaseInCanada, Max(cast(total_deaths as int)) AS TotalDeathInCanada, Max(cast(total_deaths as int))/Max(total_cases)*100 as Death_Percentage
From Project1..Coviddeath
Where location ='Canada'
Group by location 
----1.05% of infected cases resulted in death in Canada. 




--3.
--Calculating the Total Cases vs Population (In Canada)
Select location, date, total_cases, population, (total_cases/population)*100 as Case_Percentage
From Project1..Coviddeath
Where location = 'Canada'
Order by date ASC
---This information shows the confirmed percentage of the population that got infected by Covid in Canada.




--------------------------WORLD DATA (Country)-----------------------------

--1.
--Calculating the country with the highest death rate. 
Select location, Max(cast(total_deaths as int)) as Country_Highest_death_rate
From Project1..Coviddeath
Where continent is not null
Group by location
Order by Country_Highest_death_rate DESC
---We can conclude that United States have the highest death rate. 




--2.
--Calculating the country with the highest infection rate in comparison to the population.
Select date, location, population, Max(total_cases) as Maximum_Infection_Count, Max((total_cases/population))*100 as Maximum_Infection_Percentage
From Project1..Coviddeath
Where continent is not null 
Group by location, population, date 
Order by Maximum_Infection_Percentage DESC 
---According to this information, we can conclude that Faerore Islands have the highest percentage of infection case when compared to population.




--3.
--Calculating the country with the highest death rate compare to population.
Select location, population, Max(cast(total_deaths as int)) as Maximum_Death_Count, Max(total_deaths/population)*100 as Maximum_Death_Percentage
From Project1..Coviddeath
Where continent is not null
Group by location, population
Order by Maximum_Death_Percentage DESC
---With this information, we can conclude that Peru have the maximum death rate when compared to population.



--4.
---Calculating the country with the highest new death count.
Select location, Sum(new_cases), Sum(cast(new_deaths as int)), Sum(cast(new_deaths as int))/Sum(new_cases)*100 as New_death_percent
From Project1..Coviddeath
Where continent is not null
Group by location
Order by New_death_percent DESC
---Yemen is the country with the highest percentage for new death rate; 18% of new cases eventually dies. 
***North Korea data is wrong***



----------------WORLD DATA (Continent)-------------

--1.
--Calculating the continent with the highest death rate.
Select continent, Max(cast(total_deaths as int)) as Continent_Highest_death_rate
From Project1..Coviddeath
Where continent is not null
Group by continent
Order by Continent_Highest_death_rate DESC
---We can conclude that North America have the highest death rate. 
***It seems the query only factored USA alone for North America***




--2.
--Calculating the continent with the highest total cases reported.
Select continent, Max(total_cases) as Continent_Highest_Total_Cases
From Project1..Coviddeath
Where continent is not null
Group by continent
Order by Continent_Highest_Total_Cases DESC
---We can conclude that North America have the highest infection death rate.





------------JOINING TWO TABLES-----------

Select dea.location, dea.date, dea.population, vac.new_vaccinations, Sum(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) AS TotalVacNumber
From Project1..CovidVacc AS vac
Inner Join Project1..Coviddeath AS dea
ON dea.location = vac.location and dea.date = vac.date
Where dea.location = 'Canada'  
Order by 1, 2




--Total population vs Vaccination (In Canada)
Select dea.location, dea.date, dea.population, vac.people_vaccinated, (vac.people_vaccinated/population)* 100 AS VacPop, Sum(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) AS TotalVacNumber
From Project1..CovidVacc AS vac
Inner Join Project1..Coviddeath AS dea
ON dea.location = vac.location and dea.date = vac.date
Where dea.location = 'Canada'
Order by VacPop DESC

















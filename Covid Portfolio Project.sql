--Covid-19 Data Exploration

--Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Select *
From PortfolioProject..CovidDeaths
Where continent is not Null
Order By 3,4

Select *
From PortfolioProject..CovidVaccinations
Order By 3,4


--Select data that we are going to be starting with 

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order by 1,2


--Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract Covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathPercentage
From PortfolioProject..CovidDeaths
Where location = 'United States'
and continent is not Null
Order by 1,2


--Total Cases vs Population
--Shows percentage of population infected with Covid

Select location, date, total_cases, population, (total_cases/population)*100 As PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location = 'United States'
and continent is not Null
Order by 1,2


--Countries with Highest Infection Rate compared to Population

Select location, population, Max(total_cases) As HighestInfectionCount, Max((total_cases/population))*100 As PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent <> ' '
Group by location, population
Order by PercentPopulationInfected Desc


--Countries with Highest Death Count per Population

Select location, Max(cast(total_deaths As int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent <> ' '
Group by location
Order by TotalDeathCount Desc


--BREAKING THINGS DOWN BY CONTINENT

--Shows continents with the Highest Death count per Population

Select continent, Max(cast(total_deaths As int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent <> ' '
Group by continent
Order by TotalDeathCount Desc


--GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location = 'United States'
where continent <> ' '
order by 1,2


--Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ' '
order by 2,3


--Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ' '
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100 as PercentPopulationVaccinated
From PopvsVac


--Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations bigint,   
RollingPeopleVaccinated numeric)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ' '
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 As PercentRollingPeopleVaccinatedPop
From #PercentPopulationVaccinated


--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated As
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ' '
--order by 2,3

Select *                                                       
From PercentPopulationVaccinated

Select *
From PortfolioProject..CovidDeaths
Where continent is not Null
Order By 3,4

Select *
From PortfolioProject..CovidVaccinations
Order By 3,4

--Select the data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract Covid in your country
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathPercentage
From PortfolioProject..CovidDeaths
Where location = 'United States'
Where continent is not Null 
Order by 1,2

--Looking at the Total Cases vs Population
--Shows what percentage of population got Covid
Select location, date, total_cases, population, (total_cases/population)*100 As PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location = 'United States'
Where continent is not Null
Order by 1,2

--Looking at Countries with Highest Infection Rate compared to Population
Select location, population, Max(total_cases) As HighestInfectionCount, Max((total_cases/population))*100 As PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent is not Null
Group by location, population
Order by PercentPopulationInfected Desc

--Showing Countries with Highest Death Count per Population
--Note: These are the true values based on continent for TotalDeathCount
Select location, Max(cast(total_deaths As int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent is not Null and location <> 'World' and location <> 'Upper middle income' and location <> 'High income' and location <> 'Lower middle income'
Group by location
Order by TotalDeathCount Desc

--BREAKING THINGS DOWN BY CONTINENT
--Showing continents with the highest death count per population
--Note: These are not the true values based on continent for TotalDeathCount
Select continent, Max(cast(total_deaths As int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location = 'United States'
Where continent is not Null and continent <> ' '
Group by continent
Order by TotalDeathCount Desc

--GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.continent <> ' '
order by 2,3

--USE CTE
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--TEMP TABLE
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations int,
RollingPeopleVaccinated numeric)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
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
where dea.continent is not null 
--order by 2,3

Select *
From PercentPopulationVaccinated
Select *
From NashvilleHousing

--Standardize date format


ALTER TABle NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

Select SaleDateConverted
From NashvilleHousing

--Populate Property Address Data

Select *
From NashvilleHousing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing  a
JOIN NashvilleHousing b
 on a.ParcelID = b.ParcelID
 And a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing  a
JOIN NashvilleHousing b
 on a.ParcelID = b.ParcelID
 And a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

--Breaking out Address into Individual Colums(Address, City,State)

Select PropertyAddress
From NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as Address 
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,LEN(PropertyAddress)) as Address
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);
Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);
Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,LEN(PropertyAddress))




Select OwnerAddress
From NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress ,',', '.'),3)
,PARSENAME(REPLACE(OwnerAddress ,',', '.'),2)
,PARSENAME(REPLACE(OwnerAddress ,',', '.'),1)
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add PrSplitAddress Nvarchar(255);
Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1)
USE [AirportDb]
GO
/****** Object:  Table [dbo].[Airports]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airports](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Country] [varchar](150) NOT NULL,
	[Citty] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Airports] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Planes]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NumberOfSeats] [smallint] NOT NULL,
 CONSTRAINT [PK_Planes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airlines]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airlines](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Airlines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusOfFligths]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusOfFligths](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_StatusOfFligths] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flights]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flights](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AirLineId] [int] NOT NULL,
	[DepartureCountryId] [int] NOT NULL,
	[DepartureCityId] [int] NOT NULL,
	[DepartureAirportId] [int] NOT NULL,
	[ArrivalCountryId] [int] NOT NULL,
	[ArrivalCityId] [int] NOT NULL,
	[ArrivalAirportId] [int] NOT NULL,
	[DepartureDate] [datetime] NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[DurationTime] [time](7) NOT NULL,
	[StatusId] [int] NOT NULL,
	[PlaneId] [int] NOT NULL,
 CONSTRAINT [PK_Flights] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwFlightsInfo]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VwFlightsInfo] as
SELECT  F.[id]
      --,[AirLineId]
	  ,Airlines.[Name] Airlines
      --,[DepartureCountryId]
	  ,DepartureCountry.[Country] as [Departure Country]
      --,[DepartureCityId]
	  ,DepartureCity.Citty as [Departure City]
      --,[DepartureAirportId]
	  ,Airports.[Name] as [Departure Airport]
      --,[ArrivalCountryId]
	  ,ArrivalCountry.Country as [Arrival Country]
      --,[ArrivalCityId]
	  ,ArrivalCity.[Citty] as [Arrival City]
      --,[ArrivalAirportId]
	  ,AirportsArrival.[Name] as [Arrival Airport]
      ,[DepartureDate]
      ,[ArrivalDate]
      ,[DurationTime]
      --,[StatusId]
	  ,StatusOfFligths.[Name] [Status]
      --,[PlaneId]
	  ,Planes.[Name] Plane
  FROM [AirportDb].[dbo].[Flights] F
   join Airlines on F.AirLineId=Airlines.id
  join Airports on F.DepartureAirportId=Airports.id 
  join Airports as AirportsArrival on F.ArrivalAirportId=AirportsArrival.id
  join StatusOfFligths on F.StatusId=StatusOfFligths.id
  join Planes on F.PlaneId=Planes.id
  join Airports as DepartureCountry on F.DepartureCountryId=DepartureCountry.id
  join Airports as DepartureCity on F.DepartureCityId=DepartureCity.id
  join Airports as ArrivalCountry on F.ArrivalCountryId=ArrivalCountry.id
  join Airports as ArrivalCity on F.ArrivalCityId=ArrivalCity.id
GO
/****** Object:  View [dbo].[VwFlightsDayInfo]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[VwFlightsDayInfo] as
SELECT  [id]
      ,[Airlines]
      ,[Departure Country]
      ,[Departure City]
      ,[Departure Airport]
      ,[Arrival Country]
      ,[Arrival City]
      ,[Arrival Airport]
      ,[DepartureDate]
      ,[ArrivalDate]
      ,[DurationTime]
      ,[Status]
      ,[Plane]
  FROM [AirportDb].[dbo].[VwFlightsInfo]
    where [Status] !='Canceled' 
  and  [DepartureDate] between '2019-10-03 00:00' and '2019-10-03 23:59'
GO
/****** Object:  Table [dbo].[MaintenanceOfPlane]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceOfPlane](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PlaneId] [int] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[MaintenanceDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MaintenanceOfPlane] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwMaintenancePlanes]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VwMaintenancePlanes] as
SELECT  M.[id]
      --,[PlaneId]
	  ,Planes.[Name] Plane
      ,M.[Name]
      ,[MaintenanceDate]
  FROM [AirportDb].[dbo].[MaintenanceOfPlane] M

  join Planes on M.PlaneId=Planes.id
GO
/****** Object:  Table [dbo].[Ways]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ways](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Ways] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PassangerInfo]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PassangerInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[FlightId] [int] NOT NULL,
	[Сitizenship] [varchar](50) NOT NULL,
	[WayId] [tinyint] NOT NULL,
	[TicketPrice] [decimal](18, 2) NULL,
	[GenderId] [tinyint] NOT NULL,
 CONSTRAINT [PK_PassangerInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwPassangerInfo]    Script Date: 10/7/2019 7:05:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[VwPassangerInfo] as
SELECT  P.[id]
      ,[FirstName]
      ,[LastName]
      --,[FlightId]
	  ,VwFlightsInfo.[Departure City] as [Departure City]
	  ,VwFlightsInfo.[Arrival City] as [Destination]
	  ,VwFlightsInfo.[DepartureDate] as [Departure Date]
	  ,VwFlightsInfo.[ArrivalDate] as [Arrival Date]
      ,[Сitizenship]
      --,[WayId]
	  ,Ways.[Name] as Way
      ,Format ([TicketPrice], 'c','en-US') as 'Ticket price'
      --,[GenderId]
	  ,Gender.[Name] as Gender
  FROM [AirportDb].[dbo].[PassangerInfo] P

  join VwFlightsInfo on P.FlightId=VwFlightsInfo.id
  join Ways on P.WayId=Ways.id
  join Gender on P.GenderId=Gender.id
GO
SET IDENTITY_INSERT [dbo].[Airlines] ON 
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (1, N'Azerbaijan Airlines')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (2, N'Turkish Airlines')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (3, N'Qatar Airways')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (4, N'Singapure Airlines')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (5, N'Emirates')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (6, N'Lufthansa')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (7, N'British Airways')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (8, N'Aeroflot')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (9, N'American Airlines')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (10, N'WizzAir')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (11, N'Pegasus')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (12, N'Delta')
GO
INSERT [dbo].[Airlines] ([id], [Name]) VALUES (13, N'Air Asia')
GO
SET IDENTITY_INSERT [dbo].[Airlines] OFF
GO
SET IDENTITY_INSERT [dbo].[Airports] ON 
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (1, N'(HYA) Haydar Alyiev International Airport', N'Azerbaijan', N'Baku')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (2, N'(IST) Istanbul International Airport', N'Turkey', N'Istanbul')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (3, N'(FRA)Frankfurt Airport', N'Germany', N'Frankfurt')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (4, N'(DXB)Dubai-International', N'United Arab Emirates', N'Dubai')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (5, N'(BCN)Barcelona Airport', N'Spain', N'Barcelona')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (6, N'(SVO) Moscow-Sheremetyevo', N'Russia', N'Moscow')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (7, N'Amsterdam International', N'Holland', N'Amsterdam')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (8, N'New York-Newark', N'USA', N'New York')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (9, N'Bilbao Airport', N'Spain', N'Bilbao')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (10, N'Rome-Fiumicino', N'Italy', N'Rome')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (11, N'London-Heathrow', N'Unated Kingdom', N'London')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (12, N'Munich', N'Germany', N'Munich')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (13, N'Florence', N'Italy', N'Florence')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (14, N'Singapure Airport', N'Singapure', N'Singapure')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (15, N'Paris Ch. de Gaulle', N'France', N'Paris')
GO
INSERT [dbo].[Airports] ([id], [Name], [Country], [Citty]) VALUES (16, N'Den Pasar', N'Indonesia', N'Bali')
GO
SET IDENTITY_INSERT [dbo].[Airports] OFF
GO
SET IDENTITY_INSERT [dbo].[Flights] ON 
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (1, 1, 1, 1, 1, 3, 3, 3, CAST(N'2019-10-04T14:35:00.000' AS DateTime), CAST(N'2019-10-05T18:10:00.000' AS DateTime), CAST(N'03:45:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (2, 2, 2, 2, 2, 1, 1, 1, CAST(N'2019-10-05T11:20:00.000' AS DateTime), CAST(N'2019-10-05T14:15:00.000' AS DateTime), CAST(N'02:55:00' AS Time), 1, 3)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (3, 4, 6, 6, 6, 5, 5, 5, CAST(N'2019-10-02T10:30:00.000' AS DateTime), CAST(N'2019-10-02T13:40:00.000' AS DateTime), CAST(N'03:10:00' AS Time), 2, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (4, 1, 1, 1, 1, 6, 6, 6, CAST(N'2019-10-03T19:20:00.000' AS DateTime), CAST(N'2019-10-03T22:15:00.000' AS DateTime), CAST(N'02:55:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (5, 3, 1, 1, 1, 2, 2, 2, CAST(N'2019-10-04T15:00:00.000' AS DateTime), CAST(N'2019-10-04T18:10:00.000' AS DateTime), CAST(N'03:10:00' AS Time), 1, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (6, 4, 14, 14, 14, 4, 4, 4, CAST(N'2019-10-04T09:30:00.000' AS DateTime), CAST(N'2019-10-04T15:10:00.000' AS DateTime), CAST(N'05:40:00' AS Time), 1, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (7, 10, 9, 9, 9, 13, 13, 13, CAST(N'2019-10-04T17:20:00.000' AS DateTime), CAST(N'2019-10-04T19:25:00.000' AS DateTime), CAST(N'02:05:00' AS Time), 2, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (8, 7, 11, 11, 11, 1, 1, 1, CAST(N'2019-10-03T14:45:00.000' AS DateTime), CAST(N'2019-10-03T18:00:00.000' AS DateTime), CAST(N'03:15:00' AS Time), 1, 5)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (9, 9, 8, 8, 8, 6, 6, 6, CAST(N'2019-10-04T09:40:00.000' AS DateTime), CAST(N'2019-10-04T17:00:00.000' AS DateTime), CAST(N'07:20:00' AS Time), 1, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (10, 6, 3, 3, 3, 2, 2, 2, CAST(N'2019-10-04T11:00:00.000' AS DateTime), CAST(N'2019-10-04T14:00:00.000' AS DateTime), CAST(N'03:00:00' AS Time), 3, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (12, 5, 4, 4, 4, 1, 1, 1, CAST(N'2019-10-04T12:00:00.000' AS DateTime), CAST(N'2019-10-04T15:05:00.000' AS DateTime), CAST(N'03:05:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (13, 8, 6, 6, 6, 15, 15, 15, CAST(N'2019-10-03T08:00:00.000' AS DateTime), CAST(N'2019-10-03T11:30:00.000' AS DateTime), CAST(N'03:30:00' AS Time), 1, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (14, 2, 4, 4, 4, 10, 10, 10, CAST(N'2019-10-03T17:00:00.000' AS DateTime), CAST(N'2019-10-03T20:40:00.000' AS DateTime), CAST(N'03:40:00' AS Time), 2, 6)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (15, 11, 12, 12, 12, 2, 2, 2, CAST(N'2019-10-03T11:45:00.000' AS DateTime), CAST(N'2019-10-03T15:00:00.000' AS DateTime), CAST(N'03:15:00' AS Time), 1, 7)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (16, 1, 1, 1, 1, 8, 8, 8, CAST(N'2019-10-03T11:00:00.000' AS DateTime), CAST(N'2019-10-03T18:30:00.000' AS DateTime), CAST(N'07:30:00' AS Time), 1, 5)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (17, 12, 8, 8, 8, 2, 2, 2, CAST(N'2019-10-03T12:45:00.000' AS DateTime), CAST(N'2019-10-03T20:30:00.000' AS DateTime), CAST(N'07:45:00' AS Time), 1, 5)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (18, 6, 3, 3, 3, 7, 7, 7, CAST(N'2019-10-03T11:00:00.000' AS DateTime), CAST(N'2019-10-03T13:00:00.000' AS DateTime), CAST(N'02:00:00' AS Time), 3, 3)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (19, 7, 1, 1, 1, 11, 11, 11, CAST(N'2019-10-04T12:00:00.000' AS DateTime), CAST(N'2019-10-04T16:00:00.000' AS DateTime), CAST(N'04:00:00' AS Time), 1, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (20, 2, 1, 1, 1, 7, 7, 7, CAST(N'2019-10-04T08:00:00.000' AS DateTime), CAST(N'2019-10-04T12:00:00.000' AS DateTime), CAST(N'04:00:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (21, 3, 2, 2, 2, 4, 4, 4, CAST(N'2019-10-02T12:00:00.000' AS DateTime), CAST(N'2019-10-02T15:00:00.000' AS DateTime), CAST(N'03:00:00' AS Time), 1, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (22, 8, 2, 2, 6, 16, 16, 16, CAST(N'2019-10-02T10:00:00.000' AS DateTime), CAST(N'2019-10-06T19:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, 3)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (23, 2, 16, 16, 16, 2, 2, 2, CAST(N'2019-10-03T11:00:00.000' AS DateTime), CAST(N'2019-10-03T19:00:00.000' AS DateTime), CAST(N'08:00:00' AS Time), 3, 3)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (24, 13, 16, 16, 16, 4, 4, 4, CAST(N'2019-10-04T10:00:00.000' AS DateTime), CAST(N'2019-10-04T17:30:00.000' AS DateTime), CAST(N'07:30:00' AS Time), 1, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (25, 11, 1, 1, 1, 12, 12, 12, CAST(N'2019-10-05T10:00:00.000' AS DateTime), CAST(N'2019-10-05T14:30:00.000' AS DateTime), CAST(N'04:30:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (26, 7, 11, 11, 11, 6, 6, 6, CAST(N'2019-10-05T07:30:00.000' AS DateTime), CAST(N'2019-10-05T11:00:00.000' AS DateTime), CAST(N'03:30:00' AS Time), 1, 3)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (27, 3, 4, 4, 4, 5, 5, 5, CAST(N'2019-10-05T05:00:00.000' AS DateTime), CAST(N'2019-10-05T10:30:00.000' AS DateTime), CAST(N'05:30:00' AS Time), 2, 6)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (28, 6, 5, 5, 5, 1, 1, 1, CAST(N'2019-10-05T02:45:00.000' AS DateTime), CAST(N'2019-10-05T06:00:00.000' AS DateTime), CAST(N'03:15:00' AS Time), 1, 2)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (29, 8, 6, 6, 6, 1, 1, 1, CAST(N'2019-10-05T03:10:00.000' AS DateTime), CAST(N'2019-10-05T06:10:00.000' AS DateTime), CAST(N'03:00:00' AS Time), 1, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (30, 4, 4, 4, 4, 14, 14, 14, CAST(N'2019-10-05T12:00:00.000' AS DateTime), CAST(N'2019-10-05T18:00:00.000' AS DateTime), CAST(N'06:00:00' AS Time), 1, 5)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (31, 10, 1, 1, 1, 9, 9, 9, CAST(N'2019-10-04T12:30:00.000' AS DateTime), CAST(N'2019-10-04T15:30:00.000' AS DateTime), CAST(N'03:00:00' AS Time), 1, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (32, 13, 14, 14, 14, 10, 10, 10, CAST(N'2019-10-05T11:00:00.000' AS DateTime), CAST(N'2019-10-05T19:30:00.000' AS DateTime), CAST(N'08:30:00' AS Time), 1, 1)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (33, 2, 2, 2, 2, 10, 10, 10, CAST(N'2019-10-04T08:00:00.000' AS DateTime), CAST(N'2019-10-04T12:30:00.000' AS DateTime), CAST(N'04:30:00' AS Time), 2, 4)
GO
INSERT [dbo].[Flights] ([id], [AirLineId], [DepartureCountryId], [DepartureCityId], [DepartureAirportId], [ArrivalCountryId], [ArrivalCityId], [ArrivalAirportId], [DepartureDate], [ArrivalDate], [DurationTime], [StatusId], [PlaneId]) VALUES (34, 5, 8, 8, 8, 4, 4, 4, CAST(N'2019-10-03T05:00:00.000' AS DateTime), CAST(N'2019-10-03T17:30:00.000' AS DateTime), CAST(N'10:30:00' AS Time), 1, 3)
GO
SET IDENTITY_INSERT [dbo].[Flights] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 
GO
INSERT [dbo].[Gender] ([id], [Name]) VALUES (1, N'Male')
GO
INSERT [dbo].[Gender] ([id], [Name]) VALUES (2, N'Female')
GO
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[MaintenanceOfPlane] ON 
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (1, 1, N'Engine', CAST(N'2019-10-02T11:00:00.000' AS DateTime))
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (2, 2, N'Engine', CAST(N'2019-07-10T20:00:00.000' AS DateTime))
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (3, 1, N'Engine', CAST(N'2019-09-11T12:00:00.000' AS DateTime))
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (4, 3, N'Engine', CAST(N'2019-08-09T13:40:00.000' AS DateTime))
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (5, 4, N'Engine', CAST(N'2019-07-22T13:45:00.000' AS DateTime))
GO
INSERT [dbo].[MaintenanceOfPlane] ([id], [PlaneId], [Name], [MaintenanceDate]) VALUES (7, 4, N'Engine', CAST(N'2019-10-04T21:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MaintenanceOfPlane] OFF
GO
SET IDENTITY_INSERT [dbo].[PassangerInfo] ON 
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (1, N'Ibrahim', N'Ibrahimli', 2, N'Azerbaijan', 2, CAST(350.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (2, N'Gasim', N'Shirinli', 4, N'Azerbaijan', 1, CAST(448.50 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (3, N'Aynur ', N'Dadashzada', 1, N'Georgia', 2, CAST(588.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (5, N'Narmin', N'Mammadov', 4, N'Italy', 1, CAST(830.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (6, N'Jhon', N'Albert', 6, N'United States of America', 1, CAST(1090.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (7, N'Robert', N'Lewandovski', 10, N'Poland', 2, CAST(159.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (8, N'Franck', N'Riberry', 11, N'France', 1, CAST(233.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (9, N'Cristiano ', N'Ronaldo', 15, N'Portugal', 2, CAST(445.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (10, N'Britney', N'Spirs', 8, N'United States of America', 1, CAST(656.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (11, N'Monica', N'Belucci', 3, N'Italy', 1, CAST(278.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (12, N'Franck', N'Lampard', 7, N'United Kingdom', 2, CAST(788.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (13, N'Catty', N'Perry', 13, N'United States of America', 1, CAST(178.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (14, N'Jenifer', N'Lopez', 22, N'United  States of America', 2, CAST(322.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (15, N'Fariz', N'Jafarov', 3, N'Russian Federation', 1, CAST(444.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (16, N'Ramin', N'Guluzada', 16, N'Azerbaijan', 2, CAST(565.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (17, N'Tony', N'Montana', 12, N'Italy', 1, CAST(555.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (18, N'Unai', N'Emery', 21, N'Spain', 2, CAST(890.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (19, N'Mahammad', N'Salah', 5, N'Egypt', 1, CAST(1400.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (20, N'Miralam', N'Pianich', 9, N'Montenegro', 2, CAST(1107.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (21, N'Maksim', N'Ivanov', 18, N'Russian Federation', 1, CAST(344.00 AS Decimal(18, 2)), 1)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (22, N'Tatiana', N'Maksimova', 19, N'Russian Federation', 1, CAST(199.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (23, N'Elena', N'Smirnova', 2, N'Belarus', 2, CAST(200.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[PassangerInfo] ([id], [FirstName], [LastName], [FlightId], [Сitizenship], [WayId], [TicketPrice], [GenderId]) VALUES (24, N'Galina ', N'Novyak', 3, N'Ukraine', 1, CAST(240.00 AS Decimal(18, 2)), 2)
GO
SET IDENTITY_INSERT [dbo].[PassangerInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Planes] ON 
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (1, N'A320-200', 150)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (2, N'A330-300', 291)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (3, N'B757-200', 188)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (4, N'B777-200', 273)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (5, N'B787-9 Dreamliner', 300)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (6, N'A380-100', 350)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (7, N'A319-200', 170)
GO
INSERT [dbo].[Planes] ([id], [Name], [NumberOfSeats]) VALUES (8, N'A300-100', 200)
GO
SET IDENTITY_INSERT [dbo].[Planes] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusOfFligths] ON 
GO
INSERT [dbo].[StatusOfFligths] ([id], [Name]) VALUES (1, N'In time')
GO
INSERT [dbo].[StatusOfFligths] ([id], [Name]) VALUES (2, N'Late')
GO
INSERT [dbo].[StatusOfFligths] ([id], [Name]) VALUES (3, N'Canceled')
GO
SET IDENTITY_INSERT [dbo].[StatusOfFligths] OFF
GO
SET IDENTITY_INSERT [dbo].[Ways] ON 
GO
INSERT [dbo].[Ways] ([id], [Name]) VALUES (1, N'One way')
GO
INSERT [dbo].[Ways] ([id], [Name]) VALUES (2, N'Roundtrip')
GO
INSERT [dbo].[Ways] ([id], [Name]) VALUES (3, N'Multi-City')
GO
SET IDENTITY_INSERT [dbo].[Ways] OFF
GO
ALTER TABLE [dbo].[Flights] ADD  CONSTRAINT [DF_Flights_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[MaintenanceOfPlane] ADD  CONSTRAINT [DF_MaintenanceOfPlane_MaintenanceDate]  DEFAULT (getdate()) FOR [MaintenanceDate]
GO
ALTER TABLE [dbo].[PassangerInfo] ADD  CONSTRAINT [DF_PassangerInfo_GenderId]  DEFAULT ((1)) FOR [GenderId]
GO
ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Airlines] FOREIGN KEY([AirLineId])
REFERENCES [dbo].[Airlines] ([id])
GO
ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Airlines]
GO
ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Airports] FOREIGN KEY([DepartureAirportId])
REFERENCES [dbo].[Airports] ([id])
GO
ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Airports]
GO
ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Airports1] FOREIGN KEY([ArrivalAirportId])
REFERENCES [dbo].[Airports] ([id])
GO
ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Airports1]
GO
ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Planes] FOREIGN KEY([PlaneId])
REFERENCES [dbo].[Planes] ([id])
GO
ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Planes]
GO
ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_StatusOfFligths] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusOfFligths] ([id])
GO
ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_StatusOfFligths]
GO
ALTER TABLE [dbo].[MaintenanceOfPlane]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceOfPlane_Planes] FOREIGN KEY([PlaneId])
REFERENCES [dbo].[Planes] ([id])
GO
ALTER TABLE [dbo].[MaintenanceOfPlane] CHECK CONSTRAINT [FK_MaintenanceOfPlane_Planes]
GO

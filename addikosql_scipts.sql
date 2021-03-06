USE [master]
GO
/****** Object:  Database [Addiko]    Script Date: 04/08/2020 12:25:20 ******/
CREATE DATABASE [Addiko] ON  PRIMARY 
( NAME = N'Addiko', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MYSQL2008\MSSQL\DATA\Addiko.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Addiko_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MYSQL2008\MSSQL\DATA\Addiko_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Addiko] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Addiko].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Addiko] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Addiko] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Addiko] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Addiko] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Addiko] SET ARITHABORT OFF
GO
ALTER DATABASE [Addiko] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Addiko] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Addiko] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Addiko] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Addiko] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Addiko] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Addiko] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Addiko] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Addiko] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Addiko] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Addiko] SET  DISABLE_BROKER
GO
ALTER DATABASE [Addiko] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Addiko] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Addiko] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Addiko] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Addiko] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Addiko] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Addiko] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Addiko] SET  READ_WRITE
GO
ALTER DATABASE [Addiko] SET RECOVERY FULL
GO
ALTER DATABASE [Addiko] SET  MULTI_USER
GO
ALTER DATABASE [Addiko] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Addiko] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Addiko', N'ON'
GO
USE [Addiko]
GO
/****** Object:  User [ap_demo]    Script Date: 04/08/2020 12:25:20 ******/
CREATE USER [ap_demo] FOR LOGIN [ap_demo] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Korisnik]    Script Date: 04/08/2020 12:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Korisnik](
	[ID_Korisnik] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Prezime] [nvarchar](100) NOT NULL,
	[Telefon] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Korisnik] PRIMARY KEY CLUSTERED 
(
	[ID_Korisnik] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Poruka]    Script Date: 04/08/2020 12:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poruka](
	[ID_Poruka] [int] IDENTITY(1,1) NOT NULL,
	[Datum_vrijeme_slanja] [datetime] NOT NULL,
	[ID_Korisnik] [int] NOT NULL,
	[Naziv_datoteke] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Poruka] PRIMARY KEY CLUSTERED 
(
	[ID_Poruka] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[addiko_spInsertKorisnik]    Script Date: 04/08/2020 12:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[addiko_spInsertKorisnik] @Ime nvarchar(50), @Prezime nvarchar(100), @Telefon nvarchar(50)
as

INSERT INTO Korisnik (Ime, Prezime, Telefon)
VALUES (@Ime, @Prezime, @Telefon)
GO
/****** Object:  StoredProcedure [dbo].[addiko_spDohvatiSveKorisnike]    Script Date: 04/08/2020 12:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[addiko_spDohvatiSveKorisnike]
as

select *
from Korisnik
GO
/****** Object:  StoredProcedure [dbo].[addiko_spDohvatiKorisnika]    Script Date: 04/08/2020 12:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[addiko_spDohvatiKorisnika] @ID int
as

select *
from Korisnik
where ID_Korisnik = @ID
GO
/****** Object:  StoredProcedure [dbo].[addiko_spInsertPoruka]    Script Date: 04/08/2020 12:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[addiko_spInsertPoruka] @DatumVrijeme datetime, @ID_Korisnik int, @NazivDatoteke nvarchar(150)
as

insert into Poruka (Datum_vrijeme_slanja, ID_Korisnik, Naziv_datoteke)
values (@DatumVrijeme, @ID_Korisnik, @NazivDatoteke)
GO
/****** Object:  ForeignKey [FK_Poruka_Korisnik]    Script Date: 04/08/2020 12:25:20 ******/
ALTER TABLE [dbo].[Poruka]  WITH CHECK ADD  CONSTRAINT [FK_Poruka_Korisnik] FOREIGN KEY([ID_Korisnik])
REFERENCES [dbo].[Korisnik] ([ID_Korisnik])
GO
ALTER TABLE [dbo].[Poruka] CHECK CONSTRAINT [FK_Poruka_Korisnik]
GO

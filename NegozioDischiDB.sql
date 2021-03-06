USE [master]
GO
/****** Object:  Database [NegozioDischi]    Script Date: 16/07/2021 15:00:09 ******/
CREATE DATABASE [NegozioDischi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NegozioDischi', FILENAME = N'C:\Users\katia\NegozioDischi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NegozioDischi_log', FILENAME = N'C:\Users\katia\NegozioDischi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NegozioDischi] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NegozioDischi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NegozioDischi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NegozioDischi] SET ARITHABORT OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NegozioDischi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NegozioDischi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NegozioDischi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NegozioDischi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NegozioDischi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NegozioDischi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NegozioDischi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NegozioDischi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NegozioDischi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NegozioDischi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NegozioDischi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NegozioDischi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NegozioDischi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NegozioDischi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NegozioDischi] SET  MULTI_USER 
GO
ALTER DATABASE [NegozioDischi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NegozioDischi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NegozioDischi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NegozioDischi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NegozioDischi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NegozioDischi] SET QUERY_STORE = OFF
GO
USE [NegozioDischi]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [NegozioDischi]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titolo] [nvarchar](50) NOT NULL,
	[AnnoUscita] [int] NOT NULL,
	[CasaDiscografica] [nvarchar](30) NOT NULL,
	[Genere] [nvarchar](20) NOT NULL,
	[SupportoDistribuzione] [nvarchar](20) NOT NULL,
	[BandId] [int] NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnNumeroAlbumPerGenere]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ufnNumeroAlbumPerGenere] 
(
	-- Add the parameters for the function here
	@genre nvarchar(50)
)
RETURNS TABLE 
AS
	RETURN ( SELECT a.Genere, COUNT(*) AS [Numero Album]
			FROM Album a
			GROUP BY a.Genere
			HAVING a.Genere = @genre)
GO
/****** Object:  UserDefinedFunction [dbo].[ufnNumeroAlbumGeneri]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ufnNumeroAlbumGeneri] 
(
	-- Add the parameters for the function here

)
RETURNS TABLE 
AS
	RETURN ( SELECT a.Genere, COUNT(*) AS [Numero Album]
			FROM Album a
			GROUP BY a.Genere
			)
GO
/****** Object:  Table [dbo].[Band]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Band](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[NumeroComponenti] [int] NOT NULL,
 CONSTRAINT [PK_Band] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brano]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brano](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titolo] [nvarchar](30) NOT NULL,
	[Durata] [int] NOT NULL,
 CONSTRAINT [PK_Brano] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BraniAlbum]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BraniAlbum](
	[AlbumId] [int] NOT NULL,
	[BranoId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaGeneraleNegozio]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaGeneraleNegozio] AS
SELECT a.Titolo AS [Titolo Album]
	, a.AnnoUscita AS [Anno Pubblicazione]
	, a.CasaDiscografica AS [Etichetta]
	, a.Genere 
	, a.SupportoDistribuzione AS [Supporto]
	, b.Nome AS [Band]
	, b.NumeroComponenti AS [Componenti]
	, br.Titolo AS [Titolo Brano]
	, br.Durata AS [Durata (sec)]
FROM Band b
INNER JOIN Album a
ON b.Id = a.BandId
	INNER JOIN BraniAlbum ba
	ON ba.AlbumId = a.Id
		INNER JOIN Brano br
		ON br.Id = ba.BranoId
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Band] FOREIGN KEY([BandId])
REFERENCES [dbo].[Band] ([Id])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Band]
GO
ALTER TABLE [dbo].[BraniAlbum]  WITH CHECK ADD  CONSTRAINT [FK_BraniAlbum_Album] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([Id])
GO
ALTER TABLE [dbo].[BraniAlbum] CHECK CONSTRAINT [FK_BraniAlbum_Album]
GO
ALTER TABLE [dbo].[BraniAlbum]  WITH CHECK ADD  CONSTRAINT [FK_BraniAlbum_Brano] FOREIGN KEY([BranoId])
REFERENCES [dbo].[Brano] ([Id])
GO
ALTER TABLE [dbo].[BraniAlbum] CHECK CONSTRAINT [FK_BraniAlbum_Brano]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [CK_Album_Genere] CHECK  (([Genere]='Metal' OR [Genere]='Pop' OR [Genere]='Rock' OR [Genere]='Jazz' OR [Genere]='Classico'))
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [CK_Album_Genere]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [CK_Album_Supporto] CHECK  (([SupportoDistribuzione]='Streaming' OR [SupportoDistribuzione]='Vinile' OR [SupportoDistribuzione]='CD'))
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [CK_Album_Supporto]
GO
/****** Object:  StoredProcedure [dbo].[sp.CercaAlbumPerEditoreEPerAnno]    Script Date: 16/07/2021 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp.CercaAlbumPerEditoreEPerAnno]
	-- Add the parameters for the stored procedure here
	@editore nvarchar(30)
	, @anno int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Album a
	WHERE a.AnnoUscita = @anno AND a.CasaDiscografica = @editore
	RETURN 0
END
GO
USE [master]
GO
ALTER DATABASE [NegozioDischi] SET  READ_WRITE 
GO

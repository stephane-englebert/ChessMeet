/*
Script de déploiement pour ChessDB

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ChessDB"
:setvar DefaultFilePrefix "ChessDB"
:setvar DefaultDataPath "C:\Users\Stéphane\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Stéphane\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Matches]...';


GO
CREATE TABLE [dbo].[Matches] (
    [id]              INT              IDENTITY (1, 1) NOT NULL,
    [tournament_guid] UNIQUEIDENTIFIER NOT NULL,
    [white_id]        INT              NOT NULL,
    [black_id]        INT              NOT NULL,
    [round]           INT              NOT NULL,
    [result]          NVARCHAR (10)    NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Members]...';


GO
CREATE TABLE [dbo].[Members] (
    [id]        INT            IDENTITY (1, 1) NOT NULL,
    [role]      NVARCHAR (10)  NOT NULL,
    [pseudo]    NVARCHAR (50)  NOT NULL,
    [email]     NVARCHAR (150) NOT NULL,
    [password]  NVARCHAR (150) NOT NULL,
    [birthdate] DATETIME2 (7)  NOT NULL,
    [gender]    NVARCHAR (10)  NOT NULL,
    [elo]       INT            NOT NULL,
    CONSTRAINT [PK_members] PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([email] ASC),
    UNIQUE NONCLUSTERED ([pseudo] ASC)
);


GO
PRINT N'Création de Table [dbo].[Registrations]...';


GO
CREATE TABLE [dbo].[Registrations] (
    [Id]              INT              IDENTITY (1, 1) NOT NULL,
    [player_id]       INT              NOT NULL,
    [tournament_guid] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Tournaments]...';


GO
CREATE TABLE [dbo].[Tournaments] (
    [id]               INT              IDENTITY (1, 1) NOT NULL,
    [guid]             UNIQUEIDENTIFIER NOT NULL,
    [name]             NVARCHAR (255)   NOT NULL,
    [place]            NVARCHAR (255)   NULL,
    [players_min]      INT              NOT NULL,
    [players_max]      INT              NOT NULL,
    [elo_min]          INT              NULL,
    [elo_max]          INT              NULL,
    [categories]       NVARCHAR (255)   NOT NULL,
    [status]           NVARCHAR (50)    NOT NULL,
    [current_round]    INT              NOT NULL,
    [women_only]       BIT              NOT NULL,
    [created_at]       DATETIME2 (7)    NOT NULL,
    [end_registration] DATETIME2 (7)    NOT NULL,
    [updated_at]       DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_tournaments] PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Matches]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD DEFAULT 'notPlayed' FOR [result];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Members]...';


GO
ALTER TABLE [dbo].[Members]
    ADD DEFAULT 'player' FOR [role];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Members]...';


GO
ALTER TABLE [dbo].[Members]
    ADD DEFAULT 1200 FOR [elo];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 2 FOR [players_min];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 32 FOR [players_max];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 0 FOR [elo_min];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 3000 FOR [elo_max];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 'waitingForPlayers' FOR [status];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 0 FOR [current_round];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT 0 FOR [women_only];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT GETDATE() FOR [created_at];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Tournaments]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD DEFAULT GETDATE() FOR [updated_at];


GO
PRINT N'Création de Clé étrangère [dbo].[FK_matches_members_white]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_matches_members_white] FOREIGN KEY ([white_id]) REFERENCES [dbo].[Members] ([id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_matches_members_black]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_matches_members_black] FOREIGN KEY ([black_id]) REFERENCES [dbo].[Members] ([id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_matches_tournaments]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [FK_matches_tournaments] FOREIGN KEY ([tournament_guid]) REFERENCES [dbo].[Tournaments] ([guid]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_registrations_members]...';


GO
ALTER TABLE [dbo].[Registrations]
    ADD CONSTRAINT [FK_registrations_members] FOREIGN KEY ([player_id]) REFERENCES [dbo].[Members] ([id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_registrations_tournaments]...';


GO
ALTER TABLE [dbo].[Registrations]
    ADD CONSTRAINT [FK_registrations_tournaments] FOREIGN KEY ([tournament_guid]) REFERENCES [dbo].[Tournaments] ([guid]);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_Matches_round]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [CK_Matches_round] CHECK (1 = 1);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_matches_result]...';


GO
ALTER TABLE [dbo].[Matches]
    ADD CONSTRAINT [CK_matches_result] CHECK (result IN('notPlayed','whiteWin','blackWin','draw'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_role]...';


GO
ALTER TABLE [dbo].[Members]
    ADD CONSTRAINT [CK_members_role] CHECK (role IN ('admin','player'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_birthdate]...';


GO
ALTER TABLE [dbo].[Members]
    ADD CONSTRAINT [CK_members_birthdate] CHECK (birthdate BETWEEN '1920-01-01' AND GETDATE());


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_gender]...';


GO
ALTER TABLE [dbo].[Members]
    ADD CONSTRAINT [CK_members_gender] CHECK (gender IN ('male','female','other'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_elo]...';


GO
ALTER TABLE [dbo].[Members]
    ADD CONSTRAINT [CK_members_elo] CHECK (elo BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_players_min]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_players_min] CHECK (players_min BETWEEN 2 AND 32);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_players_max]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_players_max] CHECK (players_max BETWEEN 2 AND 32);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_players_minmax]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_players_minmax] CHECK (players_min <= players_max);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_elo_min]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_elo_min] CHECK (elo_min BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_elo_max]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_elo_max] CHECK (elo_max BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_elo_minmax]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_elo_minmax] CHECK (elo_min <= elo_max);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_end_registration]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_end_registration] CHECK (end_registration >= DATEADD(day,players_min,GETDATE()));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_status]...';


GO
ALTER TABLE [dbo].[Tournaments]
    ADD CONSTRAINT [CK_tournaments_status] CHECK (status IN ('waitingForPlayers','inProgress','closed'));


GO
Set Identity_Insert [dbo].[Members] On;
INSERT INTO [dbo].[Members](id, role, pseudo, email, password, birthdate, gender, elo) VALUES
(1, 'admin', 'checkmate', 'checkmate@gmail.com','1234', '1975-06-28 00:00:00', 'male', 1400),
(2, 'player', 'steph', 'stephane.englebert@gmail.com','1234', '1971-06-02 00:00:00', 'male', 1742),
(3, 'player', 'kasparov', 'kasparov@gmail.com','1234', '1963-04-13 00:00:00', 'male', 2812),
(4, 'player', 'karpov', 'karpov@gmail.com','1234', '1951-05-23 00:00:00', 'male', 2617),
(5, 'player', 'alexandra', 'alexandra@gmail.com','1234', '2001-01-14 00:00:00', 'female', 1000);
Set Identity_Insert [dbo].[Members] Off;
GO

Set Identity_Insert [dbo].[Tournaments] On; 
INSERT INTO [dbo].[Tournaments](
	id,
	guid,
	name,
	place,
	players_min,
	players_max,
	elo_min,
	elo_max,
	categories,
	status,
	women_only,
	end_registration
)VALUES(
	1,
	'3fa85f64-5717-4562-b3fc-2c963f66afa6',
	'Mon premier tournoi',
	'Quelque part en Belgique...',
	2,
	4,
	1050,
	2700,
	'senior,veteran',
	'waitingForPlayers',
	0,
	DATEADD(day,2,GETDATE())
);
Set Identity_Insert [dbo].[Tournaments] Off;
GO

Set Identity_Insert [dbo].[Registrations] On;
INSERT INTO [dbo].[Registrations](id, player_id, tournament_guid) VALUES
(1,1,'3fa85f64-5717-4562-b3fc-2c963f66afa6'),
(2,2,'3fa85f64-5717-4562-b3fc-2c963f66afa6'),
(3,4,'3fa85f64-5717-4562-b3fc-2c963f66afa6');
Set Identity_Insert [dbo].[Registrations] Off;
GO

Set Identity_Insert [dbo].[Matches] On;
INSERT INTO [dbo].[Matches](id, tournament_guid, white_id, black_id, [round], result) VALUES
(1,'3fa85f64-5717-4562-b3fc-2c963f66afa6',1,2,0,'notPlayed'),
(2,'3fa85f64-5717-4562-b3fc-2c963f66afa6',2,4,1,'notPlayed'),
(3,'3fa85f64-5717-4562-b3fc-2c963f66afa6',1,4,2,'notPlayed'),
(4,'3fa85f64-5717-4562-b3fc-2c963f66afa6',2,1,3,'notPlayed'),
(5,'3fa85f64-5717-4562-b3fc-2c963f66afa6',4,2,4,'notPlayed'),
(6,'3fa85f64-5717-4562-b3fc-2c963f66afa6',4,1,5,'notPlayed');
Set Identity_Insert [dbo].[Matches] Off;
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO

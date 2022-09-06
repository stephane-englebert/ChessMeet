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
USE [$(DatabaseName)];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_matches_result]...';


GO
ALTER TABLE [dbo].[Matches] DROP CONSTRAINT [CK_matches_result];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_members_birthdate]...';


GO
ALTER TABLE [dbo].[Members] DROP CONSTRAINT [CK_members_birthdate];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_members_elo]...';


GO
ALTER TABLE [dbo].[Members] DROP CONSTRAINT [CK_members_elo];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_members_gender]...';


GO
ALTER TABLE [dbo].[Members] DROP CONSTRAINT [CK_members_gender];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_members_role]...';


GO
ALTER TABLE [dbo].[Members] DROP CONSTRAINT [CK_members_role];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_tournaments_elo_max]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [CK_tournaments_elo_max];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_tournaments_elo_min]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [CK_tournaments_elo_min];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_tournaments_players_max]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [CK_tournaments_players_max];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_tournaments_players_min]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [CK_tournaments_players_min];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_tournaments_status]...';


GO
ALTER TABLE [dbo].[Tournaments] DROP CONSTRAINT [CK_tournaments_status];


GO
PRINT N'Suppression de Contrainte de validation [dbo].[CK_Matches_round]...';


GO
ALTER TABLE [dbo].[Matches] DROP CONSTRAINT [CK_Matches_round];


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_matches_result]...';


GO
ALTER TABLE [dbo].[Matches] WITH NOCHECK
    ADD CONSTRAINT [CK_matches_result] CHECK (result IN('notPlayed','whiteWin','blackWin','draw'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_birthdate]...';


GO
ALTER TABLE [dbo].[Members] WITH NOCHECK
    ADD CONSTRAINT [CK_members_birthdate] CHECK (birthdate BETWEEN '1920-01-01' AND GETDATE());


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_elo]...';


GO
ALTER TABLE [dbo].[Members] WITH NOCHECK
    ADD CONSTRAINT [CK_members_elo] CHECK (elo BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_gender]...';


GO
ALTER TABLE [dbo].[Members] WITH NOCHECK
    ADD CONSTRAINT [CK_members_gender] CHECK (gender IN ('male','female','other'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_members_role]...';


GO
ALTER TABLE [dbo].[Members] WITH NOCHECK
    ADD CONSTRAINT [CK_members_role] CHECK (role IN ('admin','player'));


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_elo_max]...';


GO
ALTER TABLE [dbo].[Tournaments] WITH NOCHECK
    ADD CONSTRAINT [CK_tournaments_elo_max] CHECK (elo_max BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_elo_min]...';


GO
ALTER TABLE [dbo].[Tournaments] WITH NOCHECK
    ADD CONSTRAINT [CK_tournaments_elo_min] CHECK (elo_min BETWEEN 0 AND 3000);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_players_max]...';


GO
ALTER TABLE [dbo].[Tournaments] WITH NOCHECK
    ADD CONSTRAINT [CK_tournaments_players_max] CHECK (players_max BETWEEN 2 AND 32);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_players_min]...';


GO
ALTER TABLE [dbo].[Tournaments] WITH NOCHECK
    ADD CONSTRAINT [CK_tournaments_players_min] CHECK (players_min BETWEEN 2 AND 32);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_tournaments_status]...';


GO
ALTER TABLE [dbo].[Tournaments] WITH NOCHECK
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
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Matches] WITH CHECK CHECK CONSTRAINT [CK_matches_result];

ALTER TABLE [dbo].[Members] WITH CHECK CHECK CONSTRAINT [CK_members_birthdate];

ALTER TABLE [dbo].[Members] WITH CHECK CHECK CONSTRAINT [CK_members_elo];

ALTER TABLE [dbo].[Members] WITH CHECK CHECK CONSTRAINT [CK_members_gender];

ALTER TABLE [dbo].[Members] WITH CHECK CHECK CONSTRAINT [CK_members_role];

ALTER TABLE [dbo].[Tournaments] WITH CHECK CHECK CONSTRAINT [CK_tournaments_elo_max];

ALTER TABLE [dbo].[Tournaments] WITH CHECK CHECK CONSTRAINT [CK_tournaments_elo_min];

ALTER TABLE [dbo].[Tournaments] WITH CHECK CHECK CONSTRAINT [CK_tournaments_players_max];

ALTER TABLE [dbo].[Tournaments] WITH CHECK CHECK CONSTRAINT [CK_tournaments_players_min];

ALTER TABLE [dbo].[Tournaments] WITH CHECK CHECK CONSTRAINT [CK_tournaments_status];


GO
PRINT N'Mise à jour terminée.';


GO

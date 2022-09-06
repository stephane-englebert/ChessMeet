﻿Set Identity_Insert [dbo].[Members] On;
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
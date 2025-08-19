﻿CREATE PROCEDURE [dbo].[spBookings_SearchBookings]
	@lastName nvarchar(50),
	@startDate date
AS
BEGIN 
	SET NOCOUNT ON

	SELECT [b].[Id], [b].[RoomId], [b].[GuestId], [b].[StartDate], [b].[EndDate], 
		[b].[IsCheckedIn], [b].[TotalPrice], [g].[FirstName], [g].[LastName], 
		[r].[RoomNumber], [r].[RoomTypeId], [rt].[Title], 
		[rt].[Description], [rt].[Price]
	FROM dbo.Bookings b
	INNER JOIN dbo.Guests g ON b.GuestId = g.Id
	INNER JOIN dbo.Rooms r on b.RoomId = r.Id
	INNER JOIN dbo.RoomTypes rt ON r.RoomTypeId = rt.Id
	WHERE g.LastName = @lastName AND b.StartDate = @startDate
END

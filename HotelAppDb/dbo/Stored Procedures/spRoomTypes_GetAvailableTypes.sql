CREATE PROCEDURE [dbo].[spRoomTypes_GetAvailableTypes]
	@startDate date,
	@endDate date
AS
BEGIN
	SET NOCOUNT ON

	SELECT rt.Id, rt.Title, rt.Description, rt.Price
	FROM dbo.Rooms r
	INNER JOIN dbo.RoomTypes rt ON rt.Id = r.RoomTypeId
	WHERE r.Id not in (
		SELECT b.RoomId
		FROM Bookings b
		WHERE (@startDate < b.StartDate and @endDate > b.EndDate)
			or (b.StartDate <= @endDate and @endDate < b.EndDate)
			or (b.StartDate <= @startDate and @startDate < b.EndDate)
	)
	GROUP BY rt.Id, rt.Title, rt.Description, rt.Price
END

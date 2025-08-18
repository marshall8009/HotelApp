CREATE PROCEDURE [dbo].[spRooms_GetAvailableRooms]
	@roomType int
AS
BEGIN
	SET NOCOUNT ON

	SELECT r.*
	FROM dbo.Rooms r
	INNER JOIN dbo.RoomTypes rt ON rt.Id = r.RoomTypeId
	WHERE r.RoomTypeId = @roomType
	AND r.IsBooked = 0
END

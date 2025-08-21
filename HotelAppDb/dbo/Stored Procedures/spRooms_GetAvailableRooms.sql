CREATE PROCEDURE [dbo].[spRooms_GetAvailableRooms]
	@roomTypeId int
AS
BEGIN
	SET NOCOUNT ON

	SELECT r.*
	FROM dbo.Rooms r
	INNER JOIN dbo.RoomTypes rt ON rt.Id = r.RoomTypeId
	WHERE r.RoomTypeId = @roomTypeId
END

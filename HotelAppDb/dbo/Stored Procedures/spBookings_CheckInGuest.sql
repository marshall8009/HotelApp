CREATE PROCEDURE [dbo].[spBookings_CheckInGuest]
	@id int
AS
BEGIN
	SET NOCOUNT ON

	UPDATE Bookings SET IsCheckedIn = 1 WHERE Id = @id
END

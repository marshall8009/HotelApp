CREATE PROCEDURE [dbo].[spBookings_Insert]
	@roomId int,
	@guestId int,
	@startDate date,
	@endDate date,
	@totalPrice money
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.Bookings (RoomId, GuestId, StartDate, EndDate, TotalPrice)
	VALUES(@roomId, @guestId, @startDate, @endDate, @totalPrice)
END

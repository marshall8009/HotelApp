CREATE PROCEDURE [dbo].[spGuests_InsertGuest]
	@firstName nvarchar(50),
	@lastname nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON
	
	IF NOT EXISTS (SELECT 1 FROM dbo.Guests WHERE FirstName = @firstName AND LastName = @lastname)
	BEGIN
		INSERT INTO dbo.Guests(FirstName, LastName)
		VALUES(@firstName, @lastname)
	END

	SELECT Id, FirstName, LastName
	FROM Guests
	WHERE FirstName = @firstName AND LastName = @lastname
END

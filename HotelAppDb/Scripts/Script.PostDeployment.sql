/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS (SELECT 1 FROM dbo.RoomTypes)
BEGIN
    INSERT INTO dbo.RoomTypes(Title, Description, Price)
    VALUES ('Standard Room King Bed', 'Our standard room with a king bed and a window.', 100),
    ('Standard Room Queen Bed', 'Our standard room with a queen bed and a window.', 80),
    ('Signature Room 2 King Beds', 'Our signature room with 2 king beds and a window overlooking the courtyard.', 135),
    ('Signature Room 2 Queen Beds', 'Our signature room with 2 queen beds and a window overlooking the courtyard.', 110),
    ('Deluxe Room Queen Bed Mountain View', 'Our deluxe room with a queen bed and a balcony with a mountain view.', 160),
    ('Deluxe Room King Bed Mountain View', 'Our deluxe room with a king bed and a balcony with a mountain view.', 180),
    ('Executive Suite Beach View', 'Our executive suite with 2 bedrooms, each with a king bed and a beach view.', 300)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Rooms)
BEGIN
    DECLARE @roomdId1 int;
    DECLARE @roomdId2 int;
    DECLARE @roomdId3 int;
    DECLARE @roomdId4 int;
    DECLARE @roomdId5 int;
    DECLARE @roomdId6 int;
    DECLARE @roomdId7 int;

    SELECT @roomdId1 = Id FROM dbo.RoomTypes WHERE Title = 'Standard Room King Bed';
    SELECT @roomdId2 = Id FROM dbo.RoomTypes WHERE Title = 'Standard Room Queen Bed';
    SELECT @roomdId3 = Id FROM dbo.RoomTypes WHERE Title = 'Signature Room 2 King Beds';
    SELECT @roomdId4 = Id FROM dbo.RoomTypes WHERE Title = 'Signature Room 2 Queen Beds';
    SELECT @roomdId5 = Id FROM dbo.RoomTypes WHERE Title = 'Deluxe Room Queen Bed Mountain View';
    SELECT @roomdId6 = Id FROM dbo.RoomTypes WHERE Title = 'Deluxe Room King Bed Mountain View';
    SELECT @roomdId7 = Id FROM dbo.RoomTypes WHERE Title = 'Executive Suite Beach View';

    INSERT INTO dbo.Rooms(RoomNumber, RoomTypeId)
    VALUES ('101', @roomdId1),
    ('102', @roomdId1),
    ('103', @roomdId1),
    ('201', @roomdId2),
    ('202', @roomdId2),
    ('301', @roomdId3)
END
using HotelAppLibrary.DataAccess;
using HotelAppLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelAppLibrary.Business
{
    public class SqlData : IDatabaseData
    {
        private readonly ISqlDataAccess _db;
        private const string connectionStringName = "SqlDb";

        public SqlData(ISqlDataAccess db)
        {
            _db = db;
        }

        public void CheckInGuest(int id)
        {
            _db.SaveData("dbo.spBookings_CheckInGuest",
                         new { id },
                         connectionStringName,
                         true);
        }

        public List<BookingModel> SearchBookings(string lastName)
        {
            return _db.LoadData<BookingModel, dynamic>("dbo.spBookings_SearchBookings",
                                                       new { lastName, startDate = DateTime.Now.Date },
                                                       connectionStringName,
                                                       true);
        }

        public List<RoomTypeModel> GetAvailableRoomTypes(DateTime startDate, DateTime endDate)
        {
            return _db.LoadData<RoomTypeModel, dynamic>("dbo.spRoomTypes_GetAvailableTypes",
                                                        new { startDate, endDate },
                                                        connectionStringName,
                                                        true);
        }

        public void BookGuest(string firstName, string lastName, DateTime startDate, DateTime endDate, int roomTypeId)
        {
            var guest = InsertGuest(firstName, lastName);

            var roomType = GetAvailableRoomTypes(roomTypeId);
            // TODO: refactor this into it's own calc method
            var test = endDate.Date.Subtract(startDate.Date).Days;

            var availableRooms = GetAvailableRoomsByRoomType(roomTypeId);

            _db.SaveData("dbo.spBookings_Insert",
                                        new
                                        {
                                            roomId = availableRooms.First().Id,
                                            guest.Id,
                                            startDate,
                                            endDate,
                                            totalPrice = test * roomType.Price
                                        },
                                        connectionStringName,
                                        true);
        }

        // TODO: refactor sql statement into it's own SP
        private RoomTypeModel GetAvailableRoomTypes(int roomTypeId)
        {
            var roomType = _db.LoadData<RoomTypeModel, dynamic>("SELECT * FROM RoomTypes WHERE Id = @Id",
                                                                new { roomTypeId },
                                                                connectionStringName,
                                                                false).First();

            return roomType;
        }

        private List<RoomModel> GetAvailableRoomsByRoomType(int roomTypeId)
        {
            var rooms = _db.LoadData<RoomModel, dynamic>("dbo.spRooms_GetAvailableRooms",
                                                        new { roomTypeId },
                                                        connectionStringName,
                                                        true);

            return rooms;
        }

        private GuestModel InsertGuest(string firstName, string lastName)
        {
            var guest = _db.LoadData<GuestModel, dynamic>("dbo.spGuests_InsertGuest",
                                        new { firstName, lastName },
                                        connectionStringName,
                                        true).First();

            return guest;
        }
    }
}

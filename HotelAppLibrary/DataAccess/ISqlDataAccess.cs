﻿
namespace HotelAppLibrary.DataAccess
{
    public interface ISqlDataAccess
    {
        List<T> LoadData<T, U>(string sqlStatement, U parameters, string connectionStringName, bool isStoredProc = false);
        void SaveData<T>(string sqlStatement, T parameters, string connectionStringName, bool isStoredProc = false);
    }
}
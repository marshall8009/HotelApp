using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using System.Linq;
using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace HotelAppLibrary.DataAccess
{
    public class SqlDataAccess : ISqlDataAccess
    {
        private readonly IConfiguration _config;

        public SqlDataAccess(IConfiguration config)
        {
            _config = config;
        }

        public List<T> LoadData<T, U>(string sqlStatement, U parameters, string connectionStringName, bool isStoredProc = false)
        {
            string connectionString = _config.GetConnectionString(connectionStringName);
            CommandType commandType = GetSqlCommandType(isStoredProc);

            using (IDbConnection conn = new SqlConnection(connectionString))
            {
                List<T> rows = conn.Query<T>(sqlStatement, parameters, commandType: commandType).ToList();

                return rows;
            }
        }

        public void SaveData<T>(string sqlStatement, T parameters, string connectionStringName, bool isStoredProc = false)
        {
            string connectionString = _config.GetConnectionString(connectionStringName);
            CommandType commandType = GetSqlCommandType(isStoredProc);

            using (IDbConnection conn = new SqlConnection(connectionString))
            {
                conn.Execute(sqlStatement, parameters, commandType: commandType);
            }
        }

        public CommandType GetSqlCommandType(bool isStoredProc)
        {
            CommandType commandType = CommandType.Text;

            if (isStoredProc)
            {
                commandType = CommandType.StoredProcedure;
            }

            return commandType;
        }
    }
}

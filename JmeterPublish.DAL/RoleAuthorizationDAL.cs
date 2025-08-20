
namespace JmeterPublish.DAL
{
    using System;
    using System.Text;
    using System.Data;
    using System.Data.Common;
    using JmeterPublish.Models;
    using EncrypDecrypt;
    using Newtonsoft.Json;
    using Npgsql;
    using NpgsqlTypes;
    using Newtonsoft.Json.Linq;


    //This code generated from Deliveries Powered by Mahat, Source Machine : 15.206.208.9 , Build Number : Build 14092021 #2021-09-014(Updated on 29102021 12:49) on 08/17/2023 06:22:48
    public class RoleAuthorizationDAL
    {
        public virtual string db_connectionstring { get; set; }
        public RoleAuthorizationDAL(string connectionString)
        {
            db_connectionstring = connectionString;
        }

       public virtual System.Data.DataTable get_all_parentname()
        {
            DataTable dataTable = new DataTable();
            DataSet dataSet = new DataSet();
            try
            {

                using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
                {
                    npsql.Open();
                    using (var dbCommand = new NpgsqlCommand("\"get_all_parentname\"", npsql))
                    {
                        dbCommand.CommandType = CommandType.StoredProcedure;

                        using (NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(dbCommand))
                        {
                            dataSet.Reset();
                            dataAdapter.Fill(dataSet);
                            dataTable = dataSet.Tables[0];
                            if (dbCommand.Connection.State != ConnectionState.Closed)
                            {
                                dbCommand.Connection.Dispose();
                            }
                        }
                    }
                    npsql.Close();
                }


            }
            catch
            {
                throw;
            }

            return dataTable;


        }

        public virtual System.Data.DataTable get_all_roles()
        {
            DataTable dataTable = new DataTable();
            DataSet dataSet = new DataSet();
            try
            {

                using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
                {
                    npsql.Open();
                    using (var dbCommand = new NpgsqlCommand("\"get_all_roles\"", npsql))
                    {
                        dbCommand.CommandType = CommandType.StoredProcedure;

                        using (NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(dbCommand))
                        {
                            dataSet.Reset();
                            dataAdapter.Fill(dataSet);
                            dataTable = dataSet.Tables[0];
                            if (dbCommand.Connection.State != ConnectionState.Closed)
                            {
                                dbCommand.Connection.Dispose();
                            }
                        }
                    }
                    npsql.Close();
                }


            }
            catch
            {
                throw;
            }

            return dataTable;


        }
        public virtual System.Data.DataTable prefill_RoleAuthorization_roleauthorized(string userrole)
        {
            RoleAuthorizationModel obj = new RoleAuthorizationModel();

            string clone = obj.clone;
            DataTable dataTable = new DataTable();
            DataSet dataSet = new DataSet();
            try
            {


                using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
                {
                    npsql.Open();
                    using (var dbCommand = new NpgsqlCommand("\"prefill_RoleAuthorization_roleauthorized\"", npsql))
                    {
                        dbCommand.CommandType = CommandType.StoredProcedure;
                        dbCommand.Parameters.AddWithValue("pvar_userrole", (object)userrole ?? DBNull.Value);
                        using (NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(dbCommand))
                        {
                            dataSet.Reset();
                            dataAdapter.Fill(dataSet);
                            dataTable = dataSet.Tables[0];
                            if (dbCommand.Connection.State != ConnectionState.Closed)
                            {
                                dbCommand.Connection.Dispose();
                            }
                        }
                    }
                    npsql.Close();
                }


            }
            catch (Exception ex)
            {
                throw;
            }

            return dataTable;


        }

        public virtual string Update_RoleAuthorization(RoleAuthorizationModel model)
        {

            String ResponseMessage = "";
            try
            {
                var obj = JsonConvert.SerializeObject(model.roleauthorized);

                using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
                {
                    npsql.Open();
                    using (var dbCommand = new NpgsqlCommand("\"Update_RoleAuthorization\"", npsql))
                    {
                        dbCommand.CommandType = CommandType.StoredProcedure;

                        dbCommand.Parameters.AddWithValue("pvar_roleauthorizationid", NpgsqlDbType.Uuid, (object)model.RoleAuthorizationid ?? DBNull.Value);

                        dbCommand.Parameters.AddWithValue("pvar_userrole", NpgsqlDbType.Varchar, (object)model.userrole ?? DBNull.Value);
                        dbCommand.Parameters.AddWithValue("pvar_modifieduser", NpgsqlDbType.Uuid, (object)model.createduser ?? DBNull.Value); if (model.roleauthorized != null && model.roleauthorized.Count > 0)
                            dbCommand.Parameters.AddWithValue("pvar_roleauthorized", NpgsqlDbType.Json, JsonConvert.SerializeObject(model.roleauthorized));
                        else
                            dbCommand.Parameters.AddWithValue("pvar_roleauthorized", NpgsqlDbType.Json, DBNull.Value);

                        NpgsqlParameter outParm = new NpgsqlParameter("pvar_returnMessage", NpgsqlDbType.Varchar)
                        {
                            Direction = ParameterDirection.Output
                        };
                        dbCommand.Parameters.Add(outParm); ;

                        dbCommand.ExecuteNonQuery();
                        ResponseMessage = outParm.Value.ToString();
                        if (dbCommand.Connection.State != ConnectionState.Closed)
                        {
                            dbCommand.Connection.Dispose();
                        }

                    }
                    npsql.Close();
                }


            }
            catch (Exception ex)
            {
                ResponseMessage = ex.Message;
                Console.WriteLine(ex);
            }

            return ResponseMessage;

        }
        public virtual string Add_Role(AddRoleModel model)
        {
            String ResponseMessage = "";

            try
            {

                using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
                {
                    npsql.Open();
                    using (var dbCommand = new NpgsqlCommand("\"Add_Role\"", npsql))
                    {
                        dbCommand.CommandType = CommandType.StoredProcedure;

                        dbCommand.Parameters.AddWithValue("pvar_rolesid", NpgsqlDbType.Uuid, (object)model.rolesid ?? DBNull.Value);

                        dbCommand.Parameters.AddWithValue("pvar_rolename", NpgsqlDbType.Varchar, (object)model.rolename ?? DBNull.Value);
                        dbCommand.Parameters.AddWithValue("pvar_rolegroupname", NpgsqlDbType.Varchar, (object)model.rolegroupname ?? DBNull.Value);
                        dbCommand.Parameters.AddWithValue("pvar_parentname", NpgsqlDbType.Varchar, (object)model.parentname ?? DBNull.Value);
                        dbCommand.Parameters.AddWithValue("pvar_clone", NpgsqlDbType.Varchar, (object)model.clone ?? DBNull.Value);

                        NpgsqlParameter outParm = new NpgsqlParameter("pvar_returnMessage", NpgsqlDbType.Varchar)
                        {
                            Direction = ParameterDirection.Output
                        };
                        dbCommand.Parameters.Add(outParm); ;

                        dbCommand.ExecuteNonQuery();
                        ResponseMessage = outParm.Value.ToString();
                        if (dbCommand.Connection.State != ConnectionState.Closed)
                        {
                            dbCommand.Connection.Dispose();
                        }

                    }
                    npsql.Close();
                }


            }
            catch (Exception ex)
            {
                ResponseMessage = ex.Message;
                Console.WriteLine(ex);
            }

            return ResponseMessage;

        }
      

    }

}

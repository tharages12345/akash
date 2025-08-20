namespace JmeterPublish.DAL{
			    using System;
			    using System.Text;
			    using System.Data;
			    using System.Data.Common;
			    using JmeterPublish.Models;
			    using EncrypDecrypt;
			    using Newtonsoft.Json;
				using Newtonsoft.Json.Linq;
                using Npgsql;
				using NpgsqlTypes;
				using System.Text.RegularExpressions;

			    //This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:56
			    public class AlertTemplatesDAL
			    {
					public virtual string db_connectionstring{get;set;}
					
			 	    public AlertTemplatesDAL(string connectionString)
				    {
						
					    db_connectionstring=connectionString;
				    }
				  
			        
              public virtual string Create_Alert_Templates(AlertTemplatesModel model)
			  { 
				  String ResponseMessage="";
					 
					try{
							 
                            using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
					        {
						        npsql.Open();
						        using (var dbCommand = new NpgsqlCommand("\"Create_Alert_Templates\"", npsql))
						        {
                                        dbCommand.CommandType = CommandType.StoredProcedure;
						            	
								        					dbCommand.Parameters.AddWithValue("pvar_alerttemplatesid",NpgsqlDbType.Uuid,(object)model.AlertTemplatesid??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_entityname",NpgsqlDbType.Varchar,(object)model.entityname??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_entityaction",NpgsqlDbType.Varchar,(object)model.entityaction??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_sendasbatch",NpgsqlDbType.Boolean,(object)model.sendasbatch??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alerttype",NpgsqlDbType.Varchar,(object)model.alerttype??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertsubject",NpgsqlDbType.Varchar,(object)model.alertsubject??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcopyto",NpgsqlDbType.Varchar,(object)model.alertcopyto??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcarboncopyto",NpgsqlDbType.Varchar,(object)model.alertcarboncopyto??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcontent",NpgsqlDbType.Varchar,(object)model.alertcontent??DBNull.Value);
dbCommand.Parameters.AddWithValue("pvar_createduser",NpgsqlDbType.Uuid,(object)model.createduser??DBNull.Value);	
					
                                        NpgsqlParameter outParm = new NpgsqlParameter("pvar_returnMessage", NpgsqlDbType.Varchar)
                                        {
                                             Direction = ParameterDirection.Output
                                        };
                                        dbCommand.Parameters.Add(outParm);

                                        dbCommand.ExecuteNonQuery();
								        ResponseMessage = outParm.Value.ToString();
								        if (dbCommand.Connection.State != ConnectionState.Closed)
                    			        {
										         dbCommand.Connection.Dispose();
								        }

						        }
						        npsql.Close();
					        }
 

					}catch(Exception ex){
						ResponseMessage=ex.Message;
						Console.WriteLine(ex);
					} 
					
					return ResponseMessage;

			   }
public virtual AlertTemplatesModel getById_AlertTemplates(string AlertTemplatesid)
									 {
										DataTable dataTable = new DataTable();
										DataSet dataSet = new DataSet();
										try{
												 
												using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
												{
													npsql.Open();
													using (var dbCommand = new NpgsqlCommand("\"getById_sp_AlertTemplates\"", npsql))
													{
														dbCommand.CommandType = CommandType.StoredProcedure;
														dbCommand.Parameters.AddWithValue("pvar_alerttemplatesid",(object)AlertTemplatesid??DBNull.Value);
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
					 
										}catch{
												throw;
										}
										if (dataTable.Rows.Count > 0)
										{
											DataRow row = dataTable.Rows[0];
											return ModelConverter.ConvertDataRowToModel<AlertTemplatesModel>(row);
										}
										else
										{
											return null;
										}
									 }
			 public virtual string  Update_Alert_Templates(AlertTemplatesModel model)
			 { 
				 String ResponseMessage="";
					try{
						 	 
							using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
							{
								npsql.Open();
								using (var dbCommand = new NpgsqlCommand("\"Update_Alert_Templates\"", npsql))
								{
										dbCommand.CommandType = CommandType.StoredProcedure;
															dbCommand.Parameters.AddWithValue("pvar_alerttemplatesid",NpgsqlDbType.Uuid,(object)model.AlertTemplatesid??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_entityname",NpgsqlDbType.Varchar,(object)model.entityname??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_entityaction",NpgsqlDbType.Varchar,(object)model.entityaction??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_sendasbatch",NpgsqlDbType.Boolean,(object)model.sendasbatch??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alerttype",NpgsqlDbType.Varchar,(object)model.alerttype??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertsubject",NpgsqlDbType.Varchar,(object)model.alertsubject??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcopyto",NpgsqlDbType.Varchar,(object)model.alertcopyto??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcarboncopyto",NpgsqlDbType.Varchar,(object)model.alertcarboncopyto??DBNull.Value);

dbCommand.Parameters.AddWithValue("pvar_alertcontent",NpgsqlDbType.Varchar,(object)model.alertcontent??DBNull.Value);
dbCommand.Parameters.AddWithValue("pvar_modifieduser",NpgsqlDbType.Uuid,model.modifieduser);	
										NpgsqlParameter outParm = new NpgsqlParameter("@returnMessage", NpgsqlDbType.Varchar)
										{
											 Direction = ParameterDirection.Output
										};
										dbCommand.Parameters.Add(outParm);

										dbCommand.ExecuteNonQuery();
										ResponseMessage = outParm.Value.ToString();
										if (dbCommand.Connection.State != ConnectionState.Closed)
										{
												 dbCommand.Connection.Dispose();
										}

								}
								npsql.Close();
							}		 

					}catch(Exception ex){
						ResponseMessage=ex.Message;
					}
					
					return ResponseMessage;

			   }
public virtual string  Remove_Alert_Templates(string id,string loginUserID)
			  { 
				  String ResponseMessage="";
					try{ 
							using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
							{
								npsql.Open();
								using (var dbCommand = new NpgsqlCommand("\"Remove_Alert_Templates\"", npsql))
								{
										dbCommand.CommandType = CommandType.StoredProcedure;
										dbCommand.Parameters.AddWithValue("pvar_alerttemplatesid",(object)id??DBNull.Value);
										dbCommand.Parameters.AddWithValue("pvar_modifieduser",(object)loginUserID??DBNull.Value);
										NpgsqlParameter outParm = new NpgsqlParameter("@returnMessage", NpgsqlDbType.Varchar)
										{
											 Direction = ParameterDirection.Output
										};
										dbCommand.Parameters.Add(outParm);

										dbCommand.ExecuteNonQuery();
										ResponseMessage = outParm.Value.ToString();
										if (dbCommand.Connection.State != ConnectionState.Closed)
										{
												 dbCommand.Connection.Dispose();
										}

								}
								npsql.Close();
							}	 

					}catch(Exception ex){
						ResponseMessage=ex.Message;
					}
					
					return ResponseMessage;

			   }
public virtual System.Data.DataTable Alert_Templates_List(string entityname
,string entityaction
,string alerttype
)
			  { 
					DataTable dataTable = new DataTable();
                DataSet dataSet = new DataSet(); 

					try{
 
							using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
							{
								npsql.Open();
								using (var dbCommand = new NpgsqlCommand("\"Alert_Templates_List\"", npsql))
								{
									dbCommand.CommandType = CommandType.StoredProcedure;
									dbCommand.Parameters.AddWithValue("pvar_entityname",(object)entityname??DBNull.Value);
dbCommand.Parameters.AddWithValue("pvar_entityaction",(object)entityaction??DBNull.Value);
dbCommand.Parameters.AddWithValue("pvar_alerttype",(object)alerttype??DBNull.Value);

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

						 

					}catch{
						throw;
					}


					return dataTable;	


					 

			   }
			   
			 
public virtual System.Data.DataTable get_all_AlertTemplates(string tenantid)
			  { 

				    DataTable dataTable = new DataTable();
					DataSet dataSet = new DataSet();

					try{
 
							using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
							{
								npsql.Open();
								using (var dbCommand = new NpgsqlCommand("\"get_all_AlertTemplates\"", npsql))
								{
									dbCommand.CommandType = CommandType.StoredProcedure;
									dbCommand.Parameters.AddWithValue("pvar_tenantid",(object)tenantid??DBNull.Value);
									
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
						

					}catch{
						throw;
					}
					return dataTable;	


					 

			   }
public virtual System.Data.DataTable getById_allinfo_AlertTemplates(string AlertTemplatesid)
			 {
				DataSet dataSet=new DataSet();
				DataTable dataTable = new DataTable();
				try{
					     
						using (NpgsqlConnection npsql = new NpgsqlConnection(db_connectionstring))
						{
							npsql.Open();
							using (var dbCommand = new NpgsqlCommand("\"getById_sp_all_AlertTemplates\"", npsql))
							{
								dbCommand.CommandType = CommandType.StoredProcedure;
								dbCommand.Parameters.AddWithValue("pvar_alerttemplatesid",(object)AlertTemplatesid??DBNull.Value);
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
					 
				}catch{
						throw;
				}
				return dataTable;
			 }
			  







			    }


			    }

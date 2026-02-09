using System.Data;
using MySql.Data.MySqlClient;

namespace PokeDex.DataAccessLibrary;

public class SqlDataAccess
{
    private readonly string mySqlConnectionString;
    
    public SqlDataAccess()
    {
        mySqlConnectionString = "Server=localhost; Database=pokedex; Uid=root; Pwd=root;";
    }

    public DataTable Query(string query, Dictionary<string, object>? parameters = null)
    {
        DataTable dt = new DataTable();
        using (MySqlConnection conn = new MySqlConnection(mySqlConnectionString))
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand(query, conn);

            if (parameters != null)
            {
                foreach (KeyValuePair<string, object> parameter in parameters)
                {
                    cmd.Parameters.AddWithValue(parameter.Key, parameter.Value);
                }
            }
            
            using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
            {
                adapter.Fill(dt);
            }
            
            conn.Close();
        }
        return dt;
    }

    public void ExecuteNonQuery(string query, Dictionary<string, object>? parameters = null)
    {
        using (MySqlConnection conn = new MySqlConnection(mySqlConnectionString))
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand(query, conn);

            if (parameters != null)
            {
                foreach (KeyValuePair<string, object> parameter in parameters)
                {
                    cmd.Parameters.AddWithValue(parameter.Key, parameter.Value);
                }
            }

            cmd.ExecuteNonQuery();
            
            conn.Close();
            
        }

    }
}
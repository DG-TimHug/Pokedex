using System.Data;

namespace PokeDex.DataAccessLibrary;

public class TypedexData
{
    private readonly SqlDataAccess sqlDataAccess;
    
    public TypedexData(SqlDataAccess sqlDataAccess)
    {
        this.sqlDataAccess = sqlDataAccess;
    }

    public DataTable GetAllTypes()
    {
        string sqlQuery = "SELECT `Name`,`Abbreviation`,`Slug` FROM `pokedex`.`Type` ORDER BY `Name`";
        return sqlDataAccess.Query(sqlQuery);
    }
    
    public DataTable GetPokemonType(int localId)
    {
        string sqlQuery = @"
        SELECT 
            t.Slug,
            t.Name,
            t.Abbreviation
        FROM PokemonType pt
        JOIN Type t ON pt.TypeSlug = t.Slug
        WHERE pt.PokemonId = @id;";

        var parameters = new Dictionary<string, object>
        {
            { "@id", localId }
        };

        return sqlDataAccess.Query(sqlQuery, parameters);
    }
    
    public DataTable GetPokemonByType(string? slug)
    {
        string sql = @"
        SELECT p.Id, p.Name, p.ImagePath
        FROM PokemonType pt
        JOIN Pokemon p ON pt.PokemonId = p.Id
        WHERE pt.TypeSlug = @slug;
    ";

        return sqlDataAccess.Query(sql, new Dictionary<string, object>
        {
            { "@slug", slug!}
        });
    }

    public string? GetTypeNameBySlug(string slug)
    {
        string sql = "SELECT Name FROM Type WHERE Slug = @slug;";

        var result = sqlDataAccess.Query(sql, new Dictionary<string, object>
        {
            { "@slug", slug }
        });

        if (result.Rows.Count == 0)
            return null;

        return result.Rows[0]["Name"].ToString();
    }

}
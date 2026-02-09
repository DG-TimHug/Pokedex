using System.Data;

namespace PokeDex.DataAccessLibrary;

public class PokedexData
{
    
    private readonly SqlDataAccess sqlDataAccess;
    
    public PokedexData(SqlDataAccess sqlDataAccess)
    {
        this.sqlDataAccess = sqlDataAccess;
    }

    public DataTable GetAllPokemon()
    {
        string sqlQuery = "SELECT Id, Name, ImagePath,EvoCond FROM Pokemon ORDER BY Id;";

        return sqlDataAccess.Query(sqlQuery);
    }
    
    public DataTable GetCertainPokemon(int localId)
    {

        string sqlQuery = "SELECT Id, Name, ImagePath,EvoCond FROM Pokemon WHERE Id = @id;";

        var parameters = new Dictionary<string, object>
        {
            { "@id", localId }
        };

        return sqlDataAccess.Query(sqlQuery, parameters);
    }

    public DataTable GetPokemonByNameOrNumber(string? nameOrNumber)
    {
        string sqlQuery = @"
        SELECT Id, Name, ImagePath, EvoCond AS EvolutionCondition FROM pokedex.Pokemon WHERE Id = @number OR Name LIKE @name;";

        int number = -1;

        int.TryParse(nameOrNumber, out number);

        var parameters = new Dictionary<string, object>
        {
            { "@number", number },
            { "@name", "%" + (nameOrNumber ?? "") + "%" }
        };

        return sqlDataAccess.Query(sqlQuery, parameters);
    }
    
    public DataTable GetPokemonEvo(int localId)
    {
        string sqlQuery = @"
        SELECT 
            pe.FromPokemonId,
            pe.ToPokemonId,
            pf.Name AS PokemonFromName,
            pt.Name AS PokemonToName
        FROM PokemonEvolution pe
        JOIN Pokemon pf ON pe.FromPokemonId = pf.Id
        JOIN Pokemon pt ON pe.ToPokemonId = pt.Id
        WHERE pe.FromPokemonId = @id 
           OR pe.ToPokemonId = @id;";

        var parameters = new Dictionary<string, object>
        {
            { "@id", localId }
        };

        return sqlDataAccess.Query(sqlQuery, parameters);
    }
    
    public void CreatePokemon(int id, string name, string imagePath, string? evoCond)
    {
        string sql = @"
        INSERT INTO Pokemon (Id, Name, ImagePath, EvoCond)
        VALUES (@id, @name, @imagePath, @evoCond);
    ";

        var parameters = new Dictionary<string, object>
        {
            { "@id", id },
            { "@name", name },
            { "@imagePath", imagePath },
            { "@evoCond", evoCond ?? "" }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }

    
    public void AddPokemonType(int pokemonId, string typeSlug)
    {
        string sql = @"
        INSERT INTO PokemonType (PokemonId, TypeSlug)
        VALUES (@id, @slug);
    ";

        var parameters = new Dictionary<string, object>
        {
            { "@id", pokemonId },
            { "@slug", typeSlug }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }

    
    public void AddPokemonEvolution(int previousId,int nextId)
    {
        string sql = @"
        INSERT INTO PokemonEvolution (FromPokemonId, ToPokemonId)
        VALUES (@prevId, @nextId);
    ";

        var parameters = new Dictionary<string, object>
        {
            { "@prevId", previousId },
            { "@nextId", nextId }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }
    
    public void DeletePokemon(int Id)
    {
        string sql = @"DELETE FROM pokemon WHERE Id = @Id;";

        var parameters = new Dictionary<string, object>
        {
            { "@Id", Id }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }
    
    
    public void UpdatePokemon(int id, string name, string imagePath, string? evoCond)
    {
        string sql = @"
        UPDATE Pokemon 
        SET Name = @name, 
            ImagePath = @imagePath, 
            EvoCond = @evoCond
        WHERE Id = @id;
    ";

        var parameters = new Dictionary<string, object>
        {
            { "@id", id },
            { "@name", name },
            { "@imagePath", imagePath },
            { "@evoCond", evoCond ?? "" }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }

    public void DeletePokemonTypes(int pokemonId)
    {
        string sql = @"DELETE FROM PokemonType WHERE PokemonId = @id;";

        var parameters = new Dictionary<string, object>
        {
            { "@id", pokemonId }
        };

        sqlDataAccess.ExecuteNonQuery(sql, parameters);
    }
}
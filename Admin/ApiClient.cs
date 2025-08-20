
using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

using JmeterPublish.Models;
public static class ApiClient
{ 
    public static async Task<response_model> Post_ApiValuesGetResponseModel<T>(this HttpClient client, string requestUri, T value)
    {
        string JsonString;
        HttpResponseMessage response = await client.PostAsJsonAsync(requestUri, value);

        Console.WriteLine(response.Content);
        var message = await response.Content.ReadAsAsync<response_model>();
        Console.WriteLine(message);
        if (response.IsSuccessStatusCode)
        {
            JsonString = message.message;
        }
        else if (response.StatusCode == HttpStatusCode.Unauthorized)
        {
            JsonString = "API Authorization failed : " + message.message;
        }
        else if (response.StatusCode == HttpStatusCode.NotFound)
        {
            JsonString = "API Method NotFound : " + message.message;
        }
        else if (response.StatusCode == HttpStatusCode.BadRequest)
        {
            JsonString = "BadRequest : " + message.message;
        }
        else
        {
            JsonString = "Response Failed : " + message.message;
        }
        return message;
    }
    public static async Task<string> Post_ApiValuesGetString<T>(this HttpClient client, string requestUri, T value)
    {
        string JsonString;
        HttpResponseMessage response = await client.PostAsJsonAsync(requestUri, value);
        string message = await response.Content.ReadAsAsync<string>();
        if (response.IsSuccessStatusCode)
        {
            JsonString = message;
        }
        else if (response.StatusCode == HttpStatusCode.Unauthorized)
        {
            JsonString = "API Authorization failed : " + message;
        }
        else if (response.StatusCode == HttpStatusCode.NotFound)
        {
            JsonString = "API Method NotFound : " + message;
        }
        else if (response.StatusCode == HttpStatusCode.BadRequest)
        {
            JsonString = "BadRequest : " + message;
        }
        else
        {
            JsonString = "Response Failed : " + message;
        }
        return JsonString;
    }
    public static async Task<HttpResponseMessage> Post_ApiValuesGetRespnse<T>(this HttpClient client, string requestUri, T value)
    {
        HttpResponseMessage response = await client.PostAsJsonAsync(requestUri, value);
        return response;
    }
    public static async Task<HttpResponseMessage> GET_ApiValuesGetRespnse(HttpClient client, string url)
    {
        HttpResponseMessage response = await client.GetAsync(url);
        return response;
    }
    public static async Task<string> Get_ApiValues(HttpClient client, string url)
    {
        string JsonString;
        try
        {
            HttpResponseMessage response = await client.GetAsync(url);
            if (response.IsSuccessStatusCode)
            {
                JsonString = await response.Content.ReadAsStringAsync();
            }
            else if (response.StatusCode == HttpStatusCode.Unauthorized)
            {
                JsonString = "API Authorization failed";
            }
            else if (response.StatusCode == HttpStatusCode.NotFound)
            {
                JsonString = "API Method NotFound";
            }
            else
            {
                JsonString = response.StatusCode.ToString() + " " + response.ReasonPhrase;
            }
        }
        catch (Exception ex)
        {
            JsonString = "Client Exception " + ex.Message;
        }
        return JsonString;
    }
}



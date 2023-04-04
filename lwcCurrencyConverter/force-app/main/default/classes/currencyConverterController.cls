public class currencyConverterController 
{
	@AuraEnabled(cacheable=true)
    public static double getConversion(String amount, String convertFrom, String convertTo)
    {
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = 'https://api.exchangerate.host/convert?from='+convertFrom + '&to=' + convertTo + '&amount='+amount;
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        map<String, Object> responseMap = new map<String, Object>();
        return (Double)responseMap.get('result');
    }
    
    @AuraEnabled(cacheable=true)
    public static map<String, Object> getCodes()
    {   Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.exchangerate.host/symbols');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        map<String, Object> responseMap = new map<String, Object>();
        responseMap = (map<String, Object>) JSON.deserializeUntyped(res.getBody());
        map<String, Object> symbolMap = (map<String, Object>)(responseMap.get('symbols'));
        return symbolMap;
    }
}
public class ApexRestCalloutDemo {
    public static void getUserFromExternalSystem(){
        Http httpobj = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://reqres.in/api/user');
        req.setHeader('content-Type','application/json');
        req.setMethod('GET');
        //req.setBody('');
        HTTPResponse res = new HTTPResponse();
        res = httpobj.send(req);
        
        system.debug('@@@'+res.getBody());
        
    }
}
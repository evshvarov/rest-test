Class Community.TestREST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/all" Method="GET" Call="GetAllTests"/>
<Route Url="/:id" Method="GET" Call="GetTest"/>
<Route Url="/:id" Method="PUT" Call="UpdateTest"/>
<Route Url="/:id" Method="DELETE" Call="DeleteTest"/>
<Route Url="/" Method="POST" Call="CreateTest"/>
</Routes>
}

ClassMethod GetAllTests() As %Status
{

    #dim tSC As %Status = $$$OK

    Set rset = ##class(Community.Test).ExtentFunc()

    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    While rset.%Next() {   
        Set Test = ##class(Community.Test).%OpenId(rset.ID)    
        Do Test.%JSONExport()
        Write ","

    }
    Write "]"
    Quit tSC
}

ClassMethod GetTest(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException


    #; Set the response header to plain text
    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set Test = ##class(Community.Test).%OpenId(id)

    If '$IsObject(Test) Quit ..Http404()

    Do Test.%JSONExport()

    Quit tSC
}

ClassMethod CreateTest() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set Test = ##class(Community.Test).%New()
    Set data = {}.%FromJSON(%request.Content)


    $$$TOE(tSC,Test.%JSONImport(data))
    $$$TOE(tSC,Test.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    //d data.%ToJSON()
    Do Test.%JSONExport()

    Quit tSC
}

ClassMethod UpdateTest(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set Test = ##class(Community.Test).%OpenId(id)
    If '$IsObject(Test) Return ..Http404()
    Set data = {}.%FromJSON(%request.Content)


    $$$TOE(tSC,Test.%JSONImport(data))
    $$$TOE(tSC,Test.%Save())

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do Test.%JSONExport()

    Quit tSC
}

ClassMethod DeleteTest(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set Test = ##class(Community.Test).%OpenId(id)
    If '$IsObject(Test) Return ..Http404()

    $$$TOE(tSC,Test.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

}

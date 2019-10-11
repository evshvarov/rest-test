Class Community.Test Extends (%Persistent, %Populate, %JSON.Adaptor)
{

Property Data As %String;

Property Day As %Date;

ClassMethod AddTestData(amount As %Integer)
{
    d ..Populate(amount)
}

Storage Default
{
<Data name="TestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Data</Value>
</Value>
<Value name="3">
<Value>Day</Value>
</Value>
</Data>
<DataLocation>^Community.TestD</DataLocation>
<DefaultData>TestDefaultData</DefaultData>
<IdLocation>^Community.TestD</IdLocation>
<IndexLocation>^Community.TestI</IndexLocation>
<StreamLocation>^Community.TestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

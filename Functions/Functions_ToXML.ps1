function create_XML ([string]$rootDirectory){
    #Some Root files to add for save and load
    $XMLFilePath = "$rootDirectory\XMLConverted\list.xml"
    $CSVFile = "$rootDirectory\fileToConvert\temp_CSVUsers.csv"

    #Loading the CSV Data
    $csvData = Import-Csv -Path $CSVFile

    ##Declare XML
    $xml = new-object System.Xml.XmlDocument
    $xml.AppendChild($xml.CreateXmlDeclaration("1.0","utf-8",$null))

    ##Root Element
    #We are talking about the users so the first tag is Users
    #under that there is a subtag User
    $root = $xml.CreateElement("Users")
    
    #Add this to the xml Declaration
    $xml.AppendChild($root)

    #Put users to Elements
    #Read the whole line of data
    foreach ($userdata in $csvData){
        #Create the second tag
        $user = $xml.CreateElement("user")
        #Read the headers from the Csv file
        foreach ($header in $csvData | get-Member -MemberType Properties){
            #For each header create a tag and add the data between the tags
            $columName = $header.Name
            $userdatas = $xml.CreateElement($columName)
            $userdatas.InnerText = $userdata.$columName
            $user.AppendChild($userdatas)
        }

        #Add to the XML parser
        $root.AppendChild($user)
    }
    #Save the file
    $xml.Save($XMLFilePath)
}

function XML2ADUsers([string]$rootDirectory){
    #Read the XML data into an XML object variable
    $XMLDataPath = "$rootDirectory\XMLConverted\list.xml"
    $xmlData = [xml](Get-Content $XMLDataPath)

     #For each node "Users>User tag" read out and put it in vars. 
     foreach ($userNode in $xmlData.Users.User){
        $firstname = $userNode.FirstName
        $lastname =  $userNode.LastName
        $company = $userNode.Company
        $username = $userNode.Username
        $password = $userNode.Password

        write-host "USER:`n-----`nUSER FOUND:$firstname $lastname `nCOMPANY:$company`nUSERNAME:$username`nPASSWORD:$password`n`n" -BackgroundColor Blue
     }
}
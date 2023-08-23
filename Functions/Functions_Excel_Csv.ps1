function create_randomUsers([string]$rootDirectory){
    #The count of users to create of
    $userCount = 2000
    #Default variable of a fictive domain
    $Company = "TestLab.Net"

    #list of first and lastnames in txt files located in the same rootdirectory under a subfolder
    $firstNames = Get-Content -Path "$rootDirectory\InputFiles\firstNames.txt"
    $lastNames = Get-Content -Path "$rootDirectory\InputFiles\lastNames.txt"

    #Declare a ListArray Variable
    $userData = @()

    #Creation of 2000 users
    for($i=1;$i -le $userCount; $i++){
        $firstName = $firstNames | Get-Random
        $lastName = $lastNames | Get-Random
        # write-host "randomFirst: $firstName" -ForegroundColor Red

        $userName = "$firstName.$lastName@$Company"
        $password = "p4sst3st"

        #Put the results in a Hashtable arraylist
        $userObject = [PSCustomObject]@{
            FirstName = $firstName
            LastName = $lastName
            Username = $userName
            Password = $password
            Company = $Company
        }
        
        #Add the data of the Hashtable into the Array
        $userData += $userObject
    }

    #Export all data created to a csv without TypeInformation
    $userData | Export-Csv -Path "$rootDirectory\fileToConvert\temp_CSVUsers.csv" -NoTypeInformation

}
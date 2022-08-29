$DistroList_DynamicMembers = @{}
$alldistromembers = @{}
$DistroMembers = @{}
#Query the master list for its members
$MasterDistroList = Get-DistributionGroupMember -Identity "SanFranciscoOfficePT@disneystreaming.com" -ResultSize Unlimited | Select *
#Query each member list for its members
Foreach ($member in $MasterDistroList)
    {
        Write-Host "Working on $($Member.name)" -ForegroundColor Yellow
        $MasterList_DynamicMembers = Get-DynamicDistributionGroup $member.name
    
        Write-Host "Querying the following distro for its members - $($MasterList_DynamicMembers.PrimarySMTPAddress)"
        $DistroMembers = Get-Recipient -RecipientPreviewFilter $MasterList_DynamicMembers.RecipientFilter | Select Name,PrimarySMTPAddress
    
        #Enable this write to console the list of users being stored on the variable.
        #Write-Host "Writing $($DistroMembers.Name) to the list."
    }
#Print to screen # of Members
$DistroMembers.count
$DistroMembers | export-csv -path c:\temp\DynamicDistro_ListOfMembers-04-19-22.csv -NoTypeInformation


test
$personalAccessToken = 'tnghz4likjf6xso42rdsgevbejiyfq4qcixhhwhtgntseqxxfmxa'
$repoprefix = "automations-*"
$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo)}

$result = Invoke-RestMethod -Uri "https://dev.azure.com/F-DC/Migration%20Automation/_apis/git/repositories?api-version=6.0" -Method Get -Headers $headers

$result.value.name | ForEach-Object {
    if($_ -like $repoprefix)
    {
        git clone ('https://F-DC@dev.azure.com/F-DC/Migration%20Automation/_git/' + [uri]::EscapeDataString($_)) $_
    }
}
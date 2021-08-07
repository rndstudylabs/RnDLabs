function selectItem {  
    Param( [Parameter(Mandatory=$true)]  
           $options,  
           $MultiSelect = $false,
           $Preselected = @(),
           $ListBoxText = "Select Item" )  

    Add-Type -AssemblyName System.Windows.Forms

    if ($options.gettype().BaseType.Name -notmatch "Array") {
        return $options
    }

    function processOK {
        if ($lstOptions.SelectedIndex -lt 0)
            {  $script:selectedItem = $null  } else
            {  $script:selectedItem = $options | Where-Object {$lstOptions.SelectedItems -contains $_}  }
        $form.Close()
    }  
    $script:selectedItem = $null
  
    #Create the form  
    [Windows.Forms.form]$form = new-object Windows.Forms.form
    $form.Size = new-object System.Drawing.Size @(600,400)
    $form.text = $ListBoxText
  
    #Create the list box.
    [System.Windows.Forms.ListBox]$lstOptions = New-Object System.Windows.Forms.ListBox
    $lstOptions.Name = "lstOptions"
    $lstOptions.Width = 570
    $lstOptions.Height = 300
    $lstOptions.Location = New-Object System.Drawing.Size(5,5)
    $lstOptions.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
    if ($multiselect) {
        $lstOptions.SelectionMode = "MultiExtended"
    }
    $lstOptions.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right  
      
    #Create the OK button
    [System.Windows.Forms.Button]$btnOK = New-Object System.Windows.Forms.Button 
    $btnOK.Width = 100
    $btnOK.Location = New-Object System.Drawing.Size(460, 320)
    $btnOK.Text = "OK"
    $btnOK.add_click({processOK})
    $btnOK.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right
    $form.Controls.Add($lstOptions)
    $form.Controls.Add($btnOK)
  
    #Populate ListBox
    foreach ($option in $options)
    {  $lstOptions.Items.Add($option) | Out-Null }
  
    $Preselected | ForEach-Object {$lstOptions.SetSelected([INT]$_-1,$true)}

    $topform = New-Object System.Windows.Forms.Form
    $topform.Topmost = $true

    $form.ShowDialog($topform) | Out-Null
    return $script:selectedItem  
}

function getFolderName {
    param([string]$Description="Select Folder",[string]$FolderName=".")

    Add-Type -AssemblyName System.windows.forms

    $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.SelectedPath = $FolderName
    $objForm.Description = $Description
    $topform = New-Object System.Windows.Forms.Form
    $topform.Topmost = $true
    $Show = $objForm.ShowDialog($topform)
    If ($Show -eq "OK") {
        Return $objForm.SelectedPath
    } Else {
        Return $RootFolder
    }
}

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

# Check for packed labs
function findLab {
    param($folder)
    $AllFiles = Get-ChildItem -Path "$folder" -Exclude "Offline Lab.zip", "start_lab.ps1"
    Return $AllFiles | ? { (".zip", ".md", ".markdown") -contains $_.Extension}
}

$contentPath = $scriptPath
$ZipMDFilterFiles = findLab -folder $contentPath

if ($null -eq $ZipMDFilterFiles) {
    $contentPath = getFolderName -Description "Select folder containing lab content"
    $ZipMDFilterFiles = findLab -folder $contentPath
}

#if ($ZipMDFilterFiles.Count -eq 1) {
#    $LabContentFile = $ZipMDFilterFiles
#} else {
#    $selection = selectItem -options $ZipMDFilterFiles.Name
#    $LabContentFile = $ZipMDFilterFiles | ? {$_.Name -eq $selection}
#}

$htmlLabPath = "$scriptPath\html_lab"

$OfflineLab = Get-Item -Path "$scriptPath\Offline Lab.zip"

# Remove-Item -Path $htmlLabPath -Recurse -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 3

if (Test-Path $htmlLabPath) {
    $tmpLabFolder = get-item -Path $htmlLabPath
} else {
    $tmpLabFolder = new-item -Path $htmlLabPath -ItemType "directory"
}

foreach ($LabContentFile in $ZipMDFilterFiles) {

    if ($null -ne $LabContentFile) {

        Expand-Archive $OfflineLab.FullName -DestinationPath $tmpLabFolder.FullName -Force
        
        $Labfile = [IO.File]::ReadAllText("$($htmlLabPath)\Lab.html", [text.encoding]::UTF8)
        
        if (Test-Path "$htmlLabPath\Content\$($LabContentFile.BaseName)") {
            $mediaFolder = get-item -Path "$htmlLabPath\Content\$($LabContentFile.BaseName)"
        } else {
            $mediaFolder = new-item -Path "$htmlLabPath\Content\$($LabContentFile.BaseName)" -ItemType "directory"
        }

        if ($LabContentFile.Extension -eq ".zip") {
            Expand-Archive $LabContentFile.FullName -DestinationPath $mediaFolder.FullName -Force
        } else {
            Copy-Item "$($LabContentFile.DirectoryName)\*" "$($mediaFolder.FullName)\" -Exclude "start_lab.ps1", "*.zip", $LabContentFile.Name -Recurse -Force
            Copy-Item $LabContentFile "$($mediaFolder.FullName)\" -Force
            Rename-Item -Path "$($mediaFolder.FullName)\$($LabContentFile.Name)" -NewName "instructions.md"
        }

        $LabMD = [IO.File]::ReadAllText("$($mediaFolder.FullName)\instructions.md", [text.encoding]::UTF8)
        
        $LabMD = ""

        foreach ($line in [IO.File]::ReadLines("$($mediaFolder.FullName)\instructions.md", [text.encoding]::UTF8)) {
        
        if ($line.contains('![') -or $line.contains('!IMAGE[')) {
                $line = $line.Replace('](', "]($($LabContentFile.BaseName)/Content/")
            }
        
            $LabMD += $line += "`n"
        }

        $LabMD = $LabMD.Replace('"',"&quot;").Replace("'","&#39;")

        [IO.File]::WriteAllLines("$($htmlLabPath)\$($LabContentFile.BaseName).html", $Labfile.Replace('[[MDCODE]]',$LabMD), [text.encoding]::UTF8)

        # & "$($env:TEMP)\labs\LabContent.html"
    }
}
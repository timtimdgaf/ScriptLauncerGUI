Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#-- Results --#

$result = $form.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult])
    {
    $x = $listBox.SelectedItem
    Invoke-Expression $x 
    }

Function GenerateForm {
    #-- Form --#
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Script Selector'

    $form.Size = New-Object System.Drawing.Size(300, 200)
    $form.AutoSizeMode = "GrowOnly" # or GrownAnShrink
    $form.StartPosition = 'CenterScreen'
    $form.Topmost = $true

    $form.ControlBox = $false
    #$Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
    #$Form.Icon = $Icon

    #-- Buttons --#
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = 'Run'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    #$OKButton.Add_Click({Button_Click})

    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(150,120)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = 'Cancel'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    #-- ListBox --#
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please select a script:'
    $form.Controls.Add($label) 

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10,40)
    $listBox.Size = New-Object System.Drawing.Size(260,20)
    $listBox.Height = 80

    $ListArrayItems = (Get-ChildItem -Path 'C:\Scripts' -Recurse *.ps1 -Name)
    $ListArray = $ListArrayItems #| sort

    ForEach ($Item in $ListArray) { 
        $listBox.Items.Add($Item) | Out-Null
    }
    $form.Controls.Add($listBox)

} # End Function

GenerateForm
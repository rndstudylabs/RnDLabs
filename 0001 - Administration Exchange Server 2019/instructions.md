
# Welcome @lab.User.FirstName to the Exchange Server Administration and Troubleshooting WorkshopPLUS

# Modules

The following modules are covered in this Exchange Server Administration and Troubleshooting lab.

[Module 3A - Administration introduction](#lab-3a-exchange-administration)

[Module 3B - Administration RBAC](#lab-3b-configuring-and-testing-rbac)

[Module 4 - Recipient Management](#lab-4-recipient-management)

[Module 5A - Client Access connections](#lab-5a-client-access-connections)

[Module 5B - Client Access configuration](#lab-5b-certificates-deployment)

[Module 5C - Client Outlook setup](#lab-5c-outlook-setup)

[Module 6A - Outlook Calendaring AutoDiscover](#lab-6a-outlook-autodiscover)

[Module 6B - Outlook Calendaring diagnostics](#lab-6b-outlook-calendar-diagnostics-introduction)

[Module 7A - Compliance In-Place Hold](#lab-7a-in-place-hold)

[Module 7B - Compliance Data Loss Prevention](#lab-7b-compliance-data-loss-prevention)

[Module 8 - OAB](#lab-8-oab)

[Module 9A - Mail flow transport](#lab-9a-mail-flow-transport)

[Module 9B - Mail flow Safety Net](#lab-9b-mail-flow-safety-net)

[Module 10 - Managed store](#lab-10-managed-store)

[Module 11 - Workload Management and Managed Availability](#lab-11-workload-management-and-managed-availability)

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 3A: Administration - Introduction
-->

# Lab 3A: Exchange Administration

[Modules Overview](#modules)

## Introduction
This lab is an introduction to the GUI administrative tool in Microsoft Exchange Server 2019 called Exchange Admin Center (EAC). In this lab, you will learn how to connect and work with the interface.

## Objectives
After completing this lab, you will be able to:
- Connect to EAC
- Explore Exchange Server 2019 configuration
- Determine to which database a mailbox belongs
- Create various objects

## Estimated time to complete this lab

**30** minutes

===

## Scenario

Contoso has recently installed Exchange Server 2019 . The IT staff is still getting used to Exchange Server 2019 and how to administer it.

>[!hint] It is recommended while working in these labs, to create a **.ps1** file using **Windows PowerShell ISE**. By saving a single file, you will be able to reference it and leverage the **Run Selection (F8)** feature. This allows you to re-use commands instead of re-typing them from scratch each and every time you have to repeat tasks. You can also save a **.ps1** file to your own machine, for later usage.

# Exercise 1: Verify the Exchange Server environment

## Objectives

After completing this lab, you will be able to:
-   View the current version of the Exchange Servers installed in the
    environment
-   Verify Exchange services are running
-   Verify mailbox databases are mounted

## Task 1: Log into the Exchange Management Shell

1.  Log onto **CON-Ex2019N1** (Should be the default logon)
    - **Username:** +++Contoso\\Administrator+++
    - **Password:** +++LS1setup!+++

    !IMAGE[001.png](001.png)

1.  [] Start **Exchange Management Shell** (EMS), by typing the command below at the DOS prompt:

    +++LaunchEMS+++

    ![](media/dd92de5c0344b5160b808eb3b12e2e92.png)
        
1.  [] Enter the following command:

    +++Get-ExchangeServer | Format-Table Name,AdminDisplayVersion+++

1.  [] Verify the version is **15.2 (Build 221.12)**. If it is not, then inform the instructor that the virtual machine labs do not match these lessons.

    For reference, the table below is from this TechNet article:
    <https://technet.microsoft.com/en-us/library/hh135098(v=exchg.150).aspx>

    - Product name - Release date: Build number (short format), Build number (long format)
    - [Exchange Server 2019 CU3](https://www.microsoft.com/Licensing/servicecenter/) - September 17, 2019: 15.2.464.5, 15.02.0464.005 
    - [Exchange Server 2019 CU2](https://www.microsoft.com/Licensing/servicecenter/) - June 18, 2019: 15.2.397.3, 15.02.0397.003
    - [Exchange Server 2019 CU1](https://www.microsoft.com/Licensing/servicecenter/) - February 12, 2019:  15.2.330.5, 15.02.0330.005
    - [Exchange Server 2019 RTM](https://www.microsoft.com/Licensing/servicecenter/) - October 22, 2018:  15.2.221.12, 15.02.0221.012

1. [] Verify status of Exchange services, by entering the following command:

    +++Get-ExchangeServer | Test-ServiceHealth+++

    ![](media/2ea91945f3db744a17bae7167aaa3ba2.png)

1.  [] Verify that there are no services on the **ServicesNotRunning** list.

1.  [] If there is a service not running, start by using **Start-Service** command. See example on the screenshot below:

    ![](media/d427a8951e8b9d2a2c10928a48de4a40.png)

    > [!note] If the Microsoft Exchange EdgeSync service is stopped you may proceed without starting it. At this point you do not have an Edge Server to synchronize with, so this service is not required to be running at this time.

1. [] Verify status of Exchange mailbox databases. Enter the following command

    +++Get-MailboxDatabase -status | ft name, mount*+++

1. [] Verify that database with parameter **MountAtStartup: True** are mounted.

    > [!note] If **DB-2019-04** is ***not*** mounted on startup. This is done for workshop exercise purpose, and should remain not mounted.

    ![](media/7ea8d435b1ed6eb4ad23d962a3e7a299.png)

1. [] In case another database is not mounted, use **Mount-Database** cmdlet. For example:

    +++Mount-database db-2019-02+++

===

# Exercise 2: Explore the EAC

## Objective

After completing this lab, you will be able to:

-   Discover how to start Exchange Admin Center (EAC) and explore this new
    interface.

## Task 1: Log in to the Exchange Admin Center (EAC)

1.  [] Log onto **Con-Client** (Should be the default logon)
    - **Username:** +++Contoso\Administrator+++
    - **Password:** +++LS1setup!+++

1.  [] Start **Internet Explorer**.

1.  [] Enter the following **URL**:
     +++https://con-ex2019N1.contoso.com/ecp+++ for **EAC** (ignore the certificate error) with credentials :
    - **Username:** +++Contoso\\Administrator+++
    - **Password:** +++LS1setup!+++

1.  [] Explore **EAC** and click the various tabs to familiarize yourself with the interface.

1.  [] How many mailboxes are in the environment? [Answer]("19 mailboxes appear in the EAC. You can also use the command in EMS (get-mailbox).Count , which will return 20. The EAC does not include the DiscoverSearchMailbox by default, but the EMS does.")
    
1.  [] What Exchange servers can you see in EAC?  [Answer]("There are only 2019 servers in the environment.")

===

Exercise 3: Bulk Edit in EAC
----------------------------

## Objective

After completing this lab, you will be able to:
-   Understand bulk-editing possibilities within EAC.

## Task 1: Bulk Edit

1.  [] While in the **EAC**, go to **recipients**

1.  [] Click on **Mailboxes**

1.  [] Select the **Marketing mailboxes** (9 in total)

1.  [] Observe the right pane updating with the **Bulk Edit** option

    ![](media/7ae390cd5d051cbe7434c0bc8b929715.png)

1.  [] In **Bulk Edit**, click **Organization** and then click **Update.**

1.  [] Add **Administrator** as the **Manager**

1.  [] Add **Marketing** as **Department** and click **Save.**

===

Exercise 4: Bulk Edit using PowerShell
--------------------------------------

## Objectives

After completing this lab, you will be able to leverage Exchange Management Shell:
- to quickly edit a large group of objects
- easily set any mailbox attribute available in Exchange

## Task 1: Bulk Edit

1.  [] Log onto server **Con-Client** and launch **Windows PowerShell ISE**.

1.  [] In **ISE**, you can **run selection** of one line by pressing **F8** or selecting the icon  ![](media/e5fbc258822368e7bf93ca5736d49cdc.png). Type in the following command and run the selection:

    +++Get-Command | Measure-Object+++

1. [] How many commands are available? [Answer]("There are roughly 1753 or more, depending on the OS updates applied.")

1.  [] Connect to an Exchange server via remote PowerShell using the following code, using:
    - **Username**: +++contoso\administrator+++
    - **Password**: +++LS1setup!+++

    ```
    $UserCredential = Get-Credential

    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://CON-Ex2019N1.contoso.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential

    Import-PSSession $Session
    ```

    > [!note] It is recommended to save the **Untitled1.ps1** file you are working in for future reference throughout this workshop. The sample file **exconn.ps1** is placed in **c:\labfiles**.

1.  [] Run the following command:

    +++(Get-Command).Length+++

    [Answer]("As you can see the remote PS session has connected and there are many more cmdlets, 2300 or more, available to the end user, which are the now available Exchange cmdlets.")

1.  [] List that are all mailboxes and their databases using the following command:

    +++Get-Mailbox | ft name,database -autosize+++

1.  [] Now just filter for the users that are in the **Marketing** department. Type the following command:

    +++Get-Mailbox -Filter {Department -eq "Marketing"}+++

1.  [] Did you get a list of mailboxes? [Answer]("No.")

    > [!note] Nothing is listed, as the **department** value is not an attribute of the mailbox object, but is an attribute of the user objects.

1.  [] Type the following command:

    +++Get-User -Filter {Department -eq 'Marketing'}+++

1.  [] Are only the **Marketing** department mailboxes listed? [Answer]("Both mailbox enabled users and non-mailbox users are listed in the Marketing department.")

1.  [] Now count how many **Marketing** users there are by using this command:

    +++Get-User -Filter {Department -eq 'Marketing'} | Measure-Object+++

1. [] How many users are listed? [Answer]("9")

1. [] Now set the Marketing users' mailboxes **ArchiveQuota** value to 1.4TB by
    typing:

    +++Get-User -Filter {Department -eq 'Marketing'} | Set-Mailbox -ArchiveQuota 1.4TB+++

1. [] Confirm if your tasks worked or not. What command could you use?  [Answer]("+++Get-User -Filter {Department -eq 'Marketing'} | Get-Mailbox | ft name,ArchiveQuota+++")

1. [] Is this archive quota value available in the GUI? [Answer]("No. Error message is displayed.")

1.  [] Save the file to the **Con-Client** virtual machine before you close ISE to reuse this information during the workshop. Feel free to add comments in the file so you can remember what the different lines of code perform which specific tasks.

===

Exercise 5: Reviewing special mailboxes within Exchange Server
----------------------------------------------------------

## Objective

After completing this lab, you will be able to:
-   Understand how to determine database membership through EAC.

## Task 1: Administrator Mailbox

1.  [] Select one of the lab machines to view **EAC**, logged in as the domain administrator. 
1.  [] Using **Con-Client**, log into EAC again.

1.  [] Click the **recipients** tab.

    ![](media/b39f02c65ab29313de369eb8a59bf43c.png)

1.  [] Select **Administrator** and click ![](media/4e5bb9c3b63f11c596999cf51267dab6.png). This will display more information about the Administrator, but will not display
the mailbox database.

1.  [] Click **More options...** (Selecting this will display the user\'s current mailbox database.)

    ![](media/fae83dd9efdd28b0d7f11427cb818358.png)

## Optional Method

1.  [] On the main **Recipients** page, click **...** and select **Add/Remove columns.**

    ![](media/5ad7481e129f72b3a726acb1f43c8e45.png)

1.  [] From the list of columns, select **DATABASE**.

1.  [] Click **Ok.**

1.  [] Now the **DATABASE** column, specifying which database each user is in will be displayed.

    ![](media/3ff84d4c099d4b22bef599a951e122f9.png)

===

# End of Lab 3A: Exchange Administration

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 3B: Administration - RBAC
-->


# Lab 3B: Configuring and testing RBAC

[Modules Overview](#modules)

## Introduction

In this lab, you will use various cmdlets to configure Role Based Access Control
(RBAC), so that a group of Administrators are only allowed to edit specific
attributes of users' objects within a given Organizational Unit (OU).

## Objective

After completing this lab, you will be able to:
-   Configure RBAC

#### Estimated time to complete this lab

**30** minutes

===

Exercise 1: Configure and Test RBAC
----------------------------------

## Objectives

After completing this lab, you will be able to:
-   Create a management scope
-   Create a management role
-   Create a Role Group
-   Test the RBAC configuration

## Scenario 

You need to allow Marketing Admins within the Marketing OU to perform certain
administrative tasks, but not others. Specifically, they can edit user
information, such as mobile phone numbers and office information.

## Task 1: Create a Management Scope

1.  [] On **CON-Client** launch Windows PowerShell ISE with a remote connection to **CON-Ex2019N1.** (The steps were shown earlier in this lab.)

1.  [] Execute the following cmdlet:

    +++New-ManagementScope -Name 'Scope-Marketing OU' -RecipientRoot 'Contoso.com/Marketing' -RecipientRestrictionFilter {RecipientType -eq  'UserMailbox'}+++

## Task 2: Create a Management Role

1.  [] Execute the following cmdlet to create a child custom management role with the Mail Recipients built-in management role as its parent:

    +++New-ManagementRole -Name 'MR-Marketing Admins' -Parent 'Mail Recipients'+++

1.  [] Execute the following cmdlet to remove management role entries, so that **MR-Marketing Admins** cannot perform all the tasks that are available to the members of **Mail Recipients**:

    +++Remove-ManagementRoleEntry 'mr-marketing admins\set-mailbox'+++

1. [] When prompted with **Are you sure you want to perform this action?** choose **Y**

1. [] Now remove the **Set-User** cmdlet from the group:

    +++Remove-ManagementRoleEntry 'mr-marketing admins\set-user'+++

1. [] When prompted with **Are you sure you want to perform this action?** choose **Y**

1. [] Execute the following parameters of the cmdlets to restore the cmdlets and parameters that the **MR-Marketing Admins** can use:

    +++Add-ManagementRoleEntry 'MR-Marketing Admins\Set-User' -Parameters Identity, MobilePhone, Office+++
    
    +++Add-ManagementRoleEntry 'MR-Marketing Admins\Set-Mailbox' -Parameters Identity, CustomAttribute1+++

    > [!note] CustomAttribute1 is often used for filtering. For example, you can use it as a filter to test dynamic distribution group membership.

## Task 3: Create a Role Group

1. [] Execute the following cmdlet to create the Role Group, whose members will have the right to run the cmdlets identified by the management role entries:

    +++New-RoleGroup -Name "RG-Marketing Helpdesk" -Roles "MR-Marketing Admins" -CustomRecipientWriteScope "Scope-Marketing OU" \-Members User1,User2,User3+++

## Task 4: Test the RBAC Configuration

1.  [] On **Con-Client**, start a new remote PowerShell session. (Hint: You can use an ISE session with the same **.ps1** file you saved earlier.) When you are prompted to enter username and password, type the following:
    - **Username**: +++contoso\user3+++
    - **Password**: +++LS1setup!+++

1.  [] Execute the following cmdlets to verify that you are allowed to edit the users within the **Marketing OU**:

    +++Set-User -Identity "marketing1@contoso.com" -MobilePhone 001234567890 -Office SO-141+++
    +++Set-Mailbox -Identity "marketing2@contoso.com" -CustomAttribute1 'Marketing Employee'+++

1.  [] Execute the following cmdlet to edit a user outside of the **Marketing Management** scope:

    +++Set-Mailbox -Identity 'user4@contoso.com' -CustomAttribute1 'Marketing Employee'+++

1 . [] Did the setting of CustomAttribute1 on **user4** work? [Answer]("No. Because User4 is out of scope allowed for setting this attribute.![](media/6a3792baa69a93389f47d523288cf719.png)")
    
===

# End of Lab 3B: Configuring and testing RBAC

===


<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 4: Recipient Management
-->

# Lab 4: Recipient Management

[Modules Overview](#modules)

## Introduction

This lab, you will learn how to work with administrative tolls to complete day
to day tasks for an Exchange engineer.

## Objectives

After completing this lab, you will be able to:
-   Create mailboxes
-   Create Distribution Groups
-   Edit Address Book

#### Estimated time to complete this lab

**60** minutes

## Scenario

Contoso has recently installed Exchange Server 2019. The IT staff is still
getting used to Exchange Server 2019 and the best way to administer it.

===

Exercise 1: Create a new mailbox using EAC
------------------------------------------

## Objective

After completing this exercise, you will be able to:
   - Understand how to create a mailbox in EAC.

## Task 1: Enable command logging

1.  []Use server **CON-Client** and log onto EAC, click as described in this screenshot:

    ![](media/a69a4095c01f959b5a8b8a75a8bca710.png)

1. []Keep the command logging windows open while creating the mailbox. Make sure to explore the command logging window while doing the various EAC tasks.

## Task 2: Create New Mailbox

1.  [] Click **recipients** on the left pane.

1.  [] Click **mailboxes.**

1.  [] Click ![](media/57a4bd3336d29753d74f7bce2f65c481.png) and select **User mailbox**.

    ![](media/830eeb0459e1ae8d706c4584f6638738.png)

1.  [] In Alias type: **SalesUser**

1.  [] Select **New User** and type the following information:
    - **Display Name**: +++Sales User+++
    - **Name**: +++Sales User+++
    - **User logon name**: +++SalesUser+++
    - **Password**: +++LS1setup!+++

   >[!note] If you hit **Save** at this point it will create the user on any database. However, you want the user created on a specific database.

1.  [] Scroll down and select **More options...**.

1.  [] Click **Browse** and select **DB-2019-01**.

1.  [] Click **OK**

1.  [] Click **Save**

1.  [] Verify in the EAC **recipients** tab that the user was created and their mailbox is on **DB-2019-01**.

## Task 3: Create a Shared Mailbox

1.  [] Connect to **EAC** on a **Con-Client**.

1.  [] Click **Recipients** on the left pane for EAC

1.  [] Click **Shared** at the top.

1.  [] Click **+**.

1.  [] Set the **DISPLAY NAME** and **Alias** to **SalesDeptShared.**

1.  [] Add **Sales User** for full access.

1.  [] Click **Save**.


===

Exercise 2: Create a new mailbox using EMS
------------------------------------------

## Objective

Use PowerShell to create a new user while using a remote PowerShell session not logged onto an Exchange server.

## Task 1: Create a New Mailbox

1.  [] Log onto the **Con-Client** workstation.

1.  [] Connect remotely to **CON-EX2019N1** (You've done this process in a previous lab and should have the information already saved in a **.ps1** file. You can find sample of the file **c:\labfiles\exconn.ps1**)

1.  [] Type this command:

    +++New-Item c:\\temp -type directory ; Start-Transcript c:\\temp\\NewUsers.txt+++

1.  [] Get the current IP address of the **CON-EX2019N1** server by typing this command:

    +++Get-WmiObject -ComputerName CON-EX2019N1 Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -ne $null}+++

1.  [] Create a single mailbox for the marketing department by typing this command:

    +++New-Mailbox -Name Marketing10 -Alias Marketing10 -DisplayName 'Marketing10' -Password (ConvertTo-SecureString 'LS1setup!' -AsPlainText -Force) -UserPrincipalName 'Marketing10@contoso.com' -OrganizationalUnit 'contoso.com/Marketing'+++

1.  [] Confirm the mailbox was created using a **Get-Mailbox command**, what would that one command look like.

    [Answer]("**Get-Mailbox Marketing10** is enough to confirm if the mailbox exists")

1.  [] Now stop the transcript:

    +++Stop-Transcript+++

1.  [] Review the transcript, by typing this command:

    +++notepad.exe c:\temp\NewUsers.txt+++

1.  [] Review the text file. Take note of the IP address of the **CON-EX2019N1** server. This IP will be used to troubleshoot Autodiscover in the lab environment.

    > [!hint] You do not need to use Command Prompt anymore. PowerShell has more options available, notably the transcript, which can be used for any command and cmdlet that you need to run on an OS.

===

Exercise 3: Create a Dynamic Distribution Group and review the current membership.
-------------------

## Objective

Create a **Dynamic Distribution Group** (DDG), review the current membership, and create a CSV file to be able to send to the Contoso management team so they are ensured who will receive an e-mail message when sending to the **Marketing Team** DDG.

## Task 1: Create DDG

1.  [] Log onto **CON-CLIENT** and open a remote PS session to **CON-EX2019N1**.

1.  [] Type the following command to create a new DDG:

    +++New-DynamicDistributionGroup -Name 'Marketing Team' -Alias Marketing -RecipientFilter {(displayname -like 'Market*') -and (recipienttype -eq 'usermailbox')}+++

1.  [] Type and run the two commands to get a list of users in the DDG:

    +++$ddg = Get-DynamicDistributionGroup 'Marketing'+++

    +++Get-Recipient -RecipientPreviewFilter $ddg.RecipientFilter | Select {$_.alias} | Export-CSV c:\temp\MarketingDDGList.csv -NoTypeInformation+++

1.  [] Open the file and confirm there is a list of users.

    +++Start-Process excel c:\temp\MarketingDDGList.csv+++

===

Exercise 4: Set Out of Office for a mailbox
-------------------------------------------

## Objective

You need to set the Out of Office (OOF) reply for a specific user.

## Task 1: Setting the OOF for a mailbox

1.  [] Log onto **CON-CLIENT** and open a remote PS session to **CON-EX2019N1**.

1.  [] Type the following command to set an **OOF** for **User1**:

    +++Set-MailboxAutoReplyConfiguration -Identity User1 -AutoReplyState Enabled -InternalMessage 'Internal auto-reply message. I am out of the office currently.' -ExternalMessage 'External auto-reply message.'+++

1.  [] Confirm the OOF works by logging into **Outlook on the Web** as **Administrator** and sending **User1** a message.

1.  [] Log off **Con-Client**

===

Exercise 5: Finding E-mail addresses
------------------------------------

## Objective

You are tasked with getting a list of all e-mail addresses currently used in the Exchange environment.

## Task 1: Create a list of SMTP addresses

1.  [] If necessary, log onto **CON-EX2019N1** and connect to **EMS** running the **LaunchEMS** command from command prompt.

1.  [] Type the following command:

    +++Get-Mailbox administrator | fl+++

1.  [] Do you see SMTP addresses listed? [Answer]("Only the Primary SMTP address is listed.")

1.  [] Try this code to clarify what you are looking for:

    +++Get-Mailbox administrator | ft+++

1.  [] Looking at the attributes listed, what might you think is a potential problem with your task of needing to get ***all*** SMTP addresses? [Answer]("Primary SMTP address is the only attribute listed.")

1.  [] Type this command to review properties and methods of the **Get-Recipient** object:

    +++Get-Recipient | Get-Member+++

1.  [] What attribute do you see that is what you are looking for? [Answer]("EmailAddresses, which will be all of the SMTP addresses of a recipient.")

1.  [] Now compare the mailbox list with the recipient list:

    +++Get-Mailbox | select Name,emailaddresses+++

    +++Get-Recipient | select Name,emailaddresses+++

1.  [] If you have a large environment, you can count the entries:

    +++Get-Mailbox | select Name,emailaddresses | Measure-Object+++

    +++Get-Recipient | select Name,emailaddresses | Measure-Object+++

1.  [] You can now expand the **E-Mail address** property as some objects clearly have more than one entry:

    +++Get-Recipient | Select name -ExpandProperty emailaddresses+++

1.  [] Now clean up the view a bit:

    +++Get-Recipient | Select name -ExpandProperty emailaddresses | Select Name,PrimarySmtpAddress+++

1.  [] Then add the export information:

    +++New-Item c:\temp -type directory -ea 0 ; Get-Recipient | Select name -ExpandProperty emailaddresses | Select Name,PrimarySmtpAddress | Export-csv c:\temp\AllEmailAddress.csv+++

1.  [] Open the file from the **Con-Client** computer to confirm the information is what you are looking for by using **Windows PowerShell** either **CLI** or **ISE**.

    +++Start-Process excel \\\CON-EX2019N1\c$\temp\AllEmailAddress.csv+++

    > [!hint] Don't forget to save this PS code in a reusable file, to assist you in completing tasks quicker.

1. [] Bonus question, in **step 11**, what does the **-ea 0** do in the PowerShell code? [Answer]("**EA** is an alias for **ErrorAction** and **0** is an alias for **SilentlyContinue**, which suppresses the red error message presented to end users. If you are coding PowerShell, you should not use aliases. Aliases are handy for shortcuts if you are typing in code interactively.")

===

Exercise 6: E-mail addresses from Distribution List.
------------------------------------

## Objective

You are tasked with getting a list of e-mail addresses from within a Distribution List.

## Task 1: Create a list of SMTP addresses from Distribution Lists.

1.  [] Log onto **CON-EX2019N1** and open **EMS** by running **LaunchEMS** in the command prompt:

    +++LaunchEMS+++

1.  [] Type the following command:

    +++Get-DistributionGroup -resultsize unlimited | Select Name, @{Name='EmailAddresses';Expression={[string]::join(";", ($_.EmailAddresses))}} | Export-CSV c:\temp\DLEmailAddresses.csv+++

1.  [] Confirm that the list worked using the **CON-Client** computer with **Windows PowerShell**: 

    +++Start-Process excel \\\con-ex2019n1\c$\temp\DLEmailAddresses.csv+++

===

Exercise 7: Move the Arbitration Mailboxes
------------------------------------------

## Objective

Move the arbitration mailboxes. Administrators may have to perform this task periodically as databases are created, deleted, and re-purposed for different responsibilities.

## Task 1: Move Arbitration Mailboxes 

1.  [] Log onto the **Con-Client (2019)** server as **Administrator**

1.  [] Using **Windows PowerShell ISE** create a remote session to **CON-Ex2019N1**.

    > [!hint] +++$UserCredential = Get-Credential ; $Session = New-PSSession -ConfigurationName Microsoft.Exchange ConnectionUri http://CON-Ex2019N1.contoso.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential ;Import-PSSession $Session+++

1.  [] Remove any old move requests:

    +++Get-MoveRequest | Remove-MoveRequest+++

1.  [] Run the following commands to verify the location of the Arbitration and Auditlog mailboxes:

    +++Get-Mailbox -Arbitration+++
    
    +++Get-Mailbox -Auditlog+++

1.  [] To move those mailboxes run the following commands:

    +++Get-Mailbox -Arbitration | New-MoveRequest -TargetDatabase db-2019-01 -Priority emergency+++

    +++Get-Mailbox -Auditlog | New-MoveRequest -TargetDatabase db-2019-01 -Priority emergency+++

## Task 2: View where arbitration mailboxes are located. 

1.  [] Verify that the mailbox move completed successfully by running:

    +++Get-MoveRequest | Get-MoveRequestStatistics+++

1.  [] Run the following commands to verify the location of the Arbitration mailboxes:

    +++Get-Mailbox -Arbitration+++

===

# End of Lab 4: Exchange Administration


===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 5A: Client Access connections
-->

# Lab 5A: Client Access connections

[Modules Overview](#modules)

## Introduction

In this lab, you will learn how to:
-   Review the Client Access Service settings
-   Verify virtual directory settings

## Objectives 

After completing the exercises, you will be able to:

-   Ensure proper configuration for client connections
-   Enable logs for troubleshooting
-   Troubleshoot connections

## Estimated time to complete this lab:

**25** minutes

===

Exercise 1: Review Client Access Service settings
-------------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Validate Client Access Service settings
-   Confirm that the environment is ready for client access

## Scenario

You have recently deployed Exchange Server 2019 and you need to confirm that all
client access service connections are valid and can work properly.

## Task 1: Review virtual directories

1.  [] Log onto **Con-Client** as the domain **Administrator**, and connect via
    remote PowerShell to **CON-EX2019N1** (use sample script
    **c:\labfiles\exconn.ps1** if needed).

1.  [] Look up and confirm proper configuration of virtual directories within
    Exchange:

    +++Get-OwaVirtualDirectory+++
    
    +++Get-EcpVirtualDirectory+++
    
    +++Get-WebServicesVirtualDirectory+++
    
    +++Get-OabVirtualDirectory+++
    
    +++Get-MapiVirtualDirectory+++
    
    +++Get-ActiveSyncVirtualDirectory+++

1. [] Do all of the cmdlets give you good, usable information? [Answer]("No, not full information. ")

1.  Some of the cmdlets need additional information to provide relevant data:

    +++Get-OwaVirtualDirectory | fl name,\*url*+++
    
    +++Get-EcpVirtualDirectory | fl name,\*url*+++
    
    +++Get-WebServicesVirtualDirectory \| fl name,\*url*+++

1.  [] Make note of the **autodiscover** settings **autodiscoverserviceinternal** uri by running
    following command:

    +++Get-ClientAccessService | fl \*uri*,\*scope*+++

1.  [] Make note of the Outlook anywhere hostnames by running following command:

    +++Get-OutlookAnywhere | fl server,\*host*+++

===

Exercise 2: Review Client Access Service within Active Directory Directory Services (AD DS).
-------------------------------------------------

## Scenario

You have recently deployed Exchange Server 2019 and you need to confirm that all
client access service AD DS settings are correct and can work properly.

1.  [] Log onto **CON-EX2019N2** as the domain **Administrator**.

1.  [] Open PowerShell and run this command to view the OS view of which AD Site it is assigned to:

    +++nltest /dsgetsite+++

1. [] Run this command in PS to view which AD Site the Exchange application is listed as to which site it belongs to: 

    +++Get-ExchangeServer | FT Name,Site -Autosize+++

    > [!Note] After you install Exchange, you can change the IP of the server or change the AD Site subnet definition, restart the server, and update the AutoDiscoverSiteScope value.

1.  [] If you change subnet definitions, you would need to restart **CON-EX2019N2** by running this command in PowerShell on the server:

    +++Shutdown -r -t 0+++

1.  [] Since there were no changes needed, you do ***not*** have to restart **CON-EX2019N2**.

1.  [] To view what AutoDiscover site a server belongs to by running this command:

    +++Get-ClientAccessService | FT Name,AutoDiscoverSiteScope -Autosize+++

===

# End of Lab 5A: Client Access connections

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 5B: Certificates Deployment
-->

# Lab 5B: Certificates Deployment

[Modules Overview](#modules)

## Introduction

Most of the services, such as Outlook Anywhere, Microsoft Outlook on the Web,
Exchange Web Services, offline address book (OAB), Autodiscover, MAPI/HTTP, and
Exchange ActiveSync, require certificates on Exchange Server 2019. Exchange
Server can use both, subject alternative name (SAN) certificates (recommended)
or wildcard certificates.

-   In this lab, you will export the existing Secure Sockets Layer (SSL)
    certificate from Exchange server **CON-Ex2010N1**, and then import it into
    an Exchange Server 2019 server **CON-Ex2019N2**.

## Objectives

After completing this lab, you will be able to:
-   Verify the namespaces and services assigned to a certificate.
-   Deploy an existing SSL certificate to the new Exchange Server 2019 servers.

## Estimated time to complete this lab

**35** minutes

===

## Scenario

You have deployed the new Exchange Server 2019 server to the existing Exchange
Server 2019 environment. Instead of creating a new certificate for the new
servers, you will use the existing SSL certificate that is on your legacy
Exchange servers.

===

Exercise 1: Deploy the Existing SSL Certificate
-----------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Export the Exchange Server certificate
-   Import the Exchange Server certificate on each server that will use the
    certificate

## Scenario

You have a configured the Exchange certificate. Now you need to use the same
certificate for new installed Exchange server. To do this, you will use the
certificate export and import function of Exchange Server.

## Task 1: Verify the Current Exchange Certificates 
 
1.  [] Log onto **CON-Ex2019N2** as **Contoso\Administrator** (Should be the default logon)
    - **Username:** +++Contoso\Administrator+++
    - **Password:** +++LS1setup!+++ 
    
    ![](media/f3170e66706f9d7ba99b760277d9accc.png)

1.  [] Start **Exchange Management Shell** (EMS), by typing the command below at the DOS prompt:

    +++LaunchEMS+++

    ![](media/dd92de5c0344b5160b808eb3b12e2e92.png)
    
1. [] Run the following command for **CON-EX2019N1**:

    +++Get-ExchangeCertificate -server CON-EX2019N1 | ft subject,\*self*,\*dom*+++

1. [] Which certificates are used for Exchange Server **CON-EX2019N1**? [Answer](" ![](media/5b1.png)")

1. [] Run the following command for **CON-EX2019N2**:

    +++Get-ExchangeCertificate -server CON-EX2019N2 | ft subject,\*self*,\*dom*+++

1. [] Which certificates are used for Exchange Server **CON-Ex2019N2**? [Answer](" ![](media/5b2.png)")

## Task 2: Export the Exchange Certificate

1.  [] Sign in to **Con-Client** as **Contoso\Administrator** and start Exchange
    Admin Center (Ignore the certificate warning this time.)

1.  [] Ignore any warning about an expired trial license if one appears.

1.  [] Go to **Servers -> Certificates**.

1.  [] Select the **CON-EX2019N1.Contoso.com** server.

1.  [] Select the **Contoso.com** certificate, and then select **More**.

1.  [] Select **Export Exchange Certificate**.

1.  Enter the **Universal Naming Convention** (UNC) path and provide the password:

    -   **UNC Path**:
        [\\\\CON-EX2019N1\\c\$\\labfiles\\ExchangeCertificate.PFX](file:///\\con-ex2019N1\c$\labfiles\ExchangeCertificate.PFX)
    -   **Password**: LS1setup!

1.  [] Click **OK**.

## Task 3: Import the Exchange Certificate 

1.  [] In **Exchange Administration Center** on **CON-Client**.

1.  [] Click **Servers -> Certificates**.

1.  [] In **Certificate Overview**, click the ellipsis **...**, and then select
    **Import Exchange Certificate**.

1.  [] Enter the UNC path to which you previously exported the certificate, and
    then provide the password:

    -   **UNC Path**:
        [\\\\CON-EX2019N1\\c\$\\labfiles\\ExchangeCertificate.PFX](file:///\\con-ex2019N1\c$\labfiles\ExchangeCertificate.PFX)
    -   **Password**: +++LS1setup!+++

1.  [] Click **Next**.

1.  [] Select the **CON-Ex2019N2** server to which you will import the certificate.

1.  [] Click **Finish**.

## Task 4: Verify the Imported Exchange Certificate

1.  [] Using **Exchange Administration Center**, go to **Server** \>
    **Certificates**.

1.  [] In **Certificate Overview**, click **Exchange2019N2**.

1.  [] Does the imported certificate appear in the list of certificates on the Exchange
Server 2019 server? If so, what is the status of the certificate? [Answer]("Yes. It is Valid. Could be revocation check list failed.")

## Task 5: Bind the Certificate to Microsoft Internet Information Services (IIS) 

1.  [] Choose the imported certificate **ExchangeContoso**, and then select
    **Edit**.

1.  [] Within the certificate properties, select **Services**.

1.  [] Select **IIS** as the service, and then click **Save**.

## Task 6: Configure Exchange urls

1. [] In this task you will need to configure urls on server CON-EX2019N2 to match
urls configured on CON-EX2019N1 and imported certificate entries.

1.  [] Sign in to **CON-EX2019N2** as **Contoso\Administrator**

1.  [] Start **Exchange Management Shell**, using the command prompt and running command:
    
    +++LaunchEMS+++

1.  [] Configure Autodiscover service connection point by running following command
    from **Exchange Management Shell** (EMS):

    +++Get-ClientAccessService CON-EX2019N2 | set-ClientAccessService -autodiscoverserviceinternaluri https://autodiscover.contoso.com/autodiscover/autodiscover.xml+++

1.  [] Configure virtual directories and outlook anywhere hostnames by running
    following commands from **Exchange Management Shell** (EMS):

    +++$srv='CON-EX2019N2'+++

    +++Get-owavirtualdirectory -server $srv | set-owavirtualdirectory -internalurl https://mail.contoso.com/owa -externalurl https://mail.contoso.com/owa+++

    +++Get-ecpvirtualdirectory -server $srv | set-ecpvirtualdirectory -internalurl https://mail.contoso.com/ecp -externalurl https://mail.contoso.com/ecp+++ 

    +++Get-oabvirtualdirectory -server $srv | set-oabvirtualdirectory -internalurl https://mail.contoso.com/oab -externalurl https://mail.contoso.com/oab+++

    +++Get-webservicesvirtualdirectory -server $srv | set-webservicesvirtualdirectory -internalurl https://mail.contoso.com/ews/exchange.asmx -externalurl https://mail.contoso.com/ews/exchange.asmx+++

    +++Get-mapivirtualdirectory -server $srv | set-mapivirtualdirectory -internalurl https://mail.contoso.com/mapi -externalurl https://mail.contoso.com/mapi+++

    +++Get-ActiveSyncvirtualdirectory -server $srv | set-activesyncvirtualdirectory -internalurl https://mail.contoso.com/microsoft-server-activesync -externalurl https://mail.contoso.com/microsoft-server-activesync+++

    +++Get-OutlookAnywhere -server $srv | set-outlookanywhere -internalhostname mail.contoso.com -externalhostname mail.contoso.com -internalclientauthenticationmethod NTLM -externalclientauthenticationmethod NTLM -internalclientsrequireSSL $True -externalclientsrequiressl $True+++


1. [] Confirm the settings are correct by running these lines of code:

    +++$srv='CON-EX2019N2'+++
    
    +++Get-owavirtualdirectory -server $srv+++
    
    +++Get-ecpvirtualdirectory -server $srv+++
    
    +++Get-oabvirtualdirectory -server $srv+++
    
    +++Get-webservicesvirtualdirectory -server $srv+++
    
    +++Get-mapivirtualdirectory -server $srv+++
    
    +++Get-ActiveSyncvirtualdirectory -server $srv+++
    
    +++Get-OutlookAnywhere -server $srv+++

===

# End of Lab 5B: Certificates Deployment

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 5C: Outlook client setup
-->

# Lab 5C: Outlook setup 

[Modules Overview](#modules)

## Introduction

Outlook uses Autodiscover to obtain environmental settings within the Exchange
organization. Without the proper settings, Outlook profiles are not able to
complete the setup process.

## Objectives

After completing this lab, you will be able to:
-   Troubleshoot Outlook profile issues

## Estimated time to complete this lab

**20** minutes

===

Exercise 1: Create an Outlook Anywhere Profile
----------------------------------------------

## Objective

After completing this lab, you will be able to:
-   Troubleshoot Outlook anywhere connectivity

## Scenario

The Outlook profile cannot be created.

## Task 1: Create the Profile

1.  [] Log onto **Con-Client** with:
    -  **UserName**:  +++Contoso\Administrator+++ 
    -  **Password of**: +++LS1setup!+++.

1.  [] Start **Outlook** and go through the dialog for profile creation. Can you create the profile?  [Answer]("No.")

1.  [] Using **PowerShell ISE**, create a remote PowerShell session to the **CON-Ex2019n1** machine.

1.  [] View the **Autodiscover URL** using the following command:

     +++Get-ClientAccessServer CON-Ex2019n1 | fl name,\*uri+++

1.  [] Open **Internet Explorer** and open the URL: +++https://con-ex2019n1.contoso.com/autodiscover/autodiscover.xml+++

1.  [] Can you browse successfully to the Autodiscover URL? [Answer]("No.")

    
## Task 2: Troubleshoot connectivity issue

1.  [] What do you think the problem is? 
    
     > [!hint] Try to ping (or Test-Connection) the autodiscover.contoso.com  value and then ping (or Test-Connection) the Exchange server CON-EX2019N1

1.  [] Resolve the issue. Start at the basics: do you have network connectivity
    (can you confirm network connection from the client machine to the server)? [Answer]("Yes")

1.  [] Is the IP address correct (can you ping Autodiscover and is it the correct
    value?) [Answer]("No")

1.  [] If not, check DNS on **Con-DC1**. (You can use an MMC add-in on the **Con-Client** machine, or leverage DNS PS Module.)

1.  [] Are the servers online?  (Confirm the Exchange servers are up and running.) [Answer]("Yes")

1.  [] Are the services online? (Confirm all of the needed Exchange services are running on the servers.) [Answer]("They should be, if not, then ensure at least the MSExchange services are running.")

1.  []  What did you find as the issue? Once you have identified the issue, then resolve the DNS value inconsistency. [Answer]("Incorrect DNS registration. Correct the DNS registration for mail.contoso.com and Autodiscover.contoso.com. IP address of the CON-Ex2019N1 server is 10.10.0.6. Ensure the DNS values for mail.contoso.com and Autodiscover.contoso.com are the same as the CON-Ex2019N1. Once changed on the DC, run on the machine **CON-Client** machine in PowerShell (either ISE or CLI): **Ipconfig /flushdns**")

1.  [] Try to open the Autodiscover URL again.  Does it work now? [Answer]("No.")


## Task 3: Troubleshoot authentication issue

1.  [] This LAB is based on Exchange Server 2019 and **mapi/http** is
    enabled by default. For troubleshooting purpose, the authentication is broken
    on **OutlookAnywhere** and **Mapi/http virtual directories**. Use following commands
    to verify authentication settings:

     +++Get-OutlookAnywhere -server CON-EX2019N1 | fl \*auth*+++
     
     +++Get-MapiVirtualDirectory -server CON-EX2019n1 | fl \*auth*+++
     
     +++Get-OutlookAnywhere -server CON-EX2019N2 | fl \*auth*+++
     
     +++Get-MapiVirtualDirectory -server CON-EX2019n2 | fl \*auth*+++

1.  [] In order to resolve the issue, change authentication for **Outlook Anywhere IIS Authentication** to **default** (matching CON-Ex2019N2). Perform the same step for the **mapi/http virtual directory**. Run the following commands to resolve the issue from **Exchange Management Shell** on server **CON-Ex2019N1**:

     +++Get-outlookanywhere -server CON-Ex2019N1 | set-outlookanywhere -IISauthenticationmethods Basic,NTLM,Negotiate+++
     
     +++Get-Mapivirtualdirectory -server CON-EX2019N1 | set-mapivirtualdirectory -IISAuthenticationMethods NTLM,OAuth,Negotiate+++

1. [] Recycle **IIS service** on server **CON-Ex2019N1**:

     +++iisrest \restart+++

1.  [] Start **Outlook** again. Does it complete the setup of the profile? [Answer]("Yes, it should.")

===

# End of Lab 5C: Outlook setup 

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 6A: Outlook - Autodiscover
-->

# Lab 6A: Outlook Autodiscover

[Modules Overview](#modules)

During this lab, you will use tools to review the Autodiscover process and how
to troubleshoot issues.

## Objectives

After completing this lab, you will be able to:

-   Capture Autodiscover information
-   Leverage the Test Connectivity tool

## Estimated time to complete this lab

**10** minutes

===

Exercise 1: Autodiscover
------------------------

## Objectives 

In this exercise, you will use the client connectivity troubleshooting
tools like Test E-Mail auto configuration and Outlook Advanced logging.

## Task 1: Test E-Mail Autoconfiguration

1.  [] Log on to the **CON-Client** workstation using:
    - **User Account**: +++contoso\User1+++
    - **Password**: +++LS1setup!+++

1.  [] Start **Outlook.** If prompted, enter **User1@contoso.com** credentials.

1.  [] After Outlook successfully connects to mailbox, press **CTRL** and **right click** on the **Outlook** icon  ![](media/fcc321f04dfa1557cf55d174af8af3fa.png)

1.  [] Select **Test E-Mail AutoConfiguration**

1.  [] If not present, enter **User1@contoso.com** email address and password.
    Uncheck **Use Guessmart** and **Secure Guessmart Authentication**. Click
    **Test**

1.  [] After test completes successfully, **Results** tab will be populated with
    auto-configuration parameters.
1.  [] What **Protocols** are listed in the **Results** tab? [Answer]("Protocols MAPI HTTP, Exchange HTTP  ![](media/6A1.png)")

1.  [] Identify the Availability Service URL for the User? [Answer]("https://autodiscover.contoso.com/autodiscover/autodiscover.xml  ![](media/6A2.png)")

1.  [] Go to the **Log** tab and review steps of the auto-configuration process.

1.  [] Where is the first Autodiscover request sent? [Answer]("Queried through SCP  ![](media/6A3.png)")

1.  [] Go to **XML** tab and review raw auto-configuration data.

1.  [] Which url is used for MAPIhttp protocol? [Answer]("https://mail.contoso.com/mapi/emsmdb followed by mailbox GUID followed by the mailbox GUID.  ![](media/6A3.png)")

1.  [] Enter this URL into a browser and review the data: https://mail.contoso.com/mapi/emsmdb followed by mailbox GUID

    > [!Note] The **https://mail.contoso.com/mapi/emsmdb** URL displays some brief information in a GUI format. This can be used quickly to verify MAPI/HTTP connection values. 

#### Task 2: Enable Outlook Advanced logging

1.  [] On the **Con-Client1** in Outlook click, **File** tab

1.  [] From left menu, select **Options.**

1.  [] In the **Outlook Options** dialog box,??select **Advanced.**

1.  [] Scroll down the list of settings and then select the **Enable troubleshooting logging (requires restarting Outlook)** option.

1.  [] Click **OK**.

1.  [] Restart Outlook. When prompted enter **User1@contoso.com** credentials.

1.  [] Send a test message to yourself.

1.  [] In **Windows Explorer** open **%temp%\Outlook Logging** folder

1.  [] Review **OPMlog.log** transport log file. Log file should contain entry
    about email you sent in step 7.

===

# End of Lab 6A: Outlook - Autodiscover

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 6B: Outlook - Calendar Diagnostics Introduction
-->

# Lab 6B: Outlook Calendar Diagnostics Introduction

[Modules Overview](#modules)

During this lab, you will use the Calendar Diagnostics Analysis tools to
determine the cause of a missing meeting.

## Objectives

After completing this lab, you will be able to:
-   Capture Calendar Diagnostic log output for meetings
-   Run the Calendar Log Analysis tool and interpret the output to determine the
    cause of the issue

## Estimated time to complete this lab

**30** minutes

===

Exercise 1: Create a Meeting Request
------------------------------------

## Objective

After completing this lab, you will be able to:
-   Create a meeting request and invite several attendees

## Task 1: Create a Meeting Request 

1.  Log on to **CON-CLIENT** using the following domain credentials:
    - **Username**: +++Contoso\Administrator+++
    - **Password**: +++LS1setup!+++

1.  [] Open **Outlook 2019** and switch to the **Calendar** view.

1.  [] Create a new **Meeting request** and add recipients: **User2** and **User3**.

    > [!Note] Make note of the subject of the meeting.

1.  [] Create an **Outlook** profile for **User3** on **CON-CLIENT1**. 

1.  [] Open **Outlook 2019** as the **User3** and delete the meeting request you created in step 3.

1.  [] Using **OWA**, log in as **User2**, and delete the meeting request without accepting it.

===

Exercise 2: Use Diagnostic Cmdlets
----------------------------------

## Objective

In this exercise, you will use the available diagnostic cmdlets to:
-  troubleshoot the sequence of events that took place relating to a meeting.

## Task 1: Use Cmdlets to troubleshoot calendaring events

1.  [] Log on to **CON-Ex2019N1** using the domain administrator credentials and
    launch EMS from within **PowerShell CLI**:

    +++LaunchEMS+++

1.  [] Export the calendar logs for the organizer (Replace **\<organizer name\>** with
    the users name you are interested in creating logs. Also, you will need to
    edit the **\<subject of meeting\>** information to track the specific
    meeting(s)).

    ```
    Get-CalendarDiagnosticLog <organizer name> -Subject "<subject of meeting>" -LogLocation \\con-ex2019n1\c$\calendarLog
    ```

    > [!Note] When the logs are exported, a new subfolder will automatically be created with the alias of the user whose logs you are exporting.

1.  [] Export the calendar logs for both attendees who deleted the meeting by running the following command once for each attendee.

    ```
    Get-CalendarDiagnosticLog <attendee name> -Subject "<subject of meeting>" -LogLocation \\con-ex2019n1\c$\calendarLogs
    ```

    > [!Note] When the logs are exported, a new subfolder will automatically be created with the name of the user whose logs you are exporting. This allows you to specify the same location as used previously.

1.  [] Analyze the logs from each attendee, but retrieving the data:

    +++Get-CalendarDiagnosticAnalysis -LogLocation \\\\con-ex2019n1\\c$\\calendarLogs\\user3@contoso.com\ \> \\\\con-client\\c$\\labfiles\\user3.csv+++
    
    +++Get-CalendarDiagnosticAnalysis \-LogLocation \\\\con-ex2019n1\\c$\\calendarLogs\\user2@contoso.com \> \\\\con-client\\c$\\labfiles\\user2.csv+++

1.  [] Connect to **CON-CLIENT**

1.  [] Open the CSV files from **c:\labfiles\\** using Excel, what do you see? [Answer]("Logged calendar information")

1.  [] Do you see the difference in the client version (ClientInfoString) that was recorded? [Answer]("Yes, client version is visible.  ![](media/8e635a8c59d9e8b58d3ad134f10915d8.png)")

1.  [] Change the **Detail** level to **Advanced.**

    ```
    Get-CalendarDiagnosticAnalysis -LogLocation c:\calendarlogs\<attendee> -DetailLevel Advanced
    ```

1.  [] Do you notice the extra fields? [Answer]("Yes.")

1.  [] Below screenshot without advanced logging:

    ![](media/52b5b7cfd16c81da4e7f735bc66e3b1e.png)

1.  [] Next screenshot with advanced logging.

    ![](media/d08ac5a1b9e430f7b6fbe999e614731a.png)

1.  [] The following fields are added in the Advanced output:

    - ItemVersion,AppointmentSequenceNumber,AppointmentLastSequenceNumber,IsResponseRequested,ResponseState,Location,IsException,FreeBusyStatus,IntendedFreeBusyStatus,
    - ResponsibleUserName,AppointmentState,GlobalObjectId,CreationTime,LastModifiedTime,AppointmentAuxiliaryFlags,IsProcessed,SubjectProperty,TimeZone,CreationTimeZone,
    - StartTimeZoneId,EndTimeZoneId,RecurrencePattern,RecurrenceType,AppointmentRecurrenceBlob,OwnerCriticalChangeTime,AttendeeCriticalChangeTime,ChangeHighlight,
    - MeetingRequestType,MapiIsAllDayEvent,ChangeList,MiddleTierServerName,MiddleTierServerBuildVersion,ServerName,MiddleTierProcessName,InternetMessageId

===

# End of Lab 6B: Outlook - Calendar Diagnostics Introduction

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 7A: Compliance - In-Place Hold
-->

# Lab 7A: In-Place Hold

[Modules Overview](#modules)

## Introduction

This lab is designed to allow you to explore:
-   The eDiscovery interface of Exchange Server 2019
-   The In-Place Hold feature

## Objectives

After completing this lab, you will be able to:
-   Create an eDiscovery Search
-   Place items In-Hold
-   Preview Results

## Estimated time to complete this lab

**60** minutes

===

Exercise 1: Create an eDiscovery Search and Place Results in Hold
-----------------------------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Create an eDiscovery Search in Hold

## Task 1: Create an eDiscovery Search

1.  [] Sign in to **CON-Ex2019n1** by using the following credentials:
    -   **Username**: +++Contoso\Administrator+++
    -   **Password**: +++LS1setup!+++

1.  [] Launch Exchange Management Shell at the command prompt: 

    +++LaunchEMS+++

1.  [] Create a new mailbox with the following credentials for the Compliance
    Officer:

- **Alias**: +++DOfficer+++
- **First Name**: +++Discovery+++
- **Last Name**: +++Officer+++
- **SAMAccountName**: +++Dofficer+++
- **Password**: +++LS1setup!+++
- Mailbox database on **CON-Ex2019N1**

1. [] Add Mailbox to **Discover Management Role** by running command below in
    Exchange Management Shell:

    +++Add-RoleGroupMember 'Discovery Management' -Member DOfficer+++

1. [] Create a new Mailbox with the following credentials for the user with sensitive data in his mailbox:

- **Alias**: +++Sales12+++
- **First Name**: +++Sales+++
- **Last Name**: +++12+++
- **SAMAccountName**: +++Sales12+++
- **Password**: +++LS1setup!+++
- Mailbox database on **CON-EX2019N1**

1. [] Run command:

    +++New-mailbox -Name Sales12 -Alias Sales12 -userprincipalname sales12@contoso.com -Password (ConvertTo-SecureString -String 'LS1Setup!'-AsPlainText -Force) -Database DB-2019-01+++

1. To get some *sensitive* data in the **Sales12** mailbox, use the following
    command to send a critical message:

    +++1..10 \| % { Send-MailMessage -To Sales12@contoso.com -From external@external.com -SmtpServer CON-EX2019N1 -Subject "Critical Message $\_" -Body "This is Message $\_ containing sensitive and critical information" ; Write-Host "Sending Message $\_"}+++

1.  [] Log on to **Con-Client**.

1.  [] Open **EAC** and log on with the following credentials:
    - **Username**: +++Contoso\\DOfficer+++
    - **Password**: +++LS1setup!+++

1.  [] In **EAC**, click **Compliance Management**.

1.  [] Click **\+** to start creating a new eDiscovery search.

1.  [] Specify **Query Based Hold** as the **Name** of this search and click
    **Next**.

1.  [] In **Specify mailbox to search**, click **\+** sign, select **Sales12** and
    click **Next**.

1.  [] In **Search Query**. type **Filter based on criteria** and type the word
    **Critical** in the keywords list. Leave other fields as they are and click
    **Next**.

1.  [] At **In-Place Hold Settings**, select **Place content matching the search query in selected mailboxes on hold** and select **Hold indefinitely**

    > [!Note] If the **Hold** options are not specified, this will be a normal eDiscovery search.

1.  [] Click **Finish**.

1.  [] Log out of **EAC**.

## Task 2: Verify Mailbox that is on In-Place Hold

1.  [] To verify if the **Sales12** mailbox has any In-Hold policies applied to it,
    execute the following command in **Exchange Management Shell**:

    +++Get-Mailbox Sales12 | fl InPlaceHolds+++
    
    +++Get-MailboxSearch | fl \*hold\*+++

    > [!Note] The correspondence of the Mailbox property **InPlaceHolds** and **MailboxSearch** property **InPlaceHoldIdentity.**

===

Exercise 2: Observe In-Place Hold Behavior
------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Observer In-Place Hold Behavior

## Task 1: Check In-Place Hold Behavior

1.  [] Log off of **Con-Client**

1.  [] Log on to **Con-Client** using the following credentials:
    - **Username:** +++Contoso\Sales12+++
    - **Password:** +++LS1setup!+++

1.  [] Start **Outlook** and go through the **Profile wizard**.

1.  [] In **Outlook,** click **File**, then click **Account Settings** and then
    click **Account Settings.**

1.  [] On the **E-mail Accounts** page, select **Sales12** and click **Change.**

1.  [] In the **Offline Settings** option, clear the **Use Cached Exchange Mode**
    checkbox.

1.  [] Restart **Outlook**

1. [] Hard delete all the messages in **Inbox**. To do this, first, press **CTRL** + **A** to select all messages then, press **Shift** + **Delete**.

1. [] While signed in to **Sales12**, open the program **MFCMAPI** from **C:\\LABFILES\\MFCMapi\\MFCMAPI.exe.19.2.19007.645,** click **Session** and
    select **Logon**.

1. [] Click **OK** on a profile that is presented. You should see a mailbox as
    shown in the following screenshot.

    ![](media/d4af2900888f7076fed6f2f822aa10c5.png)

1.  [] Select **Session**, then **Advanced logon**, then choose **Display message store table**

1.  [] Double-click **Sales12@contoso.com**

1.  [] Expand **Root Container** and then expand **Recoverable Items**. Make a note
    of the folders that you see 
    ![](media/7A1.png)

    > [!note] If you do not see a Recoverable Items folder, the Outlook profile is still in cache mode, change it to online mode and continue from here.

1.  [] Right click **Deletions** and select **Open Contents Table**.

    ![](media/3028468f15de8076bd16a4be1d26f828.png)

1.  [] Take a note of items in **Deletions**.

1.  [] Leave **MFCMAPI** as it is and go back to **Outlook Client** of **Sales12**.

1.  [] Click **Folder** and then click **Recover Deleted Items**.

1.  [] Purge (using the black **x** icon) all the items from here.

1.  [] Go to the **Deletions** folder in **MFCMAPI**.

1.  [] Where did items go from Deletions? [Answer]("No longer visible in **Deletions** folder.")

1.  [] Expand **Root Container** and then expand **Recoverable Items**.

1.  [] Do you see any new sub-folders? [Answer]("**DiscoveryHholds** folder appear.")

1.  Right click **DiscoveryHolds** and select **Open Contents Table**

    ![](media/e0d4291e22ea55be5e8a4ab82375470d.png)

1.  [] Do you see all the items that were purged by the user? [Answer]("Yes")

1.  [] You had put hold on emails containing the word **Critical**. Do you see other emails
as well? [Answer]("No")

===

# End of Lab 7A: In-Place Hold

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 7B: Compliance - Data Loss Prevention
-->

# Lab 7B: Compliance Data Loss Prevention

[Modules Overview](#modules)

## Introduction

In this lab, you are going to:
-   Create a DLP policy from a template and customize the rules to add
    notifications to an incident mailbox.
-   Send some test messages with information that triggers the rules and then
    look at the incident mailbox.

## Objectives 

After completing the exercises, you will be able to:
-   Create a DLP policy using a template
-   Verify and test the DLP policy
-   Reviewing DLP

## Estimated time to complete this lab

**60** minutes

===

Exercise 1: Create a DLP Policy from a Template
-----------------------------------------------

## Objective

After completing this lab, you will be able to:
-   Create a DLP Policy

## Task 1: Create a DLP Policy 

1.  [] Log onto **Con-Client**
    - **Username**: +++Contoso\Administrator+++
    - **Password**: +++LS1setup!+++

1.  [] Log into **Exchange Admin Center** using **Internet Explorer**.

1.  [] Enter the following credentials and then click **Sign in**:
    - **Username**: +++Contoso\Administrator+++
    - **Password**: +++LS1setup!+++

1.  [] Create a new Mailbox with the following credentials:
    - **Alias**: SecOfficer
    - **First Name**: Security
    - **Last Name**: Officer
    - **SAMAccountName**: SecOfficer
    - **Password**: LS1setup!
    - Click **More Options** to select a mailbox database on **CON-EX2019N1.**

1.  [] Click **Save**

    > [!Note] Alternatively use **Exchange Management Shell** on server **CON-Ex2019N1**, and create mailbox by running: +++New-mailbox -Name SecOfficer -FirstName Security -LastName Officer -Alias SecOfficer -userprincipalname Secofficer@contoso.com -Password (ConvertTo-SecureString -String 'LS1Setup!' -AsPlainText -Force) -Database DB-2019-01+++

1.  [] Click **Compliance Management**.

1.  [] Click **Data Loss Prevention**.

1.  [] Click the arrow next to **\+** and on the **New custom DLP policy** page, do
    the following:
    - **Name**: DLP Credit Card info
    - **Mode**: Enforce

1.  [] Click **Save.**

1.  [] Ensure that the newly created rule is selected and click **Edit.**

1. [] Click **rules.**

1. [] Click the arrow next to **+** and select **Block messages with sensitive information.**

1. [] Click **\*Select sensitive information type.**

1. [] In the **sensitive information types** window, click **\+**.

1. [] Select **Credit Card Number** and click **add**.

1. [] Click **OK**. In **Contains any of these sensitive information types**
    window, click **OK**.

1. [] For the action **Generate incident report and Send report to**, click on **Select one**

1. [] Select **Security Officer** and then click **OK**.

1. [] Click **Custom content.**

1. [] Select **sender, recipients** and **subject**.

1. [] Click **OK**

1. [] Click **Save**.

1. [] Sign out of **Exchange Admin Center** and close **Internet Explorer**.

===

Exercise 2: Test DLP Policy
---------------------------

## Objective

After completing this lab, you will be able to:
-   Test using the DLP Policy

## Task 1: Test using DLP Policy

1.  [] On **CON-Client,** logon as **Administrator** Open **Outlook** connect to
    **Administrator???s mailbox** and send the following message:
    - **To:** Leak@outlook.com
    - **Subject**: Travel Arrangements for Malta.
    - **Message**: Hello Mr Leak, Please use the following Credit Card to charge all the tickets, Hotel and Entertainment:
    - **Card Type**: VISA
    - **Card Number**: 4111-1111-1111-1111
    - **Expires on**: 1/1/19
    - Regards, Admin

1.  [] The message is blocked and you should receive a Non Delivery Report (NDR).
    Review the NDR. What is the reason for blocking in the NDR? [Answer]("Delivery failed, not authorized ![](media/fdacbe8d174bac91c4413e377734b451.png)")
    
1.  [] Open **Outlook on the Web**

1.  [] Log on with the following credentials:
    - **Username**: +++Contoso\SecOfficer+++
    - **Password**: +++LS1setup!+++

1. [] Did you receive a notification regarding violation of the DLP policy? [Answer]("Yes")

1.  [] Review the notification. What does it include? [Answer]("Message ID, Sender, Subject, To.")

1.  Sign out of **Outlook on the Web** and close **Internet Explorer**.

## Task 2: Reviewing DLP Policy

1.  [] On **CON-Client**, log on with the following credentials:
    - **Username:** +++Contoso\Administrator+++
    - **Password:** +++LS1setup!+++

1.  [] Open a remote PowerShell session to **Con-Ex2019N1**. (Use sample script
    **c:\labfiles\exconnect.ps1** if needed).

1.  [] Using the following command, track the message you sent in **Task 1**:

    +++Get-TransportService | Get-MessageTrackingLog -Sender Administrator@contoso.com -recipients leak@outlook.com+++

1.  [] What happened to the message based on the results? [Answer]("Blocked based on DLP Policy")

1.  [] Close the remote PowerShell session. 

===

# End of Lab 7B: Compliance - Data Loss Prevention

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 8: OAB
-->

# Lab 8: OAB

[Modules Overview](#modules)

## Introduction

During this lab, you will:
-   Explore the Exchange Server 2019 Offline Address Book (OAB) concepts
-   Understand how OAB functions in an Exchange Server environment

## Objectives 

After completing this lab, you will be able to:
-   See how the OAB generation and distribution architecture in Exchange
    Server 2019 works
-   Work with the OAB resilience model in Exchange Server 2019

## Estimated time to complete this lab

**30** minutes

===

Exercise 1: Explore OAB Generation in Exchange Server 2019
----------------------------------------------------------

## Objective

After completing this lab, you will be able to:
-   Explore the OAB generation in Exchange Server 2019

## Scenario

You have deployed Exchange Server 2019.. You want to explore the changes in OAB
generation. The following tasks will help you understand the new OAB generation
architecture.

## Task 1: Explore Organization Mailbox

1.  [] Log on to **Con-Client** using the domain **Administrator** account and open
    a remote PowerShell session to **CON-Ex2019N1**. (Use sample script
    **c:\labfiles\exconnect.ps1** if needed for the remote PowerShell code.)

1.  [] Run the following command:

    +++Get-Mailbox -Arbitration | ft -Wrap -a name, PersistedCapabilities+++

1.  [] What mailbox can generate OABs? [Answer]("System Mailbox    ![](media/81.png)")

    > [!Note] The default output may truncate the results, and hide the OrganizationCapabilityOABGen from the screen.

1.  [] Create a new OAB Gen Mailbox (Click **Yes** if prompted.)

    +++New-Mailbox "OAB Mailbox" -Arbitration:$true -UserPrincipalName oabmailbox@contoso.com+++
    
    +++Set-Mailbox "OAB Mailbox" -OABGen:$true ???Arbitration+++

    ![](media/b8e8bbe898d0e651331a25a8642ccdca.png)

    > [!Note] Note the warning when enabling the OAB Gen capability.

1.  [] Create a new OAB that includes **Default Global Address List**.

    +++New-OfflineAddressBook -Name "New OAB" -AddressLists "Default Global Address List" -GeneratingMailbox "OAB Mailbox"+++

1.  [] Enter the following command:

    +++Get-OfflineAddressBook | ft -a name, Server, GeneratingMailbox+++

1.  [] Why is the Server value blank? [Answer]("In Exchange Server 2010 and above, OAB generation is not tied to a server.")

1.  [] Type the following command:

    +++Get-Mailbox -Arbitration+++

1.  [] Where is the OAB mailbox currently located? [Answer]("System Mailbox ![](media/82.png)")

1.  [] Now move the OAB arbitration mailbox with this command:

    +++Get-Mailbox -Arbitration -database db-2019-01 | Where-Object {$\_.PersistedCapabilities -Like "\*oab\*"} | New-MoveRequest -TargetDatabase db-2019-02+++

## Task 2: Enable Shadow Distribution of OAB

1.  [] Continue using **Con-Client** logged on as the domain **administrator**
    account and using remote PowerShell connected to **CON-Ex2019N1**.

1.  [] The **GlobalWebDistributionEnabled**??and??**VirtualDirectoriesproperties** of an
    OAB are still used by Autodiscover to determine which OAB virtual
    directories are eligible candidates for distributing the OAB. Given the
    architecture in Exchange 2019, any client access service can proxy an
    incoming OAB request to the right location. Thus, the recommendation is to
    enable global web distribution for all OABs hosted on Exchange Server 2019.

    +++Set-OfflineAddressBook "Default Offline Address Book" -VirtualDirectories $null+++
    
    +++Set-OfflineAddressBook "Default Offline Address Book" -GlobalWebDistributionEnabled $true+++

1.  [] Prior to enabling shadow distribution, you should deploy an OAB generation
    mailbox in each Active Directory site where Exchange 2019 infrastructure is
    deployed.

    +++New-Mailbox -Arbitration -Name "OAB Mailbox 3" -Database db-2019-03 -UserPrincipalName oabmbx3@contoso.com -DisplayName "OAB Mailbox 3"+++
    
    +++Set-Mailbox "OAB Mailbox 3" -Arbitration -OABGen $true+++

1.  [] Once global distribution is enabled and OAB generation mailboxes are deployed, you can then enable shadow distribution on a per-OAB basis (Click **Yes** if prompted):

    +++Set-OfflineAddressBook "Default Offline Address Book" -ShadowMailboxDistributionEnabled $true+++

1.  [] You can also disable shadow distribution:

    +++Set-OfflineAddressBook "Default Offline Address Book" -ShadowMailboxDistributionEnabled $false+++

    > [!Note] When shadow distribution is enabled, Autodiscover will return the OAB URL for the site from which the user request initiated. If there is no OAB generation mailbox within that site, the client access service will simply proxy the request back to the Mailbox server hosting the OAB generation mailbox that is responsible for generating the OAB.

===

Exercise 2: Protect System Mailbox accounts
-------------------------------------------

## Objective

After completing this lab, you will be able to:
-   Protect System Mailbox AD Accounts

## Scenario

You have deployed Exchange Server 2019 and would like to not have to rerun the
Exchange install to resolve any missing ???SystemMailbox??? AD accounts.

## Task 1: Prevent accidental deletions

1.  [] Log on to **CON-DC1** using the domain **administrator** account and open
    Active Directory Windows PowerShell.

1.  [] List all the System Mailboxes:

    +++Get-ADUser -Filter 'Name -like "SystemMailbox\*"'+++

1.  [] Do you see the **ProtectedFromAccidentalDeletion** attribute? [Answer]("No")

1.  [] Now run this command:

    +++Get-ADUser -Filter 'Name -like "SystemMailbox\*"'| Get-ADObject -Properties ProtectedFromAccidentalDeletion+++

1.  [] What is the value of the protected from accidental deletion attribute? [Answer]("False")

1.  [] Now run this command to set them to true.

    +++Get-ADUser -Filter 'Name -like "SystemMailbox\*"' | Set-ADObject -ProtectedFromAccidentalDeletion:$True+++

1.  [] Confirm they are set to true by running this command:

    +++Get-ADUser -Filter 'Name -like "SystemMailbox\*"'| Get-ADObject -Properties ProtectedFromAccidentalDeletion+++

===

# End of Lab 8: OAB

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 9A: Mail flow - Transport
-->

# Lab 9A: Mail flow transport

[Modules Overview](#modules)

## Introduction

In this lab, you will learn how to:
-   Enable transport service logs
-   Troubleshoot mail in and out of the organization
-   Test Anti-Malware service

## Objectives 

After completing the exercises, you will be able to:
-   Configure connectors
-   Enable logs for troubleshooting
-   Troubleshoot mail flow
-   Configure and test Anti-Malware service

## Estimated time to complete this lab:

**40** minutes

===

Exercise 1: Configure Front End Transport Service
-------------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Enable logging on the Front End Transport Service and the Hub Transport
    Service.

## Scenario

You have deployed Exchange Server 2019 and need to enable front end and hub
transport service logging, in case you need to troubleshoot any issues.

## Task 1: Enable Protocol Logging for Troubleshooting Front End Transport Service

1.  [] Log on to **CON-CLIENT** using the domain administrator account and create a
    remote PowerShell session to **CON-EX2019N1**.

1.  [] To troubleshoot Client Access Server (CAS) to Mailbox communication, you
    need to enable logging on the **Intra Organization Connector**:

    +++Set-FrontendTransportService con-ex2019n1 -IntraOrgConnectorProtocolLoggingLevel:verbose+++
    
    +++Get-TransportService | Set-TransportService -IntraOrgConnectorProtocolLoggingLevel:verbose+++

    > [!Note]("Log files are located in: C:\\Program Files\\Microsoft\\ExchangeServer\\V15\\TransportRoles\\Logs\\FrontEnd\\ProtocolLog and C:\\Program Files\\Microsoft\\ExchangeServer\\V15\\TransportRoles\\Logs\\ProtocolLog")

===

Exercise 2: Troubleshooting Exchange Server 2019 Mail flow
----------------------------------------------------------

## Objective
After completing this lab, you will be able to:
-   Troubleshoot Exchange Server 2019 Mail Flow

## Scenario

User **User5@contoso.com** is reporting that he cannot receive messages from
the Internet. You need to identify what is causing this and provide a solution.

## Task 0: Move database

1.  [] Before starting the exercise, log on to **CON-EX2019N1** and run the following
command using **EMS**:

    +++Move-ActiveMailboxDatabase -Identity DB-2019-02 -ActivateOnServer con-ex2019n2 -Confirm:$False -ea 0+++

## Task 1: Send Mail Messages to User5@contoso.com

1.  [] Log on to **CON-CLIENT** using the domain administrator account and create a
    remote PowerShell session to **CON-EX2019N1** using ISE.

1.  [] Run the following command to generate mail messages:

    +++1..10 \| Foreach-Object {Send-MailMessage -To User5@contoso.com -From external@external.com -SmtpServer con-ex2019n1 -Subject "Test Message $\_" -Body "This is the body of Message $\_"; write-host "Sending Message $\_"}+++

1.  [] Log onto **CON-Client** using the domain administrator account.

1.  [] Open **OWA** using these credentials:

    - **Username**: +++Contoso\User5+++
    - **Password**: +++LS1setup!+++

1.  [] Did you receive all 10 messages from **external@external.com**? [Answer]("No")

1.  [] You can use the **Get-MessageTrackingLog** command to identify where the messages are queued:

    +++Get-MessageTrackingLog -Recipients user5@contoso.com+++

    ![](media/045268696afd243c6327556990572f52.png)

1.  [] Or you can use the **Get-Queue** command to see where messages are queued:

    +++Get-Queue+++

    ![](media/c14f1da27f5c75fb4eeb23d1800d6544.png)

    +++Get-Queue Con-Ex2019N1\13+++

    ![](media/437ac63826f8b523adde40dbc8bc5cf2.png)

    +++Get-Queue Con-Ex2019N1\13 | fl+++

    ![](media/1f54f509080443ef47f09d423b5049c5.png)

8.  [] Why were they not delivered? [Answer]("Port is blocked ")

1.  Logon to the server **CON-EX2019N2**, in command prompt type:

    +++netsh advfirewall firewall delete rule name=BlockPort475+++

1.  Go to **CON-CLIENT** and run the following command:

    +++11..20 | Foreach-Object {Send-MailMessage -To User5@contoso.com -From external@external.com -SmtpServer con-ex2019n1 -Subject "Test Message $\_" -Body "This is the body of Message $\_" ;  Write-Host "Sending Message $\_"}+++

1.  [] Did you receive the messages from **external@external.com**? [Answer]("Yes")

===

Exercise 3: Testing Exchange Server 2019 Anti-Malware
-----------------------------------------------------

## Objectives

After completing this lab, you will be able to:
-   Test Exchange Server 2019 Auditing Malware

## Scenario

You need to verify and test the newly deployed Exchange Server 2019 Anti-Malware
solution.

## Task 1: Configure Exchange Server 2019 Anti-Malware

1.  [] Log on to **CON-Client** using the domain administrator account.

1.  [] Log onto **EAC** using the **Administrator** account.

1.  [] Click **Protection** and then click **Malware Filter.**

1.  [] Select **Default Policy** and click **Edit** icon  ![](media/265c707992c868763891ea47b817bf46.png) .

1.  [] Click **Settings** and verify the following:

    - **Notify Internal Senders** is Selected.
    - **Notify External Senders** is Selected.
    - Notify Administrators about undelivered messages from **Internal Senders**
    is Selected and **administrator\@contoso.com** is entered as the
    Administrator???s email address.
    - Notify Administrators about undelivered messages from **External Senders**
    is Selected and **administrator\@contoso.com** is entered as the
    Administrator???s email address.

1.  []Click **Save.**

1.  [] Close **Internet Explorer**

## Task 2: Test Exchange Server 2019 Anti-Malware

1.  [] Log on to **CON-CLIENT** using the domain **Administrator** account.

1.  [] Launch **Outlook on the Web** with the following credentials:

    - **Username**: +++Contoso\User1+++
    - **Password**: +++LS1setup!+++

1.  [] Send a message to **User4@contoso.com** with the subject **Testing AV** and
    attach the **EICAR.txt** file in **C:\LABfiles** folder.

1.  [] Sign out of **Outlook on the Web** and sign in again using the following
    credentials:
    - **Username:** +++Contoso\User4+++
    - **Password:** +++LS1setup!+++

1.  [] Did you receive the message? [Answer]("No. This confirms that the anti-malware bloceked the test corrected file.")

===

# End of Lab 9A: Mail flow - Transport

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 9B: Mail flow - Safety Net
-->

# Lab 9B: Mail flow Safety Net

[Modules Overview](#modules)

## Introduction

In this lab, you will explore the Exchange 2019 Safety Net feature.

## Objectives 

After completing the exercises, you will be able to:
-   Understand how Safety Net works
-   Analyze how Safety Net is automatically invoked during lossy \*overs

## Estimated time to complete this lab:

**30** minutes

===

Exercise 1: Safety Net
----------------------

## Objectives 

After completing the exercises, you will be able to:
-   Understand how Safety Net works
-   Analyze how Safety Net is automatically invoked during lossy \*overs

## Task 1: Block DAG replication and generate traffic

1.  [] Log on to **CON-EX2019N1** using the following credentials:

    - **Username**: +++Contoso\Administrator+++
    - **Password**: +++LS1setup!+++

1.  [] Ensure **DB-2019-01** is mounted on **CON-EX2019N1**:

    +++Get-MailboxDatabase db-2019-01 | Get-MailboxDatabaseCopyStatus+++

1.  [] If mounted on **CON-EX2019N2**, activate the database on **CON-EX2019N1**:

    +++Move-ActiveMailboxDatabase DB-2019-01 -ActivateOnServer con-ex2019n1 -ErrorAction SilentlyContinue+++

1.  [] Block inbound and outbound replication traffic on the **CON-EX2019N1**
    server by running the following commands:

    +++netsh advfirewall firewall add rule name="BlockTCP64327" protocol=TCP dir=out remoteport=64327 action=block+++
    
    +++netsh advfirewall firewall add rule name="BlockTCP64327" protocol=TCP dir=in localport=64327 action=block+++

1.  Wait for one minute and ensure **DB-2019-01\CON-EX2019N2** passive copy
    is **DisconnectedAndHealthy**:

    +++Get-MailboxDatabase DB-2019-01 | Get-MailboxDatabaseCopyStatus |  ft -a+++

1.  [] Send test messages to a user in **DB-2019-01** database:

    +++1..10 \| % {Send-MailMessage -To User1@contoso.com -From external@external.com -SmtpServer con-ex2019n1 -Subject "Safety Net Test Message $\_" -Body "This is the body of Message $\_" ; write-host "Sending Message $\_"}+++

1.  [] Ensure the passive copy is still **DisconnectedandHelathy** and the copy
    queue length is greater than or equal to 1.

    +++Get-MailboxDatabase DB-2019-01 | Get-MailboxDatabaseCopyStatus | ft -a+++

## Task 2: Simulate a Lossy Failure and analyze message resubmissions

1.  [] Log on to **CON-EX2019N1** using the following credentials:

    - **Username**: +++Contoso\\Administrator+++
    - **Password**: +++LS1setup!+++

1.  [] Switchover **DB-2019-01** to **CON-EX2019N2** by running this command:

    +++Move-ActiveMailboxDatabase DB-2019-01 -ActivateOnServer con-ex2019n2 -MountDialOverride:Besteffort -SkipLagChecks+++

1.  [] Search the message tracking logs:

    +++Get-TransportService | Get-MessageTrackingLog -MessageSubject "Safety Net Test Message"+++

1.  [] Do you see **RESUBMIT** eventid and what does this event indicate? [Answer]("See mails resubmitted from Safety Net.  ![](media/16f8e8fa548d9e35993a88fcf054ec37.png)               ![](media/3782fb58ec13a267c419807fe5d05e5b.png)  ")

1.  [] Utilize **Get-ResubmitRequest** to see how many messages were resubmitted.

    +++Get-ResubmitRequest+++

1.  [] Logon to **OWA** using **USER1** on **CON-CLIENT**. Ensure that all test
    messages were received.

1.  [] Change firewall settings of **CON-Ex2019N1** to allow traffic.

    +++netsh advfirewall firewall delete rule name="BlockTCP64327" protocol=TCP dir=out remoteport=64327+++
    
    +++netsh advfirewall firewall delete rule name="BlockTCP64327" protocol=TCP dir=in localport=64327+++

===

# End of Lab 9B: Mail flow - Safety Net

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 10: Managed store
-->

# Lab 10: Managed Store

[Modules Overview](#modules)

## Introduction

In this lab, we will troubleshoot a connectivity issue using Outlook on the Web.

## Objectives

After completing this lab, you will be able to:
-   Retrieve logs from Microsoft Exchange servers
-   How to use them to troubleshoot connection issue

## Estimated time to complete this lab

**60** minutes

===

Exercise 1: Mailbox Creation
----------------------------

#### Objective

After completing this lab, you will be able to:
-   You will be able to create a Mailbox.

## Scenario

You are an Exchange Server 2019 Administrator. You want to create mailboxes and
take advantage of the automatic, even distribution among databases, but the
result is not what was expected.

## Task 1: Mailbox Creation

1.  [] Log onto **Con-Client**, open a remote PowerShell session (use sample script
    **c:\labfiles\exconn.ps1** if needed) to
    **CON-Ex2019N1.** and then run the command:

    +++Get-MailboxDatabase+++

1.  [] How many Exchange Server 2019 databases are there? [Answer]("6 databases      ![](media/54285268c9d6a04723fd40ddbbe8c8a9.png)")

1.  Now create some mailboxes, by running the following command:

    +++52..70 | Foreach {New-Mailbox -Name User$\_ -Alias User$\_ -DisplayName "User$\_" -Password (ConvertTo-SecureString "LS1setup!" -AsPlainText -Force) -UserPrincipalName "user$_@contoso.com" -OrganizationalUnit "contoso.com/Accounts"}+++

1.  [] After creating the mailboxes, run the following command:

    +++Get-Mailbox -anr User | ft -a name, servername, database+++

1.  [] Do you see an even distribution among the Exchange 2019 databases for the newly
created mailboxes (User52-user70) [Answer]("No, only DB1 and DB2 got mailboxes created.")

1.  [] Can you explain why there are no mailboxes created on DB-2019-03? [Answer]("DB-2019-03 is excluded from provisioning.   ![](media/9e0fee71e83da7bf5b6b0e44047deeda.png) ")

1.  Solve the issue for **DB-2019-03** (DB-2019-04 should stay dismounted) [Answer]("Set-MailboxDatabase DB-2019-03  -IsExcludedFromProvisioning $false")

1.  [] Try to create additional mailboxes again to see if they distribute between 3 of the DB's:

    +++71..90 \| ForEach {New-Mailbox -Name User$\_ -Alias User$\_ -DisplayName "User$\_" -Password (ConvertTo-SecureString "LS1setup!" -AsPlainText -Force) -UserPrincipalName "user$_@contoso.com" -OrganizationalUnit "contoso.com/Accounts"}+++

1.  [] Are the newly created mailboxes evenly distributed among DB-2019-01,
    DB-2019-02, and DB-2019-03? [Answer]("Yes")

===

Exercise 2: Put a server into maintenance mode
----------------------------------------------

## Objectives

You need to patch your DAG members properly by putting them into maintenance
mode.
-   You will be able to put a server into and out of maintenance mode.

## Scenario

You are an Exchange Server 2019 administrator. You need to perform your monthly
update process. During this process, you need to ensure that users are not
impacted by any outage and that the servers are fully updated.

## Task 1: Place server into maintenance mode

1.  [] Log onto **Con-Client** and perform each of the commands in a remotely
    connected PowerShell session (use sample script
    **c:\labfiles\exconnect.ps1** if needed) to **CON-Ex2019N1**.

1.  [] Stop the message delivery by running the following commands:  

    +++Set-ServerComponentState CON-EX2019N1 -Component HubTransport -State Draining -Requester Maintenance+++
    
    +++Invoke-Command -ComputerName con-ex2109n1 -scriptblock {Restart-Service MSExchangeTransport}+++
    
    +++Redirect-Message -Server CON-EX2019N1 -Target CON-EX2019N2.contoso.com+++
    
    +++Get-ServerComponentState CON-EX2019N1 -Component HubTransport+++

1.  [] Stop and move the Cluster node service by running the following commands:

    +++Get-DatabaseAvailabilityGroup -Status | fl Name,PrimaryActiveManager+++
    
    +++Invoke-Command -ComputerName CON-EX2019N1 {Move-ClusterGroup "Cluster Group" -Node CON-EX2019N2}+++
    
    +++Invoke-Command -ComputerName CON-EX2019N1 {Suspend-ClusterNode CON-EX2019N1}+++
    
    +++Invoke-Command -ComputerName CON-EX2019N1 {Get-ClusterNode}+++
    
    +++Get-DatabaseAvailabilityGroup -Status | fl Name,PrimaryActiveManager+++

1.  [] Stop the Mailbox service by running the following commands:

    +++Get-MailboxDatabaseCopyStatus -Server CON-EX2019N1+++
    
    +++Get-MailboxDatabaseCopyStatus -Server CON-EX2019N1 | Where-Object {$_.Status -eq "Mounted"} | Foreach-Object {Move-ActiveMailboxDatabase $\_.DatabaseName -ActivateOnServer CON-EX2019N2 -Confirm:$false}+++
    
    +++Get-MailboxDatabaseCopyStatus -Server CON-EX2019N2+++
    
    +++Set-MailboxServer CON-EX2019N1 -DatabaseCopyAutoActivationPolicy Blocked+++
    
    +++Get-MailboxServer CON-EX2019N1 | ft Name,DatabaseCopyAutoActivationPolicy+++
    
    +++Set-ServerComponentState CON-EX2019N1 -Component ServerWideOffline -State Inactive -Requester Maintenance+++
    
    +++Get-ServerComponentState CON-EX2019N1 -Component ServerWideOffline+++

1.  [] Once completed those commands, you have now placed the **CON-EX2019N1** server into the maintenance mode. Now you can apply updates and restart the server as needed.

## Task 2: Take server out of maintenance mode

1.  [] Log onto **Con-Client** and perform each of the commands in a remotely
    connected PowerShell session to **CON-Ex2019N1** to take the Exchange Server
    out of the maintenance mode.

1.  [] To enable the mailbox service:

    +++Set-ServerComponentState CON-EX2019N1 -Component ServerWideOffline -State Active -Requester Maintenance+++
    
    +++Get-ServerComponentState CON-EX2019N1 -Component ServerWideOffline+++

1.  [] To enable the Cluster node service:

    +++Invoke-Command -ComputerName CON-Ex2019N1 {Resume-ClusterNode CON-EX2019N1}+++
    
    +++Invoke-Command -ComputerName CON-Ex2019N1 {Get-ClusterNode}+++

1.  [] Set the database availability for the server by running the following
    command:

    +++Set-MailboxServer CON-Ex2019N1 -DatabaseCopyAutoActivationPolicy Unrestricted+++
    
    +++Get-MailboxServer CON-Ex2019N1 | ft Name, DatabaseCopyAutoActivationPolicy+++

1.  [] Enable hub transport by running the following command:

    +++Set-ServerComponentState CON-Ex2019N1 -Component HubTransport -State Active -Requester Maintenance+++
   
    +++Invoke-Command -ComputerName CON-Ex2019N1 -scriptblock {Restart-Service MSExchangeTransport}+++
    
    +++Get-ServerComponentState CON-Ex2019N1 -Component HubTransport+++

1.  [] Run the following command to confirm that the server is no longer in the
    maintenance mode:

    +++Get-ServerComponentState CON-Ex2019N1 | ft Component, State -AutoSize+++

===

# End of Lab 10: Managed Store

===

<!--
WorkshopPLUS - Exchange: Administration and Troubleshooting
Module 11: Workload Management and Managed Availability
-->

# Lab 11: Workload Management and Managed Availability

[Modules Overview](#modules)

## Introduction

In this lab, we will troubleshoot a connectivity issue using Outlook on the Web.

## Objectives

After completing this lab, you will be able to:
-   Retrieve logs from Microsoft Exchange servers
-   How to use them to troubleshoot connection issue

## Estimated time to complete this lab

**30** minutes

===

# Exercise 1: Simulate a service failure

#### Objective

After completing this lab, you will be able to:
-   Understand how Manage Availability works
-   Review actions performed by Managed Availability

## Scenario

You have deployed Exchange Server 2019 Database Availability Group (DAG) and added a couple of Mailbox servers. You heard Exchange Server 2019 has  the feature of Managed Availability, which continuously monitors all the Exchange Server components and takes corrective actions if any of the component fail. You decide to simulate manual failure to test this feature.


## Task 1: Create a service failure

1.  [] Log onto **Con-Client**, open a remote PowerShell session (use sample script
    **c:\labfiles\exconn.ps1** if needed) using the account **Contoso\Administrator**, and the password of **LS1setup!** to **CON-Ex2019N1.**

1. [ ] Ensure **DB-2019-01** is mounted on **CON-EX2019N1** by running this command:

    +++Get-MailboxDatabaseCopyStatus -Identity DB-2019-01 | FT status, name+++

1. [ ] If mounted on **CON-EX2019N2**, activate the database on **CON-EX2019N1** by running this command: 

    +++Move-ActiveMailboxDatabase DB-2019-01 -ActivateOnServer CON-EX2019N1+++

1.	[ ] Check the status of **HealthSets** that are **Unhealthy** on server **CON-EX2019N1** by running this command:

    +++Get-Healthreport -Server con-ex2019n1 | Where-Object {$_.alertvalue -eq 'Unhealthy'} | ft -a healthset,alertvalue,lasttransitiontime,monitorcount+++

1.	[ ] Set **Microsoft Exchange RPC Client Access** startup setting to **disabled** and stop the service by running these commands: 

    +++Get-Service msexchangerpc -ComputerName CON-EX2019N1 | Stop-Service+++ 
    
    +++Get-Service msexchangerpc -ComputerName CON-EX2019N1 | Set-Service -StartupType disabled+++

1.	[ ] Check the health of the server after 2 minutes by running this command:

    +++Get-Healthreport -Server con-ex2019n1 | Where-Object {$_.alertvalue -eq ???Unhealthy???} | ft -a healthset,alertvalue,lasttransitiontime,monitorcount+++

1. [ ] What is the Healthset that has newly entered the **Unhealthy** state?  [Answer]("Can be some or all of the following: Store, DataProtection, MailboxSpace, ActiveSync.Protocol, Monitoring, Compliance, ECP, Outlook.")

1. [ ] To check the **HealthSet** monitors of the **Outlook.Protocol**, run this command:

    +++Get-ServerHealth -Server con-ex2019n1 -HealthSet Outlook.protocol+++

1. [ ] Using the **Get-MailboxDatabaseCopyStatus** command to monitor the status of **Database DB-2019-01** for 1 minute, run this command:

    +++Get-MailboxDatabaseCopyStatus DB-2019-01 | ft status, name+++.

===

## Task 2: Review and investigate Managed Availability actions

1.  [ ] Log onto **Con-Client**, open a remote PowerShell session (use sample script
    **c:\labfiles\exconn.ps1** if needed) using the account **Contoso\Administrator**, and the password of **LS1setup!** to **CON-Ex2019N1**.

1.	[ ] Open **Event Viewer**, and **Connect to Another Computer...****CON-Ex2019N1**.

    ![](media/11_3.png)

1.  [ ] And enter the value of **CON-Ex2019N1**:

    ![](media/11_4.png)

1.  [ ] Navigate to **Applications and Services Logs > Microsoft > Exchange > ManagedAvailability > RecoveryActionLogs**.

    ![](media/11_1.png)
???
1.  [ ]	Locate Information events with **Event ID 1023** from **ManagedAvailability** indicating Failover.

    ![](media/11_2.png)

1.  [ ] Use **Remote PowerShell** to retrieve the events that caused the failover by running this code:

    ```powershell
    $time = (Get-Date).addminutes(-30)

    Get-WinEvent -ComputerName CON-EX2019N1 -FilterHashtable @{Logname="Microsoft-Exchange-ManagedAvailability/RecoveryActionLogs??? ; starttime=$time.date;Level=2} | fl id,message

    Get-WinEvent -ComputerName CON-EX2019N1 -FilterHashtable @{Logname="Microsoft-Exchange-ManagedAvailability/RecoveryActionResults" ; starttime=$time.date;Level=2} | fl id,message
    ```

1.  [ ] Reset **Microsoft Exchange RPC Client Access** startup setting to **Automatic** and start the service by running these commands:

    +++Get-Service msexchangerpc -ComputerName CON-EX2019N1 | Set-Service -StartupType Automatic+++
    
    +++Get-Service msexchangerpc -ComputerName CON-EX2019N1 | Start-Service+++

1.	[ ] Use the **Get-MailboxDatabaseCopyStatus** command to monitor the status of Database **DB-2019-01** for 1 minute: 

    +++Get-MailboxDatabaseCopyStatus DB-2019-01 | ft status, name+++.

1.  [ ] What are the results of running the command above?  [Answer]("All values should be in a healthy state.")

1.  [ ] To view the status of all databases, run this command:

    +++Get-MailboxDatabaseCopyStatus+++

1.  [ ] What are the results of running the command above?  [Answer]("All databases should be mounted. If any of the databases are not mounted, those processes were covered in early modules.")

===

# End of Lab 11: Workload Management and Managed Availability

===

# These lab lessons are now complete. Congratulations @lab.User.FirstName! 

Click **End** to **End my lab and mark it as complete** or **Cancel my lab** from the upper right hand corner of the lab browser. 

You can also **save** the lab for use in the next few days. While you have access to the VM's for 6 months, if you don't log into them every few days, they will reset and you'll lose any code you have saved within the environment. 

===


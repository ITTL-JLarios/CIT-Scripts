import os
from program.manager import ScriptManager

# Root Paths
root = os.path.join('.', 'program')
installers = os.path.join(root, 'installers')
scripts = os.path.join(root, 'scripts')

# scripts path
checker = os.path.join(scripts, 'Checker.ps1')
gcpw = os.path.join(scripts, 'AuthProvide.ps1')
installer_sftw = os.path.join(scripts, 'ToolsInstaller.ps1') # installer of software

# Script Manager
sm = ScriptManager()

# Options and settings for scripts 
sm.powershell_call(checker)

# Activate app id service
app_id_service = input('[>] Do you want to start Application Identity? (y/n) default(yes)  ')
if (app_id_service == 'y' or app_id_service == 'yes' or not app_id_service):
    sm.powershell_call('sc.exe config appidsvc start=auto')

# Install Google Credential for Windows
install_gcpw =  input('[>] Do you want to install GCPW? (y/n) default(yes)  ')
if (install_gcpw == 'y' or install_gcpw == 'yes' or not install_gcpw):
    sm.powershell_call(gcpw)

# Install programs
installers_list = sm.read_installers(installers)
print("[>] Choose what programs do you want to install")
print("[>] Installers :")
[print(index, installer) for index, installer in enumerate(installers_list)]
installer_options = input('Enter a for all or a list of numbers: ')

if installer_options == "a" or installer_options == "all" :
    sm.install_tools(installers_list, installer_sftw, installers)
elif "," in installer_options:
    opts = installer_options.split(",")
    opts = [installers_list[int(opt)] for opt in opts]
    sm.install_tools(opts, installer_sftw, installers)
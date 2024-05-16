import subprocess, sys, os

class ScriptManager:
    def __init__(self) -> None:
        pass

    def powershell_call(self, cmdlet: str) -> None:
        p = subprocess.Popen(["powershell.exe", cmdlet], 
                                stdout=sys.stdout)
        p.communicate()
    
    def powershell_return(self, cmdlet: str) -> str:
        p = subprocess.Popen(["powershell.exe", cmdlet],
                                stdout=subprocess.PIPE)
        out, err = p.communicate()
        return out
    
    def read_installers(self, root: str) -> list[str]:
        results = []
        for directory, subdir_list, file_list in os.walk(root):
            results = [ name for name in file_list ]

        return results
    
    def install_tools(self, installers_list: list[str], script: str, dir: str) -> None:
        for installer in installers_list:
            if ".msi" in installer:
                self.powershell_call( f"{script[0]} -$Pkg {os.path.join(dir, installer)}")
            elif ".exe" in installer:
                self.powershell_call( f"{script[1]} -PName {installer} -Path {os.path.join(dir, installer)}")

    def pwsh_install_tools(self, script: str, list_app_ids: list[str]) -> None:
        for app in list_app_ids:
            self.powershell_call(f"{script} -PName {app}")
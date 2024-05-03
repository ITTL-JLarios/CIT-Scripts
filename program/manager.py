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
            self.powershell_call( f"{script} -Name {installer} -Path {os.path.join(dir, installer)}")
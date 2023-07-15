# getPackages: use pisi to get all pkgs
def getPackages():
    import pisi.api
    return pisi.api.list_available()
# Setup

```powershell
choco install -y emacs
.\install.ps1
```

# Set org directory

Right now it's set to

```
(setq org-directory (concat (getenv "USERPROFILE") "\\OneDrive - Microsoft\\org"))
```

# =====================================
# PowerShell Script: Quick GitHub Repo Setup
# Function:
#   - Initialize a new Git repo
#   - Optionally create a GitHub repo (private/public)
#   - Optional local-only mode to skip remote creation
# Prereq: Powershell, Git and Github CLI
# =====================================

Param(
    [switch]$LocalOnly  # Use this flag to only init local repo, skip remote creation
)

# --------------------------
# Interactive input for repo name
# --------------------------
$repoName = Read-Host "Enter repository name"

# --------------------------
# Initialize local Git repo
# --------------------------
git init
git branch -m main

# --------------------------
# If local-only flag is NOT set, handle remote creation
# --------------------------
if (-not $LocalOnly) {

    do {
        $visibility = Read-Host "Should the repo be private or public? (private/public)"
        $visibility = $visibility.ToLower()
    } while ($visibility -ne "private" -and $visibility -ne "public")

    $ghFlag = if ($visibility -eq "private") { "--private" } else { "--public" }

    # Create GitHub repo
    gh repo create $repoName $ghFlag

    # Add all files and make initial commit
    git add .
    git commit -m "Initial commit"

    # Push to GitHub
    git push -u origin main

    Write-Host "`nRepo '$repoName' created and pushed to GitHub successfully!"
}
else {
    Write-Host "`nLocal Git repo '$repoName' initialized. Remote creation skipped."
}

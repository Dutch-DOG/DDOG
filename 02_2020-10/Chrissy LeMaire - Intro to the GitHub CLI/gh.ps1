# 💥 Blammo 💥
Get-ChildItem | gh gist create



#region issues
cd C:\github\dbatools
gh issue list
gh issue view 6886
# easy to understand visuals and navigation - RUN THIS ON PS CORE!
gh issue list -R powershell/powershell | Out-ConsoleGridView

#prompts for input
gh issue create
#endregion

#region core gh
# Don't have to remember commands, they're very straightforward
gh

# Autocomplete provided!
gh completion --shell powershell >> $profile
. $profile

#region jk
# just kidding! Add this to $profile instead
Invoke-Expression (@(gh completion -s powershell) -replace " ''\)$", " ' ')" -join "`n")
# do ctrl-space
#endregion
#endregion


#region login
Invoke-Item "$home\.config\gh"
gh auth logout
# dem prompts, created with the beginners in mind 😍
gh auth login
#endregion

#region pr

cd C:\github\dbatools
gh pr list
# lots of information is presented, but it's easy to understand
gh pr diff 6868


# no branching built in (yet?), but you can switch to a pr branch
# Condenses complicated processes into simple actions
gh pr checkout 6868

# Manage pull requests :O
gh pr review 6868
#gh pr merge 6868 --delete-branch

#endregion


#region clone repo
cd C:\github
gh repo clone https://github.com/potatoqualitee/masktest
#endregion

#region create a repo
cd C:\github
gh repo create clirepo
cd C:\github\clirepo
#endregion


#region Create an issue! Before, you'd have to use a Ruby gem.
gh issue create --title "Update database" --body "Just kidding. This is a test from ``gh issue create``"
gh issue view 1 --web
#endregion


#region old school git
# yuck
"# clirepo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/potatoqualitee/clirepo.git
git push -u origin main

# then do this
git checkout -b test
"test" | Set-Content test.txt
git add .
git commit -m "Add existing file"
git push --set-upstream origin test
#endregion

#region new pr
# Create a PR (git has request-pull but it's pas bon 👎🏼)
gh pr create --title "Test from the command line" --body "Crosses fingers"
gh pr view --web
#endregion


#region API Fun 🥳
# Sup jaap
gh api /users/jaapbrasser/repos | ConvertFrom-Json -OutVariable jaaprepo
$jaaprepo.name

cd C:\github\dbatools
(gh api repos/:owner/:repo/releases | ConvertFrom-Json).Name

cd C:\github\psmodulecache
gh api repos/:owner/:repo/actions
gh api repos/:owner/:repo/workflows
#endregion


#region aliases
cd C:\github\dbatools
gh alias set bugs 'issue list --label="bugs"'
gh bugs
gh alias set bugs 'issue list --label="bugs_life"'
gh bugs

gh alias set prweb "pr create --fill --body '' --web"
gh alias set --shell newbranch 'git checkout -b $1'
gh alias set --shell push 'git push -u origin $(git branch --show-current)'
gh newbranch test2
gh push

gh alias set --shell branches "git branch -vva"
gh alias set --shell cd 'git checkout $1'

gh alias set --shell ggrep 'gh issue list --label="$1" | Select-String $2'
gh ggrep bugs_life Start-DbaMigration


# want a space? like gh branch list?

gh alias set --shell branch 'if [ $1 == "list" ]
then
git branch -vva
elif [ $1 == "checkout" ]
then
gh checkout $1
else
echo nothing
fi'

gh branch list

# Get positively crazy

# from https://gist.github.com/doi-t/5735f9f0f7f8b7664aa6739bc810a2cc
gh alias set listMilestones "api graphql -F owner=':owner' -F name=':repo' -f query='
    query ListMilestones(`$name: String`!, `$owner: String`!) {
        repository(owner: `$owner, name: `$name) {
            milestones(first: 100) {
                nodes {
                    title
                    number
                    description
                    dueOn
                    url
                    state
                    closed
                    closedAt
                    updatedAt
                }
            }
        }
    }
'"
#endregion

#region conclude
Get-Content C:\Users\ctrlb\.config\gh\config.yml | gh gist create
Get-Content C:\Users\ctrlb\Desktop\gh.ps1 | gh gist create
#endregion
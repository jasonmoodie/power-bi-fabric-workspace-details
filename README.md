# PowerShell Script for Exporting a List of Microsoft Fabric and Power BI Workspaces


```powershell
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Remove comment to install the module
# Install-Module -Name MicrosoftPowerBIMgmt

# Ensure user has Fabric Administrator assigned in M365 admin portal
Login-PowerBI     

# Get all workspaces
$workspaces = Get-PowerBIWorkspace -Scope Organization -All

# get count of workspaces
$workspaces.Count

# Loop through each workspace and get its users
foreach ($workspace in $workspaces) {

    # Loop through users in the workspace
    $userDetails = @()
    foreach ($user in $workspace.Users) {

        # Construct a pipe-separated string for each user
        $userDetailString = "$($workspace.Id)| $($workspace.Name)| $($user.UserPrincipalName)| $($user.AccessRight)| $($user.PrincipalType)| $($workspace.State)| $($workspace.Type)"
        # Append the string to the array
        $userDetails += $userDetailString
    }
    # $userDetails | Format-Table -AutoSize
    $output += $userDetails
}

# Export the collected output to a text file
$output | Out-File -FilePath "C:\output.txt" -Encoding utf8
```

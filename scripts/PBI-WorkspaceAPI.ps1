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

# List All Workspaces
$workspaces = Get-PowerBIWorkspace -Scope Organization -Include All
 
#List all users in each workspace
foreach($workspace in $workspaces){
    # Ensure only workspaces are returned
    if($workspace.Type -eq "Workspace"){
        $workspaceID = $workspace.id
        $url = "https://api.powerbi.com/v1.0/myorg/groups/$workspaceID/users"
    
        $userJsonResponse = Invoke-PowerBIRestMethod -Url $url -Method Get
        $userWorkspace = $userJsonResponse | ConvertFrom-Json

        # Display user details in a pipe-separated list
        $userWorkspace.value | ForEach-Object {
            $userDetails = "$($workspace.id)| $($workspace.name)| $($_.displayName)| $($_.emailAddress)| $($_.groupUserAccessRight)`n"
            # Uncomment the line below to display the user details in the console
            # Write-Host $userDetails
            $output += $userDetails
        }
    }   
}

# Export the collected output to a text file
$output | Out-File -FilePath "C:\Code\power-bi-fabric-workspace-details\samples\output.txt" -Encoding utf8
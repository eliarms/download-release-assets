# Download Release Assets from Github

This action downloads an Asset from a private repo Github release.

## Inputs

| Input                                             | Description                                        |
|------------------------------------------------------|-----------------------------------------------|
| `github_token`  | A Github Access Token to access repository. |
| `repository`_(optional)_ | The `owner/repository`. Defaults to the current repository |
| `release` _(optional)_  | The release version to fetch from. Default `"latest"`. If not `"latest"`, this has to be in the form `tags/<tag_name>` or `<release_id>`.   |

### Outputs

| Output                                             | Description                                        |
|------------------------------------------------------|-----------------------------------------------|
| `artifact_name`  | The name of the downloaded artifact |
| `result`  | The state of the action (returns 'success')|


## Example usage

# Smallest Configuration

```yaml
uses: eliarms/download-release-assets@v1
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
```

# Custom Repository Configuration

```yaml
uses: eliarms/download-release-assets@v1
with:
  repository: eliarms/cloudfront-signer
  github_token: ${{ secrets.GITHUB_TOKEN }}
```

# Custom Release Configuration

```yaml
uses: eliarms/download-release-assets@v1
with:
  release: latest
  github_token: ${{ secrets.GITHUB_TOKEN }}
```

# Custom Release and Repository Configuration

```yaml
uses: eliarms/download-release-assets@v1
with:
  repository: eliarms/cloudfront-signer
  release: latest
  github_token: ${{ secrets.GITHUB_TOKEN }}


  
### Example workflow

```yaml
name: My Workflow
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    
    - name: Dwonload release Asset
      uses: eliarms/download-release-assets@v1
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}


  ### Using the outputs variables in another action

```yaml
steps:
- uses: actions/checkout@master

- name: Dwonload release Asset
  id: downloadassets
  uses: eliarms/download-release-assets@v1
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
- name: Display Artifacts name
    run: |
    echo "Package Name - ${{ steps.downloadassets.outputs.artifact_name }}"      
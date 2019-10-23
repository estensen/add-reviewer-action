# add-reviewer-action
This action to add reviewer to PR

## Inputs

### `username`

**Required** The GitHub username to add as a reviewer

### `github_token`

**Required** The GitHub token for the repository

## Example usage

```
name: Add Reviewer

on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@master

    - name: Add reviewer to PR
      uses: estensen/add-reviewer-action@master
      with:
        username: 'estensen'
        github_token: ${{ secrets.GITHUB_TOKEN }}
```

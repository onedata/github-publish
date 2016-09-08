# Publishing Onedata repos to Github

A docker service for syncing repos.

To build:

`docker build -t github-publish . `

To run:

```
docker run -it --rm --name github-publish -v ~/.ssh/id_bamboo:/id_bamboo  -v ~/.ssh/onedata_github:/onedata_github -v ~/repos:/tmp  github-publish
```

Further more there are 3 scripts in `/bin`
### sr-publish

`sr-publish` bash script (requirers bash 4.3, attention OSX users!), that takes a path to a local or remote repo, list of branches/tags, a link to a remote repo, and performs `git push -f`.  For more intormation use `sr-publish -h`.

The example execution of:

```
sr-publish -s ssh://git@git.plgrid.pl:7999/vfs/op-worker.git --src-key  id_bamboo -d ssh://git@github.com/onedata/op-worker.git --dest-key onedata_github -b 'master develop release/*' -t '*' --tmp-dir /tmp
```

causes execution of following bash commands:

One of multiple checks that asses if source and remote repos are correct etc.
```
GIT_SSH_COMMAND=ssh -i /Users/orzech/.ssh/id_rsa git ls-remote --exit-code ssh://git@git.plgrid.pl:7999/vfs/op-worker.git
```

Fetch that gets all the changes
```
GIT_SSH_COMMAND=ssh -i /Users/orzech/.ssh/id_rsa git -C /tmp/op-worker.git fetch --progress origin *:* -f --tags --prune
```

Fetch that gets all the changes
```
GIT_SSH_COMMAND=ssh -i /Users/orzech/.ssh/id_rsa git -C /tmp/op-worker.git fetch --progress origin *:* -f --tags --prune
```

Push that pushes only selected branches/tags
```
GIT_SSH_COMMAND=ssh -i /Users/orzech/.ssh/id_rsa git -C /tmp/op-worker.git push --progress -f ssh://git@github.com/onedata/op-worker.git refs/tags/*:refs/tags/* refs/heads/master:refs/heads/master refs/heads/develop:refs/heads/develop refs/heads/release/*:refs/heads/release/*
```

If you are not certain what your doing use `--dry-run` and '-vvv' flags for maximum verbosity.

### github-publish

`github-publish` python script that takes a configuration of config.yml and invokes `sr-publish` for every repo.

### loop.sh

`bin/loop.sh` that executes `github-publish` in a loop with sleep time of 300 sec or other if specified.



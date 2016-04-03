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

`sr-publish` bash script (requirers bash 4, attention OSX users!), that takes a path to a local or remote repo, list of branches/tags, a link to a remote repo, and performs `git push -f`.  For more intormation use `sr-publish -h`.

The example execution of:

```
sr-publish -s ssh://git@git.plgrid.pl:7999/vfs/op-worker.git --sid  id_bamboo -d ssh://git@github.com/onedata/op-worker.git --did onedata_github -b 'master develop release/*' -t '*' --tmpdir /tmp
```

causes execution of following bash commands:

```
ssh-agent bash -c ssh-add id_bamboo ; git -C /tmp/ clone --bare ssh://git@git.plgrid.pl:7999/vfs/op-worker.git
```

```
ssh-add onedata_github ; git -C /tmp/op-worker.git push -f ssh://git@github.com/onedata/op-worker.git refs/tags/*:refs/tags/* refs/heads/master:refs/heads/master refs/heads/develop:refs/heads/develop refs/heads/release/*:refs/heads/release/*
```

If you are not certain what your doing use `--dry-run` flag.

### github-publish

`github-publish` python script that takes a configuration of config.yml and invokes `sr-publish` for every repo.

### loop.sh

`bin/loop.sh` that executes `github-publish` in a loop with sleep time of 300 sec or other if specified.



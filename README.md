# Publishing Onedata repos to Github

This repository consists of:

### bin/sr-publish

a bash script that requirers bash 4 (attention OSX users!), that takes a path to a local or remote repo, list of branches/tags, a link to a remote repo, and performs `git push -f`.  For more intormation use `sr-publish -h`.

The example execution of:

`sr-publish -s ssh://git@github.com/onedata/op-worker.git --sid bamboo_id -d https://github.com/me/my_public_repo --did onedata_github -b 'master develop release/*' -t '*'`

`ssh-agent bash -c ssh-add onedata_github ; git -C /tmp/op-worker.git push -f ssh://git@github.com/onedata/op-worker.git refs/tags/*:refs/tags/
* refs/heads/master:refs/heads/master refs/heads/develop:refs/heads/develop refs/heads/release/*:refs/heads/release/*`


